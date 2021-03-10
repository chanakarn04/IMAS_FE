import 'package:flutter/foundation.dart';
// import 'package:socket_io_client/socket_io_client.dart';

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

  void login(
    String userName,
    String password,
  ) {
    // ...
    // Socket socket;
    // socket = io(
    //     'ws://10.0.2.2:3000',
    //     OptionBuilder()
    //         .setTransports(['websocket']) // for Flutter or Dart VM
    //         .disableAutoConnect() // disable auto-connection
    //         .setExtraHeaders({
    //           'token': null,
    //           'userid': userName,
    //           'password': password,
    //         })
    //         .build());
    // socket.connect().onConnectError((data) => print(data));
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

  // Patient getPatientInfo() {
  //   return pInfo;
  // }
}
