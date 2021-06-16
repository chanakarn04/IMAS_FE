import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Provider/user-info.dart';
import '../Script/socketioScript.dart';
import '../Models/model.dart';

class AssessmentHistoryProvider with ChangeNotifier {
  List<Map<String, dynamic>> assessmentHistoryData = [];
  var loading = false;

  // update value of assessment history
  Future<void> updateAssessmentHistory(Role role) async {
    clear();
    List<Map<String, dynamic>> temp_tp = [];
    List<Map<String, dynamic>> info = [];
    List<Map<String, dynamic>> temp_prescription = [];

    // emit data to get-plan
    socketIO.emit('event', [
      {
        'transaction': 'get-plan',
        'payload': {
          'role': roleTranslate(role),
          'status': [0, 1, 2, 3],
        }
      }
    ]);

    // await response of get-plan
    await for (dynamic event in socketIO.on('r-get-plan')) {
      final data = List.from(event[0]['value']['payload']);
      if (data.isNotEmpty) {
        for (dynamic tp in data) {
          temp_tp.add({
            'tpid': tp['_id'],
            'status': tpStatusGenerate(tp['status']),
            'pid': tp['pid'],
            'drid': tp['drid'],
          });
        }
      }
      break;
    }

    // get more infomation of each assessment history data
    for (int index = 0; index < temp_tp.length; index++) {

      // emit data to get-condition-symptom
      await socketIO.emit('event', [
        {
          'transaction': 'get-condition-symptom',
          'payload': {'tpid': temp_tp[index]['tpid']},
        }
      ]);

      // wait response of get-condition-symptom
      await for (dynamic event in socketIO.on('r-get-condition-symptom')) {
        final _apts = List<Map<String, dynamic>>.from(event[0]['value']['payload']);
        final _apt_Filter_Sort = List<Map<String, dynamic>>.from(event[0]['value']['payload']);
        _apt_Filter_Sort.removeWhere((element) => DateTime.parse(element['date']).isAfter(DateTime.now()));
        _apt_Filter_Sort.sort((a, b) => b['date'].compareTo(a['date']));
        assessmentHistoryData.add({
          'tpid': temp_tp[index]['tpid'],
          'tpStatus': temp_tp[index]['status'],
          'date': DateTime.parse(_apt_Filter_Sort[0]['date'])
              .add(const Duration(hours: 7)),
          'apStatus': _apt_Filter_Sort[0]['status'],
          'symptom': _apt_Filter_Sort[0]['pat_symptom'],
          'apts': _apts,
        });
        break;
      }
      
      // fix server time and device time
      for (Map<String, dynamic> assHist in assessmentHistoryData) {  
        for (Map<String, dynamic> apt in assHist['apts']) {
          apt['date'] = DateTime.parse(apt['date']).add(Duration(hours: 7));
        }
      }

      // get advice and prescription
      if (temp_tp[index]['status'] != TreatmentStatus.Api) {
        
        // emit data to get-prescription
        await socketIO.emit('event', [
          {
            'transaction': 'get-prescription',
            'payload': {'tpid': temp_tp[index]['tpid']}
          }
        ]);

        // wait response of get-prescription
        await for (dynamic data in socketIO.on('r-get-prescription')) {
          for (int apt_index = 0; apt_index < assessmentHistoryData[index]['apts'].length; apt_index++) {
            assessmentHistoryData[index]['apts'][apt_index]['prescription'] = data[0]['value']['payload'][apt_index]['prescription'];
            assessmentHistoryData[index]['apts'][apt_index]['advice'] = data[0]['value']['payload'][apt_index]['advice'];
          }
          break;
        }
      }
    }

    loading = false;
    notifyListeners();
  }

  // clear assessment history data
  void clear() {
    assessmentHistoryData = [];
  }
}
