// import 'package:adhara_socket_io/manager.dart';
// import 'package:adhara_socket_io/options.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/chatRoom_info.dart';
import '../Script/socketioScript.dart' as IO;
import '../Models/model.dart';

enum Role {
  UnAuthen,
  Patient,
  Doctor,
}

Role roleGenerater(String role) {
  switch (role) {
    case 'patient':
      return Role.Patient;
      break;
    case 'doctor':
      return Role.Doctor;
      break;
    default:
      return Role.UnAuthen;
      break;
  }
}

String roleTranslate(Role role) {
  switch (role) {
    case Role.Patient:
      return 'patient';
      break;
    case Role.Doctor:
      return 'doctor';
      break;
    default:
      return 'unknow';
      break;
  }
}

String genderTextGenerater(Gender gender) {
  switch (gender) {
    case Gender.Female:
      return 'Female';
      break;
    case Gender.Male:
      return 'Male';
      break;
    default:
      return 'unknow';
      break;
  }
}

double ageCalculate(DateTime dob) {
  return ((DateTime.now().difference(dob).inDays) / 365).floor().toDouble();
}

class UserInfo with ChangeNotifier {
  String userToken = '';
  String userId = '';
  Role role = Role.UnAuthen;
  Map<String, dynamic> userData;

  List<Map<String, dynamic>> treatmentPlan = [];
  List<Map<String, dynamic>> appointment = [];
  Map<String, dynamic> lastApt = {};

  Map<String, dynamic> patInfo = {};

  List<Map<String, dynamic>> calendarApt = [];
  var calendarAptloading = false;

  List<Map<String, dynamic>> ptFollowUp = [];
  var ptFollowUpLoading = false;

  var loginIn = false;
  var loginError = false;

  List<Map<String, dynamic>> assessmentHistory = [];

  // for test
  StreamSubscription countStreamSubscription;

  void countStreamSubscriptionTest(var start) {
    if (start) {
      print('Stream start');
      countStreamSubscription = IO.countStream(60).listen((event) {
        print('countStream: $event');
      });
      print('finish Stream start');
    } else {
      print('Stream stop');
      countStreamSubscription.cancel();
      print('Finish Stream stop');
    }
  }

  Future<void> getUserProfile() async {
    await IO.socketIO.emit('event', [
      {
        'transaction': 'getProfile',
        'payload': {'userRole': roleTranslate(role)}
      }
    ]);
    await for (dynamic data in IO.socketIO.on('r-getProfile')) {
      final tempData = data[0]['value']['payload'];
      if (role == Role.Patient) {
        // final tempDoB = tempData['DoB'].split('-');
        userData = {
          'id': tempData['PID'],
          'userName': tempData['userName'],
          'fname': tempData['PName'],
          'surname': tempData['PSurname'],
          'dob': DateTime.parse(tempData['DoB']),
          'gender': gernderGenerate(tempData['gender']),
          'isSmoke': statusGenerate(tempData['isSmoke']),
          'isDiabetes': statusGenerate(tempData['isDiabetes']),
          'hasHighPress': statusGenerate(tempData['hasHighPress']),
          'drugAllergy': tempData['patDrugAllergy']
        };
        break;
      } else {
        userData = {
          'id': tempData['DRID'],
          'userName': tempData['userName'],
          'suffix': tempData['nameSuffix'],
          'fname': tempData['DRName'],
          'surname': tempData['DRSurname'],
          'gender': gernderGenerate(tempData['gender']),
          'citizenID': tempData['citizenID'],
          'medID': tempData['MDID'],
          'certID': tempData['certID'],
          'isApproved': tempData['isApproved'],
        };
        break;
      }
      print('userData: $userData');
      // {
      //   DRID: DR-00001,
      //   userName: pasit.h@mail.com,
      //   password: 654321,
      //   nameSuffix: M.D.,
      //   DRName: Pasit,
      //   DRSurname: Hankijpongpan,
      //   gender: true,
      //   citizenID: 1012345678910,
      //   MDID: 12123-12121,
      //   certID: KMUTT-MD2564-99,
      //   isApproved: true
      // }
    }
  }

