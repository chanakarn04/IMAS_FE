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

int getAge(DateTime dob) {
  // return ((DateTime.now().difference(dob).inDays) / 365).floor();
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
  // ['back pain', 'sleepless']
  List<dynamic> selectedSymptom = [];

  String tpid = '';
  String apid = '';

  void init(DateTime birthDate, Gender userGender) {
    // ... get user info and keep gender and dob
    gender = userGender;
    dob = birthDate;
  }

  Future<void> searchSymptom(String phrase) async {
    // Future<List<Map<String, dynamic>>> searchSymptom(String phrase) async {
    // ... use parse gender, dob to find symptom in /search

    // // send /seach with this
    Map<String, dynamic> searchMap = {
      'phrase': phrase,
      'sex': getGender(gender),
      'age': getAge(dob),
      'max_results': 8,
      'types': '' // maybe no need
    };

    symptomSearching = true;
    // notifyListeners();
    socketIO.emit('event', [
      {
        'transaction': 'initSymptoms',
        'payload': searchMap,
      }
    ]).then((_) {
      socketIO.on('r-initSymptoms').listen((data) {
        // print('On r-initSymptoms: $data');
        print(data[0]['value']['payload']);
        // ...
        symptomSearchList = data[0]['value']['payload'];
        symptomSearching = false;
        notifyListeners();
      });
    });

    // Future.delayed(Duration(seconds: 1)).then((value) {
    //   symptomSearchList = [
    //     {
    //       'id': 's_13',
    //       'label': 'Abdominal pain',
    //     },
    //     {
    //       'id': 's_169',
    //       'label': 'Depressed mood',
    //     },
    //     {
    //       'id': 's_47',
    //       'label': 'Earache',
    //     },
    //   ];
    //   symptomSearching = false;
    //   notifyListeners();
    // });
  }

  void addEvidence(Map<String, dynamic> evd) {
    // evd is in format like:
    // {"id": "s_98", "choice_id": "present", "source": "initial"}
    if (!evidence.contains(evd))
      // print('test');
      evidence.add(evd);
    // print(evidence);
  }

  Map<String, dynamic> sendDiagnostic() {
    // ... use evidence and userInfo to send /diagnosis
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

    // print('diagnos loading');
    // diagnosticLoading = true;
    // // notifyListeners();
    // Future.delayed(Duration(seconds: 5)).then((_) {
    //   print('diagnos loaded');
    //   diagnosticLoading = false;
    //   diagnosticData = {
    //     "question": {
    //       "type": "single",
    //       "text": "Are your headaches severe?",
    //       "items": [
    //         {
    //           "id": "s_1193",
    //           "name": "Headache, severe",
    //           "choices": [
    //             {"id": "present", "label": "Yes"},
    //             {"id": "absent", "label": "No"},
    //             {"id": "unknown", "label": "Don't know"}
    //           ]
    //         }
    //       ],
    //       "extras": {}
    //     },
    //     "conditions": [
    //       {
    //         "id": "c_87",
    //         "name": "Common cold",
    //         "common_name": "Common cold",
    //         "probability": 0.1203,
    //         "condition_details": {
    //           "icd10_code": "J00",
    //           "category": {"id": "cc_16", "name": "Infectiology"},
    //           "prevalence": "common",
    //           "severity": "mild",
    //           "acuteness": "acute",
    //           "triage_level": "self_care",
    //           "hint": "If your symptoms worsen, please consult a family doctor."
    //         }
    //       }
    //     ],
    //     "extras": {},
    //     "has_emergency_evidence": false,
    //     "should_stop": false
    //   };
    //   notifyListeners();
    // });

    diagnosticLoading = true;
    socketIO.emit('event', [
      {
        'transaction': 'diagnose',
        'payload': sendDiagnosis,
      }
    ]).then((_) {
      socketIO.on('r-diagnose').listen((data) {
        print('On r-diagnose: $data');
        diagnosticData = data[0]['value']['payload'];
        if (diagnosticData['should_stop'] == true) {
          conditions = diagnosticData['conditions'];
        }
        diagnosticLoading = false;
        notifyListeners();
      });
    });

    //  ... temp data ...
    // Map<String, dynamic> diagnosticResult = {
    //   "question": {
    //     "type": "single",
    //     "text":
    //         "Does the pain increase when you touch or press on the area around your ear?",
    //     "items": [
    //       {
    //         "id": "s_476",
    //         "name": "Pain increases when touching ear area",
    //         "choices": [
    //           {"id": "present", "label": "Yes"},
    //           {"id": "absent", "label": "No"},
    //           {"id": "unknown", "label": "Don't know"}
    //         ]
    //       }
    //     ],
    //     "extras": {}
    //   },
    //   "conditions": [
    //     {
    //       "id": "c_255",
    //       "name": "Tetanus",
    //       "common_name": "Tetanus",
    //       "probability": 0.3118,
    //       "condition_details": {
    //         "icd10_code": "A35",
    //         "category": {"id": "cc_16", "name": "Infectiology"},
    //         "prevalence": "very_rare",
    //         "severity": "severe",
    //         "acuteness": "acute",
    //         "triage_level": "emergency_ambulance",
    //         "hint": "You may need urgent medical attention! Call an ambulance."
    //       }
    //     },
    //     {
    //       "id": "c_67",
    //       "name": "Oral herpes",
    //       "common_name": "Cold sore",
    //       "probability": 0.2931,
    //       "condition_details": {
    //         "icd10_code": "B00.1, B00.9",
    //         "category": {"id": "cc_3", "name": "Dermatology"},
    //         "prevalence": "moderate",
    //         "severity": "mild",
    //         "acuteness": "chronic_with_exacerbations",
    //         "triage_level": "self_care",
    //         "hint": "Please consult a family doctor or a dermatologist."
    //       }
    //     },
    //   ],
    //   "should_stop": false,
    //   "extras": {}
    // };
    // if (diagnosticResult['should_stop'] == true) {
    //   conditions = diagnosticResult['conditions'];
    // }
    // return diagnosticResult;

    //  ... recieving data ...
    // Access at data[0]['value']['payload']
    // "value" : {
    //       "transaction" : "r-diagnose",
    //       "passport" : {
    //         "token" : "",
    //         "userid" : "pisut.s@mail.com",
    //       },
    // "payload" : {
    //   "question" : {
    //     "type" : "single",
    //     "text" : "Are your headaches severe?",
    //     "items" : [
    //       {
    //         "id" : "s_1193",
    //         "name" : "Headache, severe",
    //         "choices" : [
    //           {
    //             "id" : "present",
    //             "label" : "Yes"
    //           },
    //           {
    //             "id" : "absent",
    //             "label" : "No"
    //           },
    //           {
    //             "id" : "unknown",
    //             "label" : "Don't know"
    //           }
    //         ]
    //       }
    //     ],
    //     "extras" : {}
    //   },
    //   "conditions" : [
    //     {
    //       "id" : "c_87",
    //       "name" : "Common cold",
    //       "common_name" : "Common cold",
    //       "probability" : 0.1203,
    //       "condition_details" : {
    //         "icd10_code" : "J00",
    //         "category" : {
    //           "id" : "cc_16",
    //           "name" : "Infectiology"
    //         },
    //         "prevalence" : "common",
    //         "severity" : "mild",
    //         "acuteness" : "acute",
    //         "triage_level" : "self_care",
    //         "hint" : "If your symptoms worsen, please consult a family doctor."
    //       }
    //     }
    //   ],
    //   "extras":{},
    //   "has_emergency_evidence" : false,
    //   "should_stop" : false
    // }
    //     },

    // [{"magicByte":2,"attributes":0,"timestamp":"1619604926230","offset":"10","key":null,"value":{"transaction":"r-diagnose","passport":{"token":"","userid":"pisut.s@mail.com"},"payload":{"question":{"type":"single","text":"Does the pain worsen when you touch or press around your ear?","items":[{"id":"s_476","name":"Pain increases when touching ear area","choices":[{"id":"present","label":"Yes"},{"id":"absent","label":"No"},{"id":"unknown","label":"Don't know"}]}],"extras":{}},"conditions":[{"id":"c_87","name":"Common cold","common_name":"Common cold","probability":0.1271,"condition_details":{"icd10_code":"J00","category":{"id":"cc_16","name":"Infectiology"},"prevalence":"common","severity":"mild","acuteness":"acute","triage_level":"self_care","hint":"If your symptoms worsen, please consult a family doctor."}}],"extras":{},"has_emergency_evidence":false,"should_stop":false}},"headers":{},"isControlRecord":false,"batchContext":{"firstOffset":"10","firstTimestamp":"1619604926230","partitionLeaderEpoch":0,"inTransaction":false,"isControlBatch":false,"lastOffsetDelta":0,"producerId":"-1","producerEpoch":0,"firstSequence":0,"maxTimestamp":"1619604926230","timestampType":0,"magicByte":2},"topic":"gateway","partition":0}]
  }

  Future<void> sendTriage() async {
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

    await socketIO.emit('event', [
      {
        'transaction': 'triageAssessment',
        'payload': sendTriageData,
      }
    ]);
    // await Future.delayed(Duration(seconds: 2));
    await for (dynamic data in socketIO.on('r-triageAssessment')) {
      print('On r-triageAssessment: $data');
      triage = data[0]['value']['payload'];
      triage_level = data[0]['value']['payload']['triage_level'];
      break;
      // {
      //   'triage_level': 'consultation_24',
      //   // 'triage_level': 'emergency',
      //   "serious": [
      //     {
      //       "id": "s_1193",
      //       "name": "Headache, severe",
      //       "common_name": "Severe headache",
      //       "is_emergency": false
      //     },
      //     {
      //       "id": "s_418",
      //       "name": "Stiff neck",
      //       "common_name": "Stiff neck",
      //       "is_emergency": false
      //     }
      //   ],
      //   "teleconsultation_applicable": false,
      // };
      // }
    }
    Future.delayed(Duration(seconds: 2)).then((_) {
      sendingTriage = true;
      notifyListeners();
    });
  }

  Future<void> getMoreConditionDetail(String cid) async {
    // get more condition detail from db
    conditionDetailLoading = true;
    notifyListeners();
    await socketIO.emit('event', [
      {
        'transaction': 'get-condition-detail',
        'payload': {
          'cid': cid,
        },
      }
    ]);
    await for (dynamic data in socketIO.on('r-get-condition-detail')) {
      print('On r-get-condition-detail: $data');
      conditionDetail = Map<String, dynamic>.from(data[0]['value']['payload']);
      conditionDetailLoading = false;
      notifyListeners();
      break;
    }

    // .... old way ...
    // add condition description get from db
    // for (var index = 0; index < conditions.length; index++) {
    //   // use condition id (CID) to query
    //   String cid = conditions[index]['id'];

    //   // get map of data
    //   Map<String, dynamic> conditionInfo = {
    //     'id': cid, // as query // now just for test
    //     'name': conditions[index]
    //         ['common_name'], // as query // now just for test
    //     'description': 'temporary condition description',
    //     'treatment':
    //         'temporary condtion treatment', // maybe use condition[index]['hint']
    //     'cause': 'temporary condition cause',
    //   };

    //   conditions[index]
    //       .putIfAbsent('description', () => conditionInfo['description']);
    //   conditions[index]
    //       .putIfAbsent('treatment', () => conditionInfo['treatment']);
    //   conditions[index].putIfAbsent('cause', () => conditionInfo['cause']);
    // }
  }

  Map<String, dynamic> getConditionDetail(String cid) {
    Map<String, dynamic> getConditionData = {
      'id': cid,
      'age': getAge(dob),
      'enable_triage_3': false,
      'include_internal': false,
    };
    socketIO.emit('event', [
      {
        'transaction': 'getConditionDetail',
        'payload': getConditionData,
      }
    ]).then((_) {
      socketIO.on('r-getConditionDetail').listen((data) {
        print('On r-getConditionDetail: $data');
      });
    });
    // {
    //   "id": "string",
    //   "name": "string",
    //   "common_name": "string",
    //   "sex_filter": "both",
    //   "categories": [
    //     "string"
    //   ],
    //   "prevalence": "very_rare",
    //   "acuteness": "chronic",
    //   "severity": "mild",
    //   "extras": {},
    //   "triage_level": "emergency_ambulance",
    //   "recommended_channel": "personal_visit"
    // }
  }

  Future<void> saveResult(String userId) async {
    Map<dynamic, dynamic> tempConditions = {};
    //     {
    //       "id": "c_255",
    //       "name": "Tetanus",
    //       "common_name": "Tetanus",
    //       "probability": 0.3118,
    //       "condition_details": {
    //         "icd10_code": "A35",
    //         "category": {"id": "cc_16", "name": "Infectiology"},
    //         "prevalence": "very_rare",
    //         "severity": "severe",
    //         "acuteness": "acute",
    //         "triage_level": "emergency_ambulance",
    //         "hint": "You may need urgent medical attention! Call an ambulance."
    //       }
    //     },
    //     {
    //       "id": "c_67",
    //       "name": "Oral herpes",
    //       "common_name": "Cold sore",
    //       "probability": 0.2931,
    //       "condition_details": {
    //         "icd10_code": "B00.1, B00.9",
    //         "category": {"id": "cc_3", "name": "Dermatology"},
    //         "prevalence": "moderate",
    //         "severity": "mild",
    //         "acuteness": "chronic_with_exacerbations",
    //         "triage_level": "self_care",
    //         "hint": "Please consult a family doctor or a dermatologist."
    //       }
    //     },
    //   ],

    for (Map condition in conditions) {
      tempConditions.putIfAbsent(
          condition['id'], () => condition['common_name']);
    }

    print(tempConditions);

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
    await for (dynamic data in socketIO.on('r-save-from-api')) {
      print('On r-save-from-api: ${data[0]['value']['payload']}');
      if (data != null) {
        tpid = data[0]['value']['payload']['tpid'];
        apid = data[0]['value']['payload']['apid'];
        break;
      }
    }
    print('save data');
    // {message: Successfully save data from API, tpid: 60a1d841be47e8001ff7f47c, apid: 60a1d841be47e8001ff7f47d}
    // {message: Successfully save data from API, tpid: 60a3a1d307d806001e92fbb2, apid: 60a3a1d307d806001e92fbb3}
  }

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
