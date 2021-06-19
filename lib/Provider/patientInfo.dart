import 'dart:async';

import 'package:flutter/material.dart';
import '../Script/socketioScript.dart';

import '../Models/model.dart';

class PatientInfo with ChangeNotifier {
  String tpid;
  String pid;

  Map<String, dynamic> pInfo;
  List<Map<String, dynamic>> symp_cond = [];
  List<Map<String, dynamic>> vital_pain = [];
  List<Map<String, dynamic>> prescrip_suggest = [];
  var pInfoLoad = false;
  var symp_condLoad = false;
  var vital_painLoad = false;
  var prescrip_suggestLoad = false;

  StreamSubscription r_getProfile;
  StreamSubscription r_get_condition_symptom;
  StreamSubscription r_get_vital_sign_records;
  StreamSubscription r_get_prescription;

  // get patinet infomation
  Future<void> getPatInfo(String pId, String tpId) async {
    pid = pId;
    tpid = tpId;
    pInfo = {};
    symp_cond = [];
    vital_pain = [];
    prescrip_suggest =[];

    // wait response of getProfile
    r_getProfile = socketIO.on('r-getProfile').listen((data) {
      final payload = data[0]['value']['payload'];
      if (data != null) {
        pInfo = {
          'id': payload['PID'],
          'userName': payload['userName'],
          'fname': payload['PName'],
          'surname': payload['PSurname'],
          'dob': DateTime.parse(payload['DoB']),
          'gender': gernderGenerate(payload['gender']),
          'isSmoke': statusGenerate(payload['isSmoke']),
          'isDiabetes': statusGenerate(payload['isDiabetes']),
          'hasHighPress': statusGenerate(payload['hasHighPress']),
          'drugAllergy': payload['patDrugAllergy']
        };
        pInfoLoad = true;
        r_getProfile.cancel();
        notifyListeners();
      }
    });

    // wait response of get-condition-symptom
    r_get_condition_symptom = socketIO.on('r-get-condition-symptom').listen((data) {
      final payload = data[0]['value']['payload'];
      if (data != null) {
        for (Map<String, dynamic> item in payload) {
          symp_cond.add({
            'apid': item['apid'],
            'apDt': DateTime.parse(item['date']).add(Duration(hours: 7)),
            'symptoms': item['pat_symptom'],
            'condition': item['pat_condition'],
          });
          prescrip_suggest.add({
            'apid': item['apid'],
            'apDt': DateTime.parse(item['date']).add(Duration(hours: 7)),
          });
        }
        symp_cond.removeWhere((element) => (element['apDt'].difference(DateTime.now()).inDays > 0));
        symp_condLoad = true;
        r_get_condition_symptom.cancel();
        notifyListeners();
      } 
    });

    // wait response of get-vital-sign-record
    r_get_vital_sign_records = socketIO.on('r-get-vital-sign-records').listen((data) {
      print('On r-get-vital-sign-records: $data');
      final payload = data[0]['value']['payload'];
      if (data != null) {
        for (Map<String, dynamic> item in payload) {
          vital_pain.add(item);
        }
        vital_painLoad = true;
        r_get_vital_sign_records.cancel();
        notifyListeners();
      }
    });

    // wait response of getProfile
    r_get_prescription = socketIO.on('r-get-prescription').listen((data) {
      final payload = data[0]['value']['payload'];
      if (data != null) {
        for (int index = 0 ; index < prescrip_suggest.length; index++) {
          prescrip_suggest[index]['prescription'] = payload[index]['prescription'];
          prescrip_suggest[index]['advice'] = payload[index]['advice'];
        }
        prescrip_suggest.removeWhere((element) => (element['apDt'].difference(DateTime.now()).inDays > 0));
        prescrip_suggestLoad = true;
        r_get_prescription.cancel();
        notifyListeners();
      } 
    });

    // emit data to getProfile
    await socketIO.emit('event', [
      {
        'transaction': 'getProfile',
        'payload': {
          'userRole': 'patient',
          'targetUserId': pid,
        }
      }
    ]);

    // emit data to get-condition_symptom
    await socketIO.emit('event', [
      {
        'transaction': 'get-condition-symptom',
        'payload': {'tpid': tpid}
      }
    ]);

    // emit data to get-vital-sign-records
    await socketIO.emit('event', [
      {
        'transaction': 'get-vital-sign-records',
        'payload': {'tpid': tpid}
      }
    ]);

    // emit data to get-prescription
    await socketIO.emit('event', [
      {
        'transaction': 'get-prescription',
        'payload': {'tpid': tpid}
      }
    ]);
  }
}