  Future<void> getTpApt() async {
    IO.socketIO.emit('event', [
      {
        'transaction': 'get-plan',
        'payload': {
          'role': roleTranslate(role),
          'status': [0, 1, 2, 3],
        }
      }
    ]);
    await for (dynamic event in IO.socketIO.on('r-get-plan')) {
      print(event[0]['value']['payload']);
      final data = List.from(event[0]['value']['payload']);
      // [{status: 0, _id: 609a336dc5100400298ed475, pid: pisut.s@mail.com, __v: 0, drid: pasit.h@mail.com}]
      if (data.isNotEmpty) {
        // print('data is not Empty');
        for (dynamic tp in data) {
          treatmentPlan.add({
            'tpid': tp['_id'],
            'status': tpStatusGenerate(tp['status']),
            'pid': tp['pid'],
            'drid': tp['drid'],
          });
        }

        Map<String, dynamic> _lastTpid;

        if (treatmentPlan.isEmpty) {
          _lastTpid = null;
        } else {
          _lastTpid = treatmentPlan.firstWhere(
            (element) => element['status'] == TreatmentStatus.InProgress, orElse: () => null);
        }

        if (_lastTpid != null) {
          await IO.socketIO.emit('event', [
            {
              'transaction': 'get-appointments',
              'payload': {
                'tpid': _lastTpid['tpid'],
              },
            }
          ]);
          await for (dynamic data in IO.socketIO.on('r-get-appointments')) {
            print('On r-get-appointments: ${data[0]['value']['payload']}');
            for (dynamic apt in data[0]['value']['payload']['appointment']) {
              appointment.add({
                'apid': apt['_id'],
                'tpid': apt['tpid_ref'],
                'aptDate': DateTime.parse(apt['apdt']),
                'status': aptStatusGenerate(apt['status']),
              });
            }
            // {
            //   appointment: [
            //     {status: 2, apdt: 2021-05-14T07:42:00.000Z, _id: 609e2594be47e8001ff7f46a, tpid_ref: 609a336dc5100400298ed475, __v: 0},
            //     {status: 2, apdt: 2021-05-14T07:42:00.000Z, _id: 609e2594be47e8001ff7f46b, tpid_ref: 609a336dc5100400298ed475, __v: 0},
            //     {status: 2, apdt: 2021-05-14T07:34:00.000Z, _id: 609e23bbbe47e8001ff7f469, tpid_ref: 609a336dc5100400298ed475, __v: 0},
            //     {status: 2, apdt: 2021-05-11T10:24:00.000Z, _id: 609a573aa317c2001fae33e1, tpid_ref: 609a336dc5100400298ed475, __v: 0},
            //     {status: 2, apdt: 2021-05-11T09:55:00.000Z, _id: 609a524ba317c2001fae33e0, tpid_ref: 609a336dc5100400298ed475, __v: 0},
            //     {status: 2, apdt: 2021-05-11T09:53:00.000Z, _id: 609a524ba317c2001fae33df, tpid_ref: 609a336dc5100400298ed475, __v: 0},
            //     {status: 2, apdt: 2021-05-11T07:58:00.000Z, _id: 609a34e5c975330029609f14, tpid_ref: 609a336dc5100400298ed475, __v: 0},
            //     {status: 2, apdt: 2021-05-11T07:34:05.239Z, _id: 609a336dc5100400298ed476, tpid_ref: 609a336dc5100400298ed475, __v: 0}
            //   ]
            // }
            lastApt = appointment.firstWhere(
              (apt) =>
                  (apt['status'] == AptStatus.Waiting) &&
                  (DateTime.parse(apt['aptDate'].toString()).difference(DateTime.now()).inMinutes - 390 <= 30),
              orElse: () => {},
            );
            break;
          }
        }

        break;
      } else {
        // print('data is Empty');
        break;
      }
    }
  }

  // Stream<void> onChatNotify() async* {
  //   // print()
  //   IO.socketIO.on('r-noti-doc-to-accept').listen((data) {
  //     print('On noti-doc-to-accept: $data');
  //   });
  // }

