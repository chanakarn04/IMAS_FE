import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart';

// import '../Models/model.dart';

class CMinfo {
  String editingApId;
  List<String> symptoms;
  List<String> condition;
  List<String> prescriptions;
  String suggestions;

  CMinfo(
    this.editingApId,
    this.symptoms,
    this.condition,
    this.prescriptions,
    this.suggestions,
  );
}

class CMinfoProvider with ChangeNotifier {
  String editingApId = '';
  List<String> symptoms = [];
  List<String> condition = [];
  List<String> prescriptions = [];
  String suggestions = '';

  void loadCMInfo(String tpId) {
    // ... load from Lastest apId

    // if  lastest ApId info is null
    // load from lastest edit and assign to lastest

    // After get data

    editingApId = 'ap001';
    symptoms = [
      'Headache',
      'Paralysis',
    ];
    condition = [
      'Tension Headache',
    ];
    prescriptions = [
      'Paraceetamol',
      'Bakamol',
    ];
    suggestions = 'Norn Dai leaw Deaw Prung Ni Khao Kor Klab Mah';
    // notifyListeners();
  }

  void uploadAllCMInfo() {
    // ... upLoadData with apId
    // ...
  }

  void add(String caseIndex, String value) {
    switch (caseIndex) {
      case 'symptom':
        symptoms.add(value);
        // ... upload symptom to server
        break;
      case 'disease':
        condition.add(value);
        // ... upload condition to server
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

  void edit(String caseIndex, int index, String value) {
    switch (caseIndex) {
      case 'symptom':
        symptoms[index] = value;
        // ... upload symptom to server
        break;
      case 'disease':
        condition[index] = value;
        // ... upload condition to server
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
      case 'disease':
        condition.removeAt(index);
        // ... upload condition to server
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

  void cleanDispose() {
    editingApId = '';
    symptoms = [];
    condition = [];
    prescriptions = [];
    suggestions = '';
  }
}
