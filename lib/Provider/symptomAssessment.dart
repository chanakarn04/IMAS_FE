import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Script/socketioScript.dart';
import '../Models/model.dart';

String getGender(Gender gender) {
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

int getAge(DateTime dob) {
  // return ((DateTime.now().difference(dob).inDays) / 365).floor();
  return ((DateTime.now().difference(dob).inDays) / 365).floor();
}

class SymptomAssessmentProvider with ChangeNotifier {
  Gender gender;
  DateTime dob;

  var symptomSearching = false;
  List<Map<String, dynamic>> symptomSearchList = [];

  List<Map<String, dynamic>> evidence = [];
  List<Map<String, dynamic>> conditions = [];
  Map<String, dynamic> triage;

  void init(String userId) {
    // ... get user info and keep gender and dob
    gender = Gender.Male;
    dob = DateTime(1998, 4, 12);
  }

  Future<void> searchSymptom(String phrase) async {
    // Future<List<Map<String, dynamic>>> searchSymptom(String phrase) async {
    // ... use parse gender, dob to find symptom in /search

    // // send /seach with this
    Map<String, dynamic> searchMap = {
      'phrase': phrase,
      'sex': getGender(gender),
      'age': getAge(dob),
      'max_results': 8,
      'types': '' // maybe no need
    };

    symptomSearching = true;
    Future.delayed(Duration(seconds: 5)).then((value) {
      symptomSearchList = [
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
      symptomSearching = false;
      notifyListeners();
    });

    // symptomSearching = true;
    // socketIO.emit('event', [
    //   {
    //     'transaction': 'initSymptoms',
    //     'payload': searchMap,
    //   }
    // ]).then((_) {
    //   socketIO.on('r-initSymptoms').listen((data) {
    //     // print('On r-initSymptoms: $data');
    //     print(data[0]['value']['payload']);
    //     // ...
    //     // symptomSearchList = ...
    //     symptomSearching = false;
    //     notifyListeners();
    //   });
    // });

    // recieve data as List of JSON
    // have to parse to MAP
    // List<Map<String, dynamic>> searchResult = [
    //   {
    //     'id': 's_13',
    //     'label': 'Abdominal pain',
    //   },
    //   {
    //     'id': 's_169',
    //     'label': 'Depressed mood',
    //   },
    //   {
    //     'id': 's_47',
    //     'label': 'Earache',
    //   },
    // ];
    // // notifyListeners();
    // return searchResult;
  }

  // not future test
  // List<Map<String, dynamic>> searchSymptom(String phrase) {
  //   // ... use parse gender, dob to find symptom in /search

  //   // // send /seach with this
  //   Map<String, dynamic> searchMap = {
  //     'phrase': phrase,
  //     'sex': getGender(gender),
  //     'age': getAge(dob),
  //     'max_results': 8,
  //     'types': '' // maybe no need
  //   };

  //   // socketIO.emit('event', [
  //   //   {
  //   //     'transaction': 'initSymptoms',
  //   //     'payload': searchMap,
  //   //   }
  //   // ]).then((_) {
  //   //   socketIO.on('r-initSymptoms').listen((data) {
  //   //     print('On r-initSymptoms: $data');
  //   //   });
  //   // });

  //   // recieve data as List of JSON
  //   // have to parse to MAP
  //   List<Map<String, dynamic>> searchResult = [
  //     {
  //       'id': 's_13',
  //       'label': 'Abdominal pain',
  //     },
  //     {
  //       'id': 's_169',
  //       'label': 'Depressed mood',
  //     },
  //     {
  //       'id': 's_47',
  //       'label': 'Earache',
  //     },
  //   ];
  //   // notifyListeners();
  //   return searchResult;
  // }

  void addEvidence(Map<String, dynamic> evd) {
    // evd is in format like:
    // {"id": "s_98", "choice_id": "present", "source": "initial"}
    if (!evidence.contains(evd))
      // print('test');
      evidence.add(evd);
    // print(evidence);
  }

  Map<String, dynamic> sendDiagnostic() {
    // ... use evidence and userInfo to send /diagnosis
    Map<String, dynamic> sendDiagnosis = {
      'sex': getGender(gender),
      'age': {
        'value': getAge(dob),
        'unit': 'year',
      },
      'evidence': evidence,
      'extras': {
        'disable_groups': true,
        'include_condition_details': true,
      }
    };

    socketIO.emit('event', [
      {
        'transaction': 'diagnose',
        'payload': sendDiagnosis,
      }
    ]).then((_) {
      socketIO.on('r-diagnose').listen((data) {
        print('On r-diagnose: $data');
      });
    });

    // recieve as JSON like:
    Map<String, dynamic> diagnosticResult = {
      "question": {
        "type": "single",
        "text":
            "Does the pain increase when you touch or press on the area around your ear?",
        "items": [
          {
            "id": "s_476",
            "name": "Pain increases when touching ear area",
            "choices": [
              {"id": "present", "label": "Yes"},
              {"id": "absent", "label": "No"},
              {"id": "unknown", "label": "Don't know"}
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
            "category": {"id": "cc_16", "name": "Infectiology"},
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
            "category": {"id": "cc_3", "name": "Dermatology"},
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
    // [{"magicByte":2,"attributes":0,"timestamp":"1619604926230","offset":"10","key":null,"value":{"transaction":"r-diagnose","passport":{"token":"","userid":"pisut.s@mail.com"},"payload":{"question":{"type":"single","text":"Does the pain worsen when you touch or press around your ear?","items":[{"id":"s_476","name":"Pain increases when touching ear area","choices":[{"id":"present","label":"Yes"},{"id":"absent","label":"No"},{"id":"unknown","label":"Don't know"}]}],"extras":{}},"conditions":[{"id":"c_87","name":"Common cold","common_name":"Common cold","probability":0.1271,"condition_details":{"icd10_code":"J00","category":{"id":"cc_16","name":"Infectiology"},"prevalence":"common","severity":"mild","acuteness":"acute","triage_level":"self_care","hint":"If your symptoms worsen, please consult a family doctor."}}],"extras":{},"has_emergency_evidence":false,"should_stop":false}},"headers":{},"isControlRecord":false,"batchContext":{"firstOffset":"10","firstTimestamp":"1619604926230","partitionLeaderEpoch":0,"inTransaction":false,"isControlBatch":false,"lastOffsetDelta":0,"producerId":"-1","producerEpoch":0,"firstSequence":0,"maxTimestamp":"1619604926230","timestampType":0,"magicByte":2},"topic":"gateway","partition":0}]
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
      'age': {
        'value': getAge(dob),
        'unit': 'year',
      },
      'evidence': evidence,
      'extras': {
        'disable_groups': true,
        'include_condition_details': true,
      }
    };

    socketIO.emit('event', [
      {
        'transaction': 'triageAssessment',
        'payload': sendTriageData,
      }
    ]).then((_) {
      socketIO.on('r-triageAssessment').listen((data) {
        print('On r-triageAssessment: $data');
      });
    });

    //recueve as JSON like:
    Map<String, dynamic> triageResult = {
      'triage_level': 'consultation_24',
      // 'triage_level': 'emergency',
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
      "teleconsultation_applicable": false,
    };

    triage = triageResult;

    // add condition description get from db
    for (var index = 0; index < conditions.length; index++) {
      // use condition id (CID) to query
      String cid = conditions[index]['id'];

      // get map of data
      Map<String, dynamic> conditionInfo = {
        'id': cid, // as query // now just for test
        'name': conditions[index]
            ['common_name'], // as query // now just for test
        'description': 'temporary condition description',
        'treatment':
            'temporary condtion treatment', // maybe use condition[index]['hint']
        'cause': 'temporary condition cause',
      };

      conditions[index]
          .putIfAbsent('description', () => conditionInfo['description']);
      conditions[index]
          .putIfAbsent('treatment', () => conditionInfo['treatment']);
      conditions[index].putIfAbsent('cause', () => conditionInfo['cause']);
    }

    // return triageResult;
  }

  Map<String, dynamic> getConditionDetail(String cid) {
    Map<String, dynamic> getConditionData = {
      'id': cid,
      'age': getAge(dob),
      'enable_triage_3': false,
      'include_internal': false,
    };
    socketIO.emit('event', [
      {
        'transaction': 'getConditionDetail',
        'payload': getConditionData,
      }
    ]).then((_) {
      socketIO.on('r-getConditionDetail').listen((data) {
        print('On r-getConditionDetail: $data');
      });
    });
  }

  void saveResult() {
    // send everything to save
    // condition
    // triage

    // how to map va
    print('save data');
  }
}
