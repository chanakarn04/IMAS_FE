import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart';

import '../Script/socketioScript.dart';
import '../Models/model.dart';

class CMinfoProvider with ChangeNotifier {
  String pName = '';
  List<String> symptoms = [];
  Map<String, String> conditions = {};
  List<String> prescriptions = [];
  String suggestions = '';

  var search_conditions_Loaded = true;
  List<Map<String, dynamic>> search_conditions = [];

  void loadCMInfo(String name) {
    // ... load from Lastest apId

    // if  lastest ApId info is null
    // load from lastest edit and assign to lastest

    // After get data
    pName = name;
    symptoms = [];
    conditions = {};
    prescriptions = [];
    suggestions = '';
    // notifyListeners();
  }

  Future<void> upload(String apid, String note, int status) async {
    // AptStatus
    // 0 = Pass, 1 = Default, 2 = Waiting
    // Edited, Passes, Lastest
    // ... upLoadData with apId
    // Save data
    await socketIO.emit('event', [
      {
        'transaction': 'save-from-chatroom',
        'payload': {
          'apid': apid,
          'note': note,
          'advice': suggestions,
          'status': status,
          'symptoms': symptoms,
          'conditions': conditions,
          'drugs': prescriptions,
        }
      }
    ]);

    // Waiting for data return
    await for (dynamic data in socketIO.on('r-save-from-chatroom')) {
      print('On r-save-from-chatroom: $data');
      final payload = data[0]['value']['payload'];
      if (data != null) {
        print(payload);
        notifyListeners();
      } else {
        print('No data returned');
      }
      break;
    }
  }

  void add(String caseIndex, String value) {
    switch (caseIndex) {
      case 'symptom':
        symptoms.add(value);
        // ... upload symptom to server
        break;
      case 'prescription':
        prescriptions.add(value);
        // ... upload prescription to server
        break;
      // case 'suggestion':
      //   suggestions = value;
      //   // ... upload suggestion to server
      //   break;
    }
    notifyListeners();
  }

  void addCondition(String cid, String name) {
    conditions[cid] = name;
    notifyListeners();
  }

  void edit(String caseIndex, int index, String value) {
    switch (caseIndex) {
      case 'symptom':
        symptoms[index] = value;
        // ... upload symptom to server
        break;
      case 'prescription':
        prescriptions[index] = value;
        // ... upload prescription to server
        break;
      case 'suggestion':
        suggestions = value;
        // ... upload suggestion to server
        break;
    }
    notifyListeners();
  }

  void del(String caseIndex, int index) {
    switch (caseIndex) {
      case 'symptom':
        symptoms.removeAt(index);
        // ... upload symptom to server
        break;
      case 'prescription':
        prescriptions.removeAt(index);
        // ... upload prescription to server
        break;
      // case 'suggestion':
      //   suggestions = value;
      //   // ... upload suggestion to server
      //   break;
    }
    notifyListeners();
  }

  void delCondition(String key) {
    conditions.remove(key);
    notifyListeners();
  }

  Future<void> searchCondition(String common_name) async {
    search_conditions_Loaded = false;
    socketIO.emit('event', [
      {
        'transaction': 'search-condition',
        'payload': {
          'common_name': common_name,
        },
      }
    ]);
    await for (dynamic data in socketIO.on('r-search-condition')) {
      print('On r-search-condition: ${data[0]['value']['payload']}');
      search_conditions = List<Map<String, dynamic>>.from(data[0]['value']['payload']['conditions']);
      search_conditions_Loaded = true;
      notifyListeners();
      break;
      // payload: {
      //   conditions: [
      //     {
      //       id: c_test, 
      //       type: condition, 
      //       name: Condition for testing, 
      //       common_name: Condition test, 
      //       description: This is description
      //     }
      //   ]
      // }
    }
  }

  Future<void> createAppointment(
    String tpid,
    DateTime apDt,
  ) async {
    socketIO.emit('event', [
      {
        'transaction': 'create-new-appointment',
        'payload': {
          // 'tpid': '608e6cc18f0f9c001e97ff97',
          'tpid': tpid,
          'apdt': apDt.toString(),
        },
      }
    ]);
    
    await for (dynamic data in socketIO.on('r-create-appointment')) {
      print('On r-create-appointment: ${data[0]['value']['payload']}');
      break;
    }
  }

  void cleanDispose() {
    pName = '';
    symptoms = [];
    conditions = {};
    prescriptions = [];
    suggestions = '';
  }
}
