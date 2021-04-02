import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Models/model.dart';

String getGender (Gender gender) {
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

int getAge (DateTime dob) {
  // return ((DateTime.now().difference(dob).inDays) / 365).floor();
  return ((DateTime.now().difference(dob).inDays) / 365).floor();
}

class SymptomAssessmentProvider with ChangeNotifier{
  Gender gender;
  DateTime dob;
  List<Map<String, dynamic>> evidence = [];
  List<Map<String, dynamic>> conditions = [];
  Map<String, dynamic> triage;

  void init (String userId) {
    // ... get user info and keep gender and dob
    gender = Gender.Male;
    dob = DateTime(1998, 4, 12);
  }

  List<Map<String, dynamic>> searchSymptom (String phrase) {
    // ... use parse gender, dob to find symptom in /search
    
    // // send /seach with this 
    Map<String, dynamic> searchMap = {
      'pharse': phrase,
      'sex': getGender(gender),
      'age': {'value': getAge(dob)},
      'max_results': 8,
      'types': '' // maybe no need
    };
    // // NOTE : parse to JSON

    // recieve data as List of JSON
    // have to parse to MAP
    List<Map<String, dynamic>> searchResult = [
      {
        'id': 's_13',
        'label': 'Abdominal pain',
      },
      {
        'id': 's_169',
        'label': 'Depressed mood',
      },
      {
        'id': 's_47',
        'label': 'Earache',
      },
    ];
    // notifyListeners();
    return searchResult;
  }

  void addEvidence (Map<String, dynamic> evd) {
  // evd is in format like:
  // {"id": "s_98", "choice_id": "present", "source": "initial"}
    if (!evidence.contains(evd))
      // print('test');
      evidence.add(evd);
    // print(evidence);
  }

  Map<String, dynamic> sendDiagnostic () {
    // ... use evidence and userInfo to send /diagnosis
    Map<String, dynamic> sendDiagnosis = {
      'sex': getGender(gender),
      'age': {'value': getAge(dob)},
      'evidence': evidence,
      'extras': {
        'disable_groups': true,
        'include_condition_details': true,
      }
    };

    // recieve as JSON like:
    Map<String, dynamic> diagnosticResult = {
      "question": {
        "type": "single",
        "text": "Does the pain increase when you touch or press on the area around your ear?",
        "items": [
          {
            "id": "s_476",
            "name": "Pain increases when touching ear area",
            "choices": [
              {
                "id": "present",
                "label": "Yes"
              },
              {
                "id": "absent",
                "label": "No"
              },
              {
                "id": "unknown",
                "label": "Don't know"
              }
            ]
          }
        ],
        "extras": {}
      },
      "conditions": [
        {
          "id": "c_255",
          "name": "Tetanus",
          "common_name": "Tetanus",
          "probability": 0.3118,
          "condition_details": {
            "icd10_code": "A35",
            "category": {
              "id": "cc_16",
              "name": "Infectiology"
            },
            "prevalence": "very_rare",
            "severity": "severe",
            "acuteness": "acute",
            "triage_level": "emergency_ambulance",
            "hint": "You may need urgent medical attention! Call an ambulance."
          }
        },
        {
          "id": "c_67",
          "name": "Oral herpes",
          "common_name": "Cold sore",
          "probability": 0.2931,
          "condition_details": {
            "icd10_code": "B00.1, B00.9",
            "category": {
              "id": "cc_3",
              "name": "Dermatology"
            },
            "prevalence": "moderate",
            "severity": "mild",
            "acuteness": "chronic_with_exacerbations",
            "triage_level": "self_care",
            "hint": "Please consult a family doctor or a dermatologist."
          }
        },
      ],
      "should_stop": false,
      "extras": {}
    };

    if (diagnosticResult['should_stop'] == true) {
      conditions = diagnosticResult['conditions'];
    }

    return diagnosticResult;
  }

  Map<String, dynamic> sendTriage() {
    // List<Map<String, dynamic>> symptoms;

    // use after /diagnosis STOP
    // to get symptom and triage level
    // ... triage level use to define which action should do

    // send JSON object like /diagnosis
    Map<String, dynamic> sendTriageData = {
      'sex': getGender(gender),
      'age': {'value': getAge(dob)},
      'evidence': evidence,
      'extras': {
        'disable_groups': true,
        'include_condition_details': true,
      }
    };

    //recueve as JSON like:
    Map<String, dynamic> triageResult = {
      // "triage_level": "consultation_24",
      'triage_level': 'emergency',
      "serious": [
        {
          "id": "s_1193",
          "name": "Headache, severe",
          "common_name": "Severe headache",
          "is_emergency": false
        },
        {
          "id": "s_418",
          "name": "Stiff neck",
          "common_name": "Stiff neck",
          "is_emergency": false
        }
      ],
      "teleconsultation_applicable" : false,
    };

    triage = triageResult;
    
    // add condition description get from db
    for (var index = 0 ; index < conditions.length ; index++) {
      // use condition id (CID) to query
      String cid = conditions[index]['id'];

      // get map of data
      Map<String, dynamic> conditionInfo = {
        'id': cid, // as query // now just for test
        'name': conditions[index]['common_name'], // as query // now just for test
        'description': 'temporary condition description',
        'treatment': 'temporary condtion treatment', // maybe use condition[index]['hint']
        'cause': 'temporary condition cause',
      };

      conditions[index].putIfAbsent('description', () => conditionInfo['description']);
      conditions[index].putIfAbsent('treatment', () => conditionInfo['treatment']);
      conditions[index].putIfAbsent('cause', () => conditionInfo['cause']);
    }

    // return triageResult;
  }

  void saveResult() {
    // send everything to save
    // condition
    // triage

    // how to map va
    print('save data');
  }
}