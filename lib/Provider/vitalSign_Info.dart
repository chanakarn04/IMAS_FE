import 'package:flutter/material.dart';

import '../Script/socketioScript.dart';
// import 'package:socket_io_client/socket_io_client.dart';

// import '../Models/model.dart';

class VitalSignProvider with ChangeNotifier {
  String tpId;
  String apId;
  double temp;
  double pulse;
  double breath;
  double pressurelow;
  double pressurehigh;

  List<dynamic> symptoms = [];
  Map<String, dynamic> painScore = {};
  // 'pain_score': {
  //   'head ache': 3,
  //   'leg pain': 5,
  // }

  Future<void> querySymptom() async {
    await socketIO.emit('event', [
      {
        'transaction': 'get-condition-symptom',
        'payload': {'tpid': tpId},
      }
    ]);
    await for (dynamic event in socketIO.on('r-get-condition-symptom')) {
      print('On r-get-condition-symptom: $event');
      // final data = Map<String, dynamic>.from(event[0]['value']['payload']);
      final _apts = List<dynamic>.from(event[0]['value']['payload']);
      final _currentApt = _apts.firstWhere((element) => element['apid'] == apId, orElse: () => _apts[0]);
      // final _currentApt = _apts[0];
      symptoms = _currentApt['pat_symptom'];
      // payload: [{
      //   apid: 60a2323cbe47e8001ff7f4bb, 
      //   date: 2021-05-17T09:07:08.218Z, 
      //   pat_symptom: [Back pain]
      // }]
      break;
    }
  }

  Future<void> saveVsPs(
    // String lastTpid,
    // String lastApid,
  ) async {
    print('$temp : $pulse : $pressurehigh|$pressurelow : $breath');
    await socketIO.emit('event', [
      {
        'transaction': 'save-vital-pain',
        'payload': {
          // 'vsid': ,
          'tpid': tpId,
          'apid': apId,
          'pain_score': painScore,
          'vsdt': DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute,
          ).toString(),
          'body_temp': temp,
          'pulse': pulse.toInt(),
          'blood_pressure_top': (pressurehigh is num) ? pressurehigh.toInt() : null,
          'blood_pressure_bottom': (pressurelow is num) ? pressurelow.toInt() : null,
          'respiratory_rate': (breath is num) ? breath.toInt() : null,
        },
      }
    ]);
    await for (dynamic data in socketIO.on('r-save-vital-pain')) {
      print('On r-save-vital-pain: $data');
      if (data != null) {
        break;
      }
    }
  }

  void clear() {
    tpId = null;
    temp = null;
    pulse = null;
    breath = null;
    pressurelow = null;
    pressurehigh = null;
    symptoms = [];
    painScore = {};
  }
}