  Future<void> login(
    String userName,
    String password,
  ) async {
    if (userName == 'testUser' && password == '1234') {
      // socketIO.streamTest().then((value) => print('test: $value'));
      userToken = 'usrTk1';
      userId = 'testPt';
      role = Role.Patient;
      // ...
      final tempData = {
        'PID': 'P-00001',
        'userName': 'pisut.s@mail.com',
        'password': '123456',
        'PName': 'Pisut',
        'PSurname': 'Suntornkiti',
        'DoB': '1998-03-04',
        'gender': true,
        'isSmoke': 1,
        'isDiabetes': 0,
        'hasHighPress': 0,
        'patDrugAllergy': ['Vitamin C', 'Heroin']
      };
      final tempDoB = tempData['DoB'].toString().split('-');
      userData = {
        'id': tempData['PID'],
        'userName': tempData['userName'],
        'fname': tempData['PName'],
        'surname': tempData['PSurname'],
        'dob': DateTime(int.parse(tempDoB[0]), int.parse(tempDoB[1]),
            int.parse(tempDoB[2])),
        'gender': gernderGenerate(tempData['gender']),
        'isSmoke': statusGenerate(tempData['isSmoke']),
        'isDiabetes': statusGenerate(tempData['isDiabetes']),
        'hasHighPress': statusGenerate(tempData['hasHighPress']),
        'drugAllergy': tempData['patDrugAllergy']
      };
      // print(userData);

      notifyListeners();
    } else if (userName == 'testDoctor' && password == '1234') {
      userToken = 'usrTk2';
      userId = 'testDr';
      role = Role.Doctor;
      // online = false;
      notifyListeners();
    } else {
      print('login');
      print('userName: $userName');
      print('password: $password');

      // connect for login
      // emit login
      // get token
      // disconnect
      // connect new socket with token
      // get profile

      await IO.loginSocketConnect({
        'token': '',
        'userid': userName,
      });
      print('emit login');
      await IO.loginSocket.emit('event', [
        {
          'transaction': 'login',
          'payload': {'password': password}
        }
      ]);
      await for (var event in IO.loginSocket.on('r-login')) {
        // final data = jsonDecode(event[0],);
        final data = Map<String, dynamic>.from(event[0]);
        print('On r-login ${data}');
        if (data['value']['payload'].containsKey('userRole')) {
          userToken = data['value']['passport']['token'];
          // userToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7IlBJRCI6IlAtMDAwMDEiLCJ1c2VyTmFtZSI6InBpc3V0LnNAbWFpbC5jb20iLCJQTmFtZSI6IlBpc3V0IiwiUFN1cm5hbWUiOiJTdW50b3Jua2l0aSIsIkRvQiI6IjE5OTgtMDMtMDQiLCJnZW5kZXIiOnRydWUsImlzU21va2UiOjEsImlzRGlhYmV0ZXMiOjAsImhhc0hpZ2hQcmVzcyI6MH0sInN1YiI6IlAtMDAwMDEiLCJpYXQiOjE2MjAyODg3ODQzNzJ9.Ehdq07pQ2KQVa;dlsfklgkeiralkvmvbmzcvmqweewq';
          userId = data['value']['passport']['userid'];
          role = roleGenerater(data['value']['payload']['userRole']);
          await IO.loginSocketDisconnect();
          await IO.socketConnect({
            'token': userToken,
            'userid': userId,
          });
          await getUserProfile();
          await getTpApt();
          loginIn = false;
          notifyListeners();
          break;
        } else {
          loginError = true;
          notifyListeners();
        }
        // userToken = data[0]['value']['passport']['token'];
        // userId = data[0]['value']['passport']['userid'];
        // role = _roleGenerater(data[0]['value']['payload']['userRole']);
      }
    }
  }

  // Future<void> getPatInfo(String patId, String tpid) async {
  //   // Get patient profile
  //   await IO.socketIO.emit('event', [
  //     {
  //       'transaction': 'getProfile',
  //       'payload': {'userRole': 'patient', 'targetUserId': patId}
  //     }
  //   ]);

