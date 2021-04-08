import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';

// import '../Models/model.dart';

enum Role {
  UnAuthen,
  Patient,
  Doctor,
}

class UserInfo with ChangeNotifier {
  String userToken = '';
  String userId = '';
  Role role = Role.UnAuthen;
  String userFname;
  var online = false;

  // UserInfo({
  //   @required this.userToken,
  //   @required this.userId,
  // });

  Future<bool> login(
    String userName,
    String password,
  ) async {
    dynamic inputdata = false;
    // ...
    Socket _socket;
    _socket = io(
        'ws://10.0.2.2:3000',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({
              'token': null,
              'userid': userName,
              'password': password,
            })
            .build());
    _socket.connect();
    // _socket.onConnectError((data) {
    //   print(data);
    //   if (userName == 'testUser' && password == '1234') {
    //     print('test pt');
    //     userToken = 'usrTk1';
    //     userId = 'testPt';
    //     role = Role.Patient;
    //     userFname = 'pName pSurname';
    //     // online = true;
    //     // return true;
    //     inputdata = true;
    //     notifyListeners();
    //   }
    //   if (userName == 'testDoctor' && password == '1234') {
    //     print('test dr');
    //     userToken = 'usrTk2';
    //     userId = 'testDr';
    //     role = Role.Doctor;
    //     userFname = 'dName dSurname';
    //     online = false;
    //     // return true;
    //     inputdata = true;
    //     notifyListeners();
    //   }
    //   _socket.disconnect();
    // });
    // print('inputdata: $inputdata');
    // return inputdata;
    // ....
    // socket.emit('event', {
    //   'transaction': 'login',
    //   // 'payload': {
    //   //   'name': 'PASUT',
    //   //   'role': 'patient',
    //   //   'age': 35,
    //   //   'gender': 'male',
    //   // },
    // });
    // socket.on('r-login', (data) => print(data));
    // ...
    if (inputdata != 'timeout') {
      if (userName == 'testUser' && password == '1234') {
        userToken = 'usrTk1';
        userId = 'testPt';
        role = Role.Patient;
        userFname = 'pName pSurname';
        // online = true;
      }
      if (userName == 'testDoctor' && password == '1234') {
        userToken = 'usrTk2';
        userId = 'testDr';
        role = Role.Doctor;
        userFname = 'dName dSurname';
        online = false;
      }
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
    // ...
  }

  // String getUserName() {
  // String tempName;
  // ...
  // if (this.role == Role.Patient) {
  //   return '${pInfo.pName} ${pInfo.pSurname}';
  // } else {
  //   return '${dInfo.drName} ${dInfo.drSurname}';
  // }
  // }

  void triggerOnline() {
    online = !online;
    notifyListeners();
  }

  void logout() {
    userToken = '';
    userId = '';
    role = Role.UnAuthen;
    userFname = null;
    online = false;
  }

  // Patient getPatientInfo() {
  //   return pInfo;
  // }
}
