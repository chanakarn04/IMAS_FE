import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/user-info.dart';
import '../Script/socketioScript.dart';
import '../Models/model.dart';

class AssessmentHistoryProvider with ChangeNotifier {
  List<Map<String, dynamic>> assessmentHistoryData = [];
  var loading = false;

  Future<void> updateAssessmentHistory(Role role) async {
    clear();
    // loading = true;
    // notifyListeners();
    List<Map<String, dynamic>> temp_tp = [];
    List<Map<String, dynamic>> info = [];
    List<Map<String, dynamic>> temp_prescription = [];
    socketIO.emit('event', [
      {
        'transaction': 'get-plan',
        'payload': {
          'role': roleTranslate(role),
          'status': [0, 1, 2, 3],
        }
      }
    ]);
    await for (dynamic event in socketIO.on('r-get-plan')) {
      final data = List.from(event[0]['value']['payload']);
      // [{status: 0, _id: 609a336dc5100400298ed475, pid: pisut.s@mail.com, __v: 0, drid: pasit.h@mail.com}]
      if (data.isNotEmpty) {
        // print('data is not Empty');
        for (dynamic tp in data) {
          print('tp loop');
          temp_tp.add({
            'tpid': tp['_id'],
            'status': tpStatusGenerate(tp['status']),
            'pid': tp['pid'],
            'drid': tp['drid'],
          });
        }
      }
      // notifyListeners();
      break;
    }

    print('temp_tp: ${temp_tp.length}');

    for (int index = 0; index < temp_tp.length; index++) {
      if (temp_tp[index]['tpid'] == '60ab58f36aefba001e67219e' ||
          temp_tp[index]['tpid'] == '60a77aa5623465001e8b5234') {
        assessmentHistoryData.add({
          'tpid': temp_tp[index]['tpid'],
          'tpStatus': temp_tp[index]['status'],
          'date': DateTime.now(),
          'apStatus': 2,
          'symptom': [],
          'apts': [],
        });
        continue;
      } else {
        await socketIO.emit('event', [
          {
            'transaction': 'get-condition-symptom',
            'payload': {'tpid': temp_tp[index]['tpid']},
            // 'payload': {'tpid': '60a3a1d307d806001e92fbb2'},
          }
        ]);
        await for (dynamic event in socketIO.on('r-get-condition-symptom')) {
          print('On r-get-condition-symptom: $event');
          final _apts =
              List<Map<String, dynamic>>.from(event[0]['value']['payload']);
          // _apts_Filter.removeWhere((element) =>
          //     DateTime.parse(element['date']).isAfter(DateTime.now()));
          final _apt_Filter_Sort =
              List<Map<String, dynamic>>.from(event[0]['value']['payload']);
          _apt_Filter_Sort.removeWhere((element) =>
              DateTime.parse(element['date']).isAfter(DateTime.now()));
          _apt_Filter_Sort.sort((a, b) => b['date'].compareTo(a['date']));
          print('===>> $_apt_Filter_Sort');
          assessmentHistoryData.add({
            'tpid': temp_tp[index]['tpid'],
            'tpStatus': temp_tp[index]['status'],
            'date': DateTime.parse(_apt_Filter_Sort[0]['date'])
                .add(const Duration(hours: 7)),
            'apStatus': _apt_Filter_Sort[0]['status'],
            'symptom': _apt_Filter_Sort[0]['pat_symptom'],
            'apts': _apts,
          });
          // payload: [
          //   {
          //     apid: 60a77aa5623465001e8b5235,
          //     date: 2021-05-21T09:17:25.019Z,
          //     status: 2,
          //     pat_symptom: [
          //       Back pain
          //     ],
          //     pat_condition: {
          //       c_37: Kidney stones,
          //       c_981: Back strain,
          //       c_284: Pyelonephritis
          //     }
          //   }
          // ]
          break;
        }
      }

      for (Map<String, dynamic> assHist in assessmentHistoryData) {
        for (Map<String, dynamic> apt in assHist['apts']) {
          apt['date'] = DateTime.parse(apt['date']).add(Duration(hours: 7));
        }
      }

      if (temp_tp[index]['status'] != TreatmentStatus.Api) {
        await socketIO.emit('event', [
          {
            'transaction': 'get-prescription',
            'payload': {'tpid': temp_tp[index]['tpid']}
          }
        ]);
        await for (dynamic data in socketIO.on('r-get-prescription')) {
          print('On r-get-prescription ${data}');
          for (int apt_index = 0;
              apt_index < assessmentHistoryData[index]['apts'].length;
              apt_index++) {
            assessmentHistoryData[index]['apts'][apt_index]['prescription'] =
                data[0]['value']['payload'][apt_index]['prescription'];
            assessmentHistoryData[index]['apts'][apt_index]['advice'] =
                data[0]['value']['payload'][apt_index]['advice'];
          }
          // for (dynamic pres in data[0]['value']['payload']) {
          //   temp_prescription.add(pres);
          // }
          break;
        }
      }
      // "payload":[{"prescription": ["drug1", "drug2", "drug3"],"advice":"this is advice"}]
    }
    loading = false;
    print('load success');
    notifyListeners();
  }

  void clear() {
    assessmentHistoryData = [];
  }
}