  //   // Waiting getProfile return
  //   await for (dynamic data in IO.socketIO.on('r-getProfile')) {
  //     print('On r-getProfile: $data');
  //     final payload = data[0]['value']['payload'];
  //     if (data != null) {
  //       patInfo['profile'] = data;
  //       notifyListeners();
  //     } else {
  //       print('No data returned');
  //     }
  //   }

  //   // Get patient conditions symptoms
  //   await IO.socketIO.emit('event', [
  //     {
  //       'transaction': 'get-condition-symptom',
  //       'payload': {'tpid': tpid}
  //     }
  //   ]);

  //   // Waiting for data return
  //   await for (dynamic data in IO.socketIO.on('r-get-condition-symptom')) {
  //     print('On r-get-condition-symptom: $data');
  //     final payload = data[0]['value']['payload'];
  //     if (data != null) {
  //       patInfo['conditions_symptoms'] = data;
  //       notifyListeners();
  //     } else {
  //       print('No data returned');
  //     }
  //   }

  //   // Get patient vital sign records
  //   await IO.socketIO.emit('event', [
  //     {
  //       'transaction': 'get-vital-sign-records',
  //       'payload': {'tpid': tpid}
  //     }
  //   ]);

  //   // Waiting for data return
  //   await for (dynamic data in IO.socketIO.on('r-get-vital-sign-records')) {
  //     print('On r-get-vital-sign-records: $data');
  //     final payload = data[0]['value']['payload'];
  //     if (data != null) {
  //       patInfo['vital_sign'] = data;
  //       notifyListeners();
  //     } else {
  //       print('No data returned');
  //     }
  //   }

  //   // Get patient prescriptions
  //   await IO.socketIO.emit('event', [
  //     {
  //       'transaction': 'get-prescription',
  //       'payload': {'tpid': tpid}
  //     }
  //   ]);

  //   // Waiting for data return
  //   await for (dynamic data in IO.socketIO.on('r-get-prescription')) {
  //     print('On r-get-prescription: $data');
  //     final payload = data[0]['value']['payload'];
  //     if (data != null) {
  //       patInfo['prescription'] = data;
  //       notifyListeners();
  //     } else {
  //       print('No data returned');
  //     }
  //   }
  // }

