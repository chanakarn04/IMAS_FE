import 'package:flutter/material.dart';

import '../Script/socketioScript.dart';

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

  // get symptom data
  Future<void> querySymptom() async {
    // emit data to get-condition-symptom
    await socketIO.emit('event', [
      {
        'transaction': 'get-condition-symptom',
        'payload': {'tpid': tpId},
      }
    ]);

    // wait response of get-condition-symptom
    await for (dynamic event in socketIO.on('r-get-condition-symptom')) {
      final _apts = List<dynamic>.from(event[0]['value']['payload']);
      final _currentApt = _apts.firstWhere((element) => element['apid'] == apId, orElse: () => _apts[0]);
      symptoms = _currentApt['pat_symptom'];
      break;
    }
  }

  // save vital sign and pain score data
  Future<void> saveVsPs() async {

    // emit data to save-vital-pain
    await socketIO.emit('event', [
      {
        'transaction': 'save-vital-pain',
        'payload': {
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

    // wait response of save-vital-pain
    await for (dynamic data in socketIO.on('r-save-vital-pain')) {
      if (data != null) {
        break;
      }
    }
  }

  // clear every data in vital sign provider
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
