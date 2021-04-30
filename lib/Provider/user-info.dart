// import 'package:adhara_socket_io/manager.dart';
// import 'package:adhara_socket_io/options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Script/socketioScript.dart' as socketIO;
import '../Models/model.dart';

// import '../Models/model.dart';

enum Role {
  UnAuthen,
  Patient,
  Doctor,
}

Role _roleGenerater(String role) {
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

class UserInfo with ChangeNotifier {
  String userToken = '';
  String userId = '';
  Role role = Role.UnAuthen;
  Map<String, dynamic> userData;
  var online = false;
  var isConsult = false;

  Future<void> getUserProfile() {
    socketIO.socketIO.emit('event', [
      {
        'transaction': 'getProfile',
        'payload': {'userRole': roleTranslate(role)}
      }
    ]).then((_) {
      socketIO.socketIO.on('r-getProfile').listen((data) async {
        // print('On r-getProfile: $data');
        final tempData = data[0]['value']['payload'];
        if (role == Role.Patient) {
          final tempDoB = tempData['DoB'].split('-');
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
        }
        print(userData);
        // final getProfile = [
        //   {
        //     magicByte: 2,
        //     attributes: 0,
        //     timestamp: 1619681869661,
        //     offset: 33,
        //     key: null,
        //     value: {
        //       transaction: r-getProfile,
        //       passport: {
        //         token: ,
        //         userid: pisut.s@mail.com
        //       },
        //       payload: {
        //         PID: P-00001,
        //         userName: pisut.s@mail.com,
        //         password: 123456,
        //         PName: Pisut,
        //         PSurname: Suntornkiti,
        //         DoB: 1998-03-04,
        //         gender: true,
        //         isSmoke: 1,
        //         isDiabetes: 0,
        //         hasHighPress: 0,
        //         patDrugAllergy: [Vitamin C, Heroin]
        //       }
        //     },
        //     headers: {},
        //     isControlRecord: false,
        //     batchContext: {
        //       firstOffset: 33,
        //       firstTimestamp: 1619681869661,
        //       partitionLeaderEpoch: 0,
        //       inTransaction: false,
        //       isControlBatch: false,
        //       lastOffsetDelta: 0,
        //       producerId: -1,
        //       producerEpoch: 0,
        //       firstSequence: 0,
        //       maxTimestamp: 1619681869661,
        //       timestampType: 0,
        //       magicByte: 2
        //     },
        //     topic: gateway,
        //     partition: 0}]
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
      });
    });
  }

  Stream<void> onChatNotify() async* {
    // print()
    socketIO.socketIO.on('noti-doc-to-accept').listen((data) {
      print('On noti-doc-to-accept: $data');
    });
  }

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
      // final tempData = {
      //   'PID': 'P-00001',
      //   'userName': 'pisut.s@mail.com',
      //   'password': '123456',
      //   'PName': 'Pisut',
      //   'PSurname': 'Suntornkiti',
      //   'DoB': '1998-03-04',
      //   'gender': true,
      //   'isSmoke': 1,
      //   'isDiabetes': 0,
      //   'hasHighPress': 0,
      //   'patDrugAllergy': ['Vitamin C', 'Heroin']
      // };
      // final tempDoB = tempData['DoB'].toString().split('-');
      // userData = {
      //   'id': tempData['PID'],
      //   'userName': tempData['userName'],
      //   'fname': tempData['PName'],
      //   'surname': tempData['PSurname'],
      //   'dob': DateTime(int.parse(tempDoB[0]), int.parse(tempDoB[1]),
      //       int.parse(tempDoB[2])),
      //   'gender': gernderGenerate(tempData['gender']),
      //   'isSmoke': statusGenerate(tempData['isSmoke']),
      //   'isDiabetes': statusGenerate(tempData['isDiabetes']),
      //   'hasHighPress': statusGenerate(tempData['hasHighPress']),
      //   'drugAllergy': tempData['patDrugAllergy']
      // };
      // print(userData);

      notifyListeners();
    } else if (userName == 'testDoctor' && password == '1234') {
      userToken = 'usrTk2';
      userId = 'testDr';
      role = Role.Doctor;
      online = false;
      notifyListeners();
    } else {
      print('login');
      print('userName: $userName');
      print('password: $password');
      Map<String, String> token = {
        'token': '',
        'userid': userName,
      };
      await socketIO.socketConnect(token).then((_) async {
        await socketIO.socketIO.emit('event', [
          {
            'transaction': 'login',
            'payload': {'password': password}
          }
        ]).then((_) {
          socketIO.socketIO.on('r-login').listen((data) async {
            // print('On r-login: $data');
            if (data != null) {
              userToken = data[0]['value']['passport']['token'];
              userId = data[0]['value']['passport']['userid'];
              role = _roleGenerater(data[0]['value']['payload']['userRole']);
              socketIO.token = {
                'token': userToken,
                'userid': userId,
              };
              getUserProfile();
              // if (role == Role.Doctor) {
              //   print('------------> noti- test <------------');
              //   socketIO.socketIO.on('r-noti-doc-to-accept').listen((data) {
              //     print('On noti-doc-to-accept: $data');
              //   });
              // }
              notifyListeners();
            }
          });
        });
        socketIO.socketIO.isConnected().then((value) => print(value));
      });
    }
  }

  Future<bool> register(Map<String, dynamic> payload) async {
    Map<String, String> token = {
      'token': '',
      'userid': '',
    };
    socketIO.socketConnect(token).then((_) async {
      await socketIO.socketIO.emit('event', [
        {
          'transaction': 'register',
          'payload': payload,
        }
      ]);
      socketIO.socketIO.on('r-register').listen((data) {
        print('On r-register: $data');
        // something  more
        return true;
      });
    });
  }

  void triggerIsConsult() {
    isConsult = !isConsult;
    notifyListeners();
  }

  void StartConsult() {
    isConsult = true;
    online = false;
    notifyListeners();
  }

  void closeConsult() {
    isConsult = false;
    notifyListeners();
  }

  void triggerDoctorOnline() {
    if (!isConsult) {
      if (!online) {
        print(' ===>  IF  <===');
        online = !online;
        notifyListeners();
        socketIO.socketIO.emit('event', [
          {
            'transaction': 'chatQueue',
            'payload': {'role': 'doctor'},
          }
        ]);
        // .then((_) {
        //   online = !online;
        //   notifyListeners();
        // });
      } else {
        print(' ===> ELSE <===');
        // online = !online;
        // notifyListeners();
        socketIO.socketIO.emit('event', [
          {
            'transaction': 'deleteFromQueue',
            // 'payload': {'role': _roleTranslate(role)}
          }
        ]).then((_) {
          online = !online;
          notifyListeners();
        });
      }
    }
  }

  void triggerPatientOnline() {
    socketIO.socketIO.emit('event', [
      {
        'transaction': 'chatQueue',
        'payload': {'role': roleTranslate(role)}
      }
    ]).then((_) {
      online = !online;
      notifyListeners();
    });
  }

  Future<void> logout() async {
    await socketIO.socketIO.emit('event', [
      {
        'transaction': 'logout',
        // 'payload': {'password': password}
      }
    ]).then((_) {
      socketIO.socketIO.on('r-logout').listen((data) {
        print('On r-logout: $data');
        if (data != null) {
          socketIO.socketDisconnect();
          userToken = '';
          userId = '';
          role = Role.UnAuthen;
          online = false;
          notifyListeners();
        }
      });
    });

    // ===> No connect test <===
    // Future.delayed(Duration(seconds: 5)).then((value) {
    //   print('===> TEST');
    //   userToken = '';
    //   userId = '';
    //   role = Role.UnAuthen;
    //   online = false;
    //   notifyListeners();
    // });
  }
}
