import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Script/socketioScript.dart';
import '../Models/model.dart';

String getGender(Gender gender) {
  switch (gender) {
    case Gender.Male:
      return 'male';
      break;
    case Gender.Female:
      return 'female';
      break;
    default:
      return 'male';
      break;
  }
}

// calculate age
int getAge(DateTime dob) {
  return ((DateTime.now().difference(dob).inDays) / 365).floor();
}

class SymptomAssessmentProvider with ChangeNotifier {
  Gender gender;
  DateTime dob;

  var symptomSearching = false;
  List<dynamic> symptomSearchList = [];

  var diagnosticLoading = false;
  Map<dynamic, dynamic> diagnosticData = {};

  var sendingTriage = false;
  Map<String, dynamic> triage;
  String triage_level = '';

  var conditionDetailLoading = false;
  Map<String, dynamic> conditionDetail = {};

  List<Map<String, dynamic>> evidence = [];
  List<dynamic> conditions = [];
  List<dynamic> selectedSymptom = [];

  String tpid = '';
  String apid = '';

  // assign gender and dob
  void init(DateTime birthDate, Gender userGender) {
    gender = userGender;
    dob = birthDate;
  }

  Future<void> searchSymptom(String phrase) async {

    // create payload to send in initSymptom
    Map<String, dynamic> searchMap = {
      'phrase': phrase,
      'sex': getGender(gender),
      'age': getAge(dob),
      'max_results': 8,
      'types': ''
    };

    symptomSearching = true;

    // emit data to initSymptom
    socketIO.emit('event', [
      {
        'transaction': 'initSymptoms',
        'payload': searchMap,
      }
    ]).then((_) {
      // wait response for initSymptom
      socketIO.on('r-initSymptoms').listen((data) {
        symptomSearchList = data[0]['value']['payload'];
        symptomSearching = false;
        notifyListeners();
      });
    });
  }

  // add evidenc to evidence list
  void addEvidence(Map<String, dynamic> evd) {
    if (!evidence.contains(evd))
      evidence.add(evd);
  }

  // send diagnostic data
  Map<String, dynamic> sendDiagnostic() {

    // create payload to send in diagnose
    Map<String, dynamic> sendDiagnosis = {
      'sex': getGender(gender),
      'age': {
        'value': getAge(dob),
        'unit': 'year',
      },
      'evidence': evidence,
      'extras': {
        'disable_groups': true,
        'include_condition_details': true,
      }
    };

    diagnosticLoading = true;
    // emit data to diagnose
    socketIO.emit('event', [
      {
        'transaction': 'diagnose',
        'payload': sendDiagnosis,
      }
    ]).then((_) {
      // wait response of diagnose
      socketIO.on('r-diagnose').listen((data) {
        diagnosticData = data[0]['value']['payload'];
        if (diagnosticData['should_stop'] == true) {
          conditions = diagnosticData['conditions'];
        }
        diagnosticLoading = false;
        notifyListeners();
      });
    });
  }

  // send traige data
  Future<void> sendTriage() async {

    // create payload to send in triageAssessment
    Map<String, dynamic> sendTriageData = {
      'sex': getGender(gender),
      'age': {
        'value': getAge(dob),
        'unit': 'year',
      },
      'evidence': evidence,
      'extras': {
        'disable_groups': true,
        'include_condition_details': true,
      }
    };

    // emit data to triageAssessment
    await socketIO.emit('event', [
      {
        'transaction': 'triageAssessment',
        'payload': sendTriageData,
      }
    ]);


    // wait response of triageAssessment
    await for (dynamic data in socketIO.on('r-triageAssessment')) {
      triage = data[0]['value']['payload'];
      triage_level = data[0]['value']['payload']['triage_level'];
      break;
    }
    Future.delayed(Duration(seconds: 1)).then((_) {
      sendingTriage = true;
      notifyListeners();
    });
  }

  // get more detail of condition
  Future<void> getMoreConditionDetail(String cid) async {
    conditionDetailLoading = true;
    notifyListeners();

    // emit data to get-condition-detail
    await socketIO.emit('event', [
      {
        'transaction': 'get-condition-detail',
        'payload': {
          'cid': cid,
        },
      }
    ]);

    // wait response of get-condition-detail
    await for (dynamic data in socketIO.on('r-get-condition-detail')) {
      conditionDetail = Map<String, dynamic>.from(data[0]['value']['payload']);
      conditionDetailLoading = false;
      notifyListeners();
      break;
    }
  }

  // save diagnosetic result
  Future<void> saveResult(String userId) async {

    // create condition object to add in payload
    Map<dynamic, dynamic> tempConditions = {};
    for (Map condition in conditions) {
      tempConditions.putIfAbsent(
          condition['id'], () => condition['common_name']);
    }

    // emit data to save-from-api
    await socketIO.emit('event', [
      {
        'transaction': 'save-from-api',
        'payload': {
          'pid': userId,
          'status': 3,
          'apDt': DateTime.now().toString(),
          'symptoms': selectedSymptom,
          'conditions': tempConditions,
        },
      }
    ]);

    // wait response of save-from-api
    await for (dynamic data in socketIO.on('r-save-from-api')) {
      if (data != null) {
        tpid = data[0]['value']['payload']['tpid'];
        apid = data[0]['value']['payload']['apid'];
        break;
      }
    }
  }

  // clear every data in symptom assessment provider
  void clear() {
    symptomSearching = false;
    symptomSearchList = [];

    diagnosticLoading = false;
    diagnosticData = {};

    sendingTriage = false;
    triage = {};
    triage_level = '';

    conditionDetailLoading = false;
    conditionDetail = {};

    evidence = [];
    conditions = [];
    selectedSymptom = [];

    tpid = '';
    apid = '';
  }
}
