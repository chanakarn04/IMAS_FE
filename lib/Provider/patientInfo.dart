import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart';
import '../Script/socketioScript.dart';

import '../Models/model.dart';
import '../Provider/user-info.dart';

// import '../Models/model.dart';

class PatientInfo with ChangeNotifier {
  // String tpid;
  String tpid;
  String pid;

  Map<String, dynamic> pInfo;
  List<Map<String, dynamic>> symp_cond = [];
  List<Map<String, dynamic>> vital_pain = [];
  List<Map<String, dynamic>> prescrip_suggest = [];
  var pInfoLoad = false;
  var symp_condLoad = false;
  var vital_painLoad = false;
  var prescrip_suggestLoad = false;

  Future<void> getPatInfo(String pId, String tpId) async {
    pid = pId;
    tpid = tpId;
    pInfo = {};
    symp_cond = [];
    vital_pain = [];
    prescrip_suggest =[];


    socketIO.on('r-getProfile').listen((data) {
      print('On r-getProfile: $data');
      final payload = data[0]['value']['payload'];
      if (data != null) {
        pInfo = {
          'id': payload['PID'],
          'userName': payload['userName'],
          'fname': payload['PName'],
          'surname': payload['PSurname'],
          'dob': DateTime.parse(payload['DoB']),
          'gender': gernderGenerate(payload['gender']),
          'isSmoke': statusGenerate(payload['isSmoke']),
          'isDiabetes': statusGenerate(payload['isDiabetes']),
          'hasHighPress': statusGenerate(payload['hasHighPress']),
          'drugAllergy': payload['patDrugAllergy']
        };
        pInfoLoad = true;
        notifyListeners();
      } else {
        print('No data returned');
      }
    });
    // {
    //   "PID":"P-00001",
    //   "userName":"pisut.s@mail.com",
    //   "password":"123456",
    //   "PName":"Pisut",
    //   "PSurname":"Suntornkiti",
    //   "DoB":"1998-03-04",
    //   "gender":true,
    //   "isSmoke":1,
    //   "isDiabetes":0,
    //   "hasHighPress":0,
    //   "patDrugAllergy":["Vitamin C","Heroin"]
    // }

    socketIO.on('r-get-condition-symptom').listen((data) {
      print('On r-get-condition-symptom: $data');
      final payload = data[0]['value']['payload'];
      if (data != null) {
        for (Map<String, dynamic> item in payload) {
          symp_cond.add({
            'apid': item['apid'],
            'apDt': DateTime.parse(item['date']),
            'symptoms': item['pat_symptom'],
            'condition': item['pat_condition'],
          });
          prescrip_suggest.add({
            'apid': item['apid'],
            'apDt': DateTime.parse(item['date']),
          });
        }
        symp_condLoad = true;
        notifyListeners();
      } else {
        print('No data returned');
      }
    });
    // payload":[
    //  {"apid":"609e2594be47e8001ff7f46a","date":"2021-05-14T07:42:00.000Z","pat_symptom":null,"pat_condition":null},
    //  {"apid":"609e2594be47e8001ff7f46b","date":"2021-05-14T07:42:00.000Z","pat_symptom":null,"pat_condition":null},
    //  {"apid":"609e23bbbe47e8001ff7f469","date":"2021-05-14T07:34:00.000Z","pat_symptom":null,"pat_condition":null},
    //  {"apid":"609a573aa317c2001fae33e1","date":"2021-05-11T10:24:00.000Z","pat_symptom":null,"pat_condition":null},
    //  {"apid":"609a524ba317c2001fae33e0","date":"2021-05-11T09:55:00.000Z","pat_symptom":null,"pat_condition":null},
    //  {"apid":"609a524ba317c2001fae33df","date":"2021-05-11T09:53:00.000Z","pat_symptom":null,"pat_condition":null},
    //  {"apid":"609a34e5c975330029609f14","date":"2021-05-11T07:58:00.000Z","pat_symptom":null,"pat_condition":null},
    //  {"apid":"609a336dc5100400298ed476","date":"2021-05-11T07:34:05.239Z","pat_symptom":["headache"],"pat_condition":{"c_255":"Tetanus"}}
    // ]
    // "payload":[]
    // ListView.builder(
    //   itemBuilder: (context, index) {
    //     final _diseaseList = item['apts'][0]['pat_condition'].values.toList();
    //     return Container(
    //       alignment: Alignment.centerLeft,
    //       margin: EdgeInsets.symmetric(vertical: 1.5),
    //       // color: Colors.teal[100],
    //       child: Text(
    //         '${_diseaseList[index]}',
    //         maxLines: 1,
    //         overflow: TextOverflow.fade,
    //         softWrap: false,
    //         style: TextStyle(fontSize: 18),
    //       ),
    //     );
    //   },
    //   itemCount: item['apts'][0]['pat_condition'].length,
    // ),

    socketIO.on('r-get-vital-sign-records').listen((data) {
      print('On r-get-vital-sign-records: $data');
      final payload = data[0]['value']['payload'];
      if (data != null) {
        for (Map<String, dynamic> item in payload) {
          vital_pain.add(item);
        }
        vital_painLoad = true;
        notifyListeners();
      } else {
        print('No data returned');
      }
    });
    // "payload":[
    //   {
    //    "vsdt":"2021-05-11T10:29:00.841Z",
    //    "body_temp":0,
    //    "pulse":0
    //   },
    //   {
    //    "vsdt":"2021-05-11T10:10:00.000Z",
    //    "body_temp":36.5,
    //    "pulse":120,
    //    "blood_pressure_top":120,
    //    "blood_pressure_bottom":80,
    //    "respiratory_rate":90
    //   }
    // ]
    // "payload":[]

    socketIO.on('r-get-prescription').listen((data) {
      print('On r-get-prescription: $data');
      final payload = data[0]['value']['payload'];
      if (data != null) {
        for (int index = 0 ; index < prescrip_suggest.length; index++) {
          prescrip_suggest[index]['prescription'] = payload[index]['prescription'];
          prescrip_suggest[index]['advice'] = payload[index]['advice'];
        }
        prescrip_suggestLoad = true;
        notifyListeners();
      } else {
        print('No data returned');
      }
    });
    // "payload":[{"prescription": ["drug1", "drug2", "drug3"],"advice":"this is advice"}]
    // "payload":[]

    // Get patient profile
    await socketIO.emit('event', [
      {
        'transaction': 'getProfile',
        'payload': {
          'userRole': 'patient',
          'targetUserId': pid,
        }
      }
    ]);
    // Waiting getProfile return
    // await for (dynamic data in socketIO.on('r-getProfile')) {
    //   print('On r-getProfile: $data');
    //   // final payload = data[0]['value']['payload'];
    //   if (data != null) {
    //     // patInfo['profile'] = data;
    //     // notifyListeners();
    //   } else {
    //     print('No data returned');
    //   }
    // }

    // Get patient conditions symptoms
    await socketIO.emit('event', [
      {
        'transaction': 'get-condition-symptom',
        'payload': {'tpid': tpid}
      }
    ]);

    // Waiting for data return
    // await for (dynamic data in socketIO.on('r-get-condition-symptom')) {
    //   print('On r-get-condition-symptom: $data');
    //   // final payload = data[0]['value']['payload'];
    //   if (data != null) {
    //     // patInfo['conditions_symptoms'] = data;
    //     // notifyListeners();
    //   } else {
    //     print('No data returned');
    //   }
    // }

    // Get patient vital sign records
    await socketIO.emit('event', [
      {
        'transaction': 'get-vital-sign-records',
        'payload': {'tpid': tpid}
      }
    ]);

    // Waiting for data return
    // await for (dynamic data in socketIO.on('r-get-vital-sign-records')) {
    //   print('On r-get-vital-sign-records: $data');
    //   // final payload = data[0]['value']['payload'];
    //   if (data != null) {
    //     // patInfo['vital_sign'] = data;
    //     // notifyListeners();
    //   } else {
    //     print('No data returned');
    //   }
    // }

    // Get patient prescriptions
    await socketIO.emit('event', [
      {
        'transaction': 'get-prescription',
        'payload': {'tpid': tpid}
      }
    ]);

    // Waiting for data return
    // await for (dynamic data in socketIO.on('r-get-prescription')) {
    //   print('On r-get-prescription: $data');
    //   // final payload = data[0]['value']['payload'];
    //   if (data != null) {
    //     // patInfo['prescription'] = data;
    //     // notifyListeners();
    //   } else {
    //     print('No data returned');
    //   }
    // }
  }
}