  Future<void> calendarAppointment() async {
    ptFollowUp = [];
    List<Map<String, dynamic>> _pNameOfTreatment = [];

    List<String> _treatmentPlans = [];

    IO.socketIO.emit('event', [
      {
        'transaction': 'get-plan',
        'payload': {
          'role': roleTranslate(role),
          'status': [0, 1, 2, 3],
        }
      }
    ]);
    await for (dynamic event in IO.socketIO.on('r-get-plan')) {
      print(event[0]['value']['payload']);
      final data = List.from(event[0]['value']['payload']);
      // [{status: 0, _id: 609a336dc5100400298ed475, pid: pisut.s@mail.com, __v: 0, drid: pasit.h@mail.com}]
      if (data.isNotEmpty) {
        // print('data is not Empty');
        for (dynamic tp in data) {
          treatmentPlan.add({
            'tpid': tp['_id'],
            'status': tpStatusGenerate(tp['status']),
            'pid': tp['pid'],
            'drid': tp['drid'],
          });
        }
      }
      break;
    }

    for (Map<String, dynamic> tp in treatmentPlan) {
      // change pattern for use in get-calendar-apt
      _treatmentPlans.add(tp['tpid']);

      // get name of patient of tpid
      await IO.socketIO.emit('event', [
        {
          'transaction': 'getProfile',
          'payload': {
            'userRole': roleTranslate(Role.Patient),
            'targetUserId': tp['pid'],
          },
        }
      ]);
      await for (dynamic data in IO.socketIO.on('r-getProfile')) {
        final tempData = data[0]['value']['payload'];
        _pNameOfTreatment.add({
          'tpid': tp['tpid'],
          'pname': '${tempData['PName']} ${tempData['PSurname']}',
          'pid': tp['pid'],
        });
        break;
      }
    }

    if (role == Role.Doctor) {
      // Waiting for data return
      // IO.socketIO.on('r-get-calendar-appointments').listen((data) {
      //   print('On r-get-calendar-appointments: $data');
      //   for (Map<String, dynamic> apt in data[0]['value']['payload']) {
      //     calendarApt.add({
      //       'tpid': apt['tpid_ref'],
      //       'apid': apt['_id'],
      //       'apDt': DateTime.parse(apt['apdt']),
      //       'status': apt['status'],
      //       'image': 'assets/images/default_photo.png',
      //       'pName': _pNameOfTreatment.firstWhere(
      //           (element) => element['tpid'] == apt['tpid_ref'])['pname'],
      //     });
      //   }
      //   calendarAptloading = false;
      //   notifyListeners();
      // });
      // {
      //   "_id" : "609a336dc5100400298ed476",
      //   "status" : 2,
      //   "apdt" : "2021-05-11T07:34:05.239Z",
      //   "tpid_ref" : "609a336dc5100400298ed475",
      //   "__v" : 0
      // },

      // Get appointments by time range
      IO.socketIO.emit('event', [
        {
          'transaction': 'get-calendar-appointments',
          'payload': {
            'tpids': _treatmentPlans,
            'start': DateTime(
              DateTime.now().year,
              DateTime.now().month - 1,
            ).toString(),
            'stop': DateTime(
              DateTime.now().year,
              DateTime.now().month + 2,
              0,
            ).toString()
          }
        }
      ]);

      // print('start on');
      await for (dynamic data in IO.socketIO.on('r-get-calendar-appointments')) {
        print('On r-get-calendar-appointments: $data');
        for (Map<String, dynamic> apt in data[0]['value']['payload']) {
          calendarApt.add({
            'tpid': apt['tpid_ref'],
            'apid': apt['_id'],
            'apDt': DateTime.parse(apt['apdt']).add(const Duration(hours: 7)),
            'status': apt['status'],
            'image': 'assets/images/default_photo.png',
            'pName': _pNameOfTreatment.firstWhere(
                (element) => element['tpid'] == apt['tpid_ref'])['pname'],
            'pid': _pNameOfTreatment.firstWhere(
                (element) => element['tpid'] == apt['tpid_ref'])['pid'],
          });
        }
        calendarAptloading = false;
        notifyListeners();
        break;
      }
      // print('off on');

    }
  }

  Future<void> patientFollowUpInfo() async {
    // await Future.delayed(Duration(seconds: 2));
    // print('wait complete');
    List<Map<String, dynamic>> _tempApt;
    
    // calendarApt
    for (Map<String, dynamic> tp in treatmentPlan) {
      // print('tp test');
      _tempApt = calendarApt.where((element) => element['tpid'] == tp['tpid']).toList();
      _tempApt.sort((a,b) => b['apDt'].compareTo(a['apDt']));
      // print('tempS : $_tempApt');
      ptFollowUp.add(_tempApt[0]);
    }
    ptFollowUpLoading = false;
    notifyListeners();
  }

  Future<void> updatePlan(String thisTpid, int tpStatus) async {
    await IO.socketIO.emit('event', [
        {
          'transaction': 'updatePlan',
          'payload': {
            'tpid': thisTpid,
            'status': tpStatus,
            'drid': userId,
          }
        }
      ]);
    await for (dynamic data in IO.socketIO.on('r-updatePlan')) {
      print('On r-updatePlan ${data[0]['value']['payload']}');
      break;
    }
  }

  Future<void> logout() async {
    // ===> No connect test <===
    // Future.delayed(Duration(seconds: 5)).then((value) {
    //   print('===> TEST');
    //   userToken = '';
    //   userId = '';
    //   role = Role.UnAuthen;
    //   online = false;
    //   notifyListeners();
    // });

    await IO.socketIO.emit('event', [
      {
        'transaction': 'logout',
        // 'payload': {'password': password}
      }
    ]);
    await for (dynamic data in IO.socketIO.on('r-logout')) {
      print('On r-logout: $data');
      if (data != null) {
        IO.socketDisconnect();
        IO.chatSocketDisconnect();
        userToken = '';
        userId = '';
        userData = {};
        treatmentPlan = [];
        appointment = [];
        role = Role.UnAuthen;
        // online = false;
        notifyListeners();
        break;
      }
    }
  }
}
