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

    for (Map<String, dynamic> tp in temp_tp) {
      if (tp['tpid'] == '609a336dc5100400298ed475') {
        continue;
      } else {
        await socketIO.emit('event', [
          {
            'transaction': 'get-condition-symptom',
            'payload': {'tpid': tp['tpid']},
            // 'payload': {'tpid': '60a3a1d307d806001e92fbb2'},
          }
        ]);
        await for (dynamic event in socketIO.on('r-get-condition-symptom')) {
          print('On r-get-condition-symptom: $event');
          final apts =
              List<Map<String, dynamic>>.from(event[0]['value']['payload']);
          final aptSort =
              List<Map<String, dynamic>>.from(event[0]['value']['payload']);
          aptSort.sort((a, b) => b['date'].compareTo(a['date']));
          assessmentHistoryData.add({
            'tpid': tp['tpid'],
            'status': tp['status'],
            'date': DateTime.parse(aptSort[0]['date']),
            'symptom': aptSort[0]['pat_symptom'],
            'apts': apts,
          });
          // payload: [{apid: 609e215bbe47e8001ff7f466, date: 2021-05-14T07:06:03.664Z, pat_symptom: [headache], pat_condition: {c_981: Back strain, c_30: Degenerative disc disease of the lumbar and sacral spine, c_102: Sciatica}}]
          break;
        }
      }
    }
    loading = false;
    print('load success');
    notifyListeners();
  }

  void clear() {
    assessmentHistoryData = [];
  }
}
