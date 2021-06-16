import 'package:flutter/material.dart';

import '../Script/socketioScript.dart';

class CMinfoProvider with ChangeNotifier {
  String pName = '';
  List<String> symptoms = [];
  Map<String, String> conditions = {};
  List<String> prescriptions = [];
  String suggestions = '';

  var search_conditions_Loaded = true;
  List<Map<String, dynamic>> search_conditions = [];

  // upload case info
  Future<void> upload(String apid, String note, int status) async {

    // emit data to save-from-chatroom
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

    // wait response of save-from-chatroom
    await for (dynamic data in socketIO.on('r-save-from-chatroom')) {
      break;
    }
  }

  // add data
  void add(String caseIndex, String value) {
    switch (caseIndex) {

      // add symptom data
      case 'symptom':
        symptoms.add(value);
        break;
      
      // add prescription data
      case 'prescription':
        prescriptions.add(value);
        break;
    }
    notifyListeners();
  }

  // add condition data
  void addCondition(String cid, String name) {
    conditions[cid] = name;
    notifyListeners();
  }

  // edit data
  void edit(String caseIndex, int index, String value) {
    switch (caseIndex) {

      // edit symptom data
      case 'symptom':
        symptoms[index] = value;
        break;

      //edit prescription data
      case 'prescription':
        prescriptions[index] = value;
        break;

      // edit suggestion data
      case 'suggestion':
        suggestions = value;
        break;
    }
    notifyListeners();
  }

  // delete data
  void del(String caseIndex, int index) {
    switch (caseIndex) {

      // delete symptom data
      case 'symptom':
        symptoms.removeAt(index);
        break;

      // delete prescription data
      case 'prescription':
        prescriptions.removeAt(index);
        break;
    }
    notifyListeners();
  }

  // delete condtion data
  void delCondition(String key) {
    conditions.remove(key);
    notifyListeners();
  }

  // search condition by name
  Future<void> searchCondition(String common_name) async {
    search_conditions_Loaded = false;

    // emit data to search-condition
    socketIO.emit('event', [
      {
        'transaction': 'search-condition',
        'payload': {
          'common_name': common_name,
        },
      }
    ]);

    // wait response of search-condition
    await for (dynamic data in socketIO.on('r-search-condition')) {
      search_conditions = List<Map<String, dynamic>>.from(data[0]['value']['payload']['conditions']);
      search_conditions_Loaded = true;
      notifyListeners();
      break;
    }
  }

  // create next appointment
  Future<void> createAppointment(
    String tpid,
    DateTime apDt,
  ) async {

    // emit data to create-new-appointment
    socketIO.emit('event', [
      {
        'transaction': 'create-new-appointment',
        'payload': {
          'tpid': tpid,
          'apdt': apDt.toString(),
        },
      }
    ]);
    
    // wait data of create-appointment
    await for (dynamic data in socketIO.on('r-create-appointment')) {
      break;
    }
  }

  // clear all data of case management
  void cleanDispose() {
    pName = '';
    symptoms = [];
    conditions = {};
    prescriptions = [];
    suggestions = '';
  }
}
