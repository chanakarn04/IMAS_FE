import 'package:flutter/foundation.dart';
// import 'package:socket_io_client/socket_io_client.dart';

enum Role {
  UnAuthen,
  Patient,
  Doctor,
}
enum Gender {
  Male,
  Female,
}
enum Status {
  Yes,
  No,
  NotSure,
}

class Patient {
  final String pId;
  // final String userName;
  // final String password;
  final String pName;
  final String pSurname;
  final DateTime dob;
  final Gender gender;
  final List<String> drugAllegy;
  final Status isSmoke;
  final Status isDiabetes;
  final Status hasHighPress;

  Patient({
    @required this.pId,
    @required this.pName,
    @required this.pSurname,
    @required this.dob,
    @required this.gender,
    @required this.drugAllegy,
    @required this.isSmoke,
    @required this.isDiabetes,
    @required this.hasHighPress,
  });
}

class Doctor {
  final String drId;
  // final String userName;
  // final String password;
  final String namePrefix;
  final String drName;
  final String drSurname;
  final Gender gender;
  final int citizenID;
  final String mdID;
  final String certID;
  // final bool isApproved;

  Doctor({
    @required this.drId,
    @required this.namePrefix,
    @required this.drName,
    @required this.drSurname,
    @required this.gender,
    @required this.citizenID,
    @required this.mdID,
    @required this.certID,
  });
}

class UserInfo with ChangeNotifier {
  String userToken = '';
  String userId = '';
  Role role = Role.UnAuthen;
  Patient pInfo = null;
  Doctor dInfo = null;
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
      pInfo = Patient(
        pId: 'p0001',
        pName: 'testPusr',
        pSurname: 'testPsurname',
        dob: DateTime(1998, 4, 12),
        gender: Gender.Female,
        drugAllegy: ['Paracetamol'],
        isSmoke: Status.No,
        isDiabetes: Status.No,
        hasHighPress: Status.NotSure,
      );
      dInfo = null;
      // online = true;
    }
    if (userName == 'testDoctor' && password == '1234') {
      userToken = 'usrTk2';
      userId = 'testDr';
      role = Role.Doctor;
      pInfo = null;
      dInfo = Doctor(
        drId: 'd0001',
        namePrefix: 'Dr.',
        drName: 'testDname',
        drSurname: 'testDsurname',
        gender: Gender.Male,
        citizenID: 1234567891234,
        mdID: 'xxxxxxxxxxxxx',
        certID: 'xxxxxxxxxxxxx',
      );
      online = false;
    }
  }

  String getUserName() {
    // String tempName;
    // ...
    if (this.role == Role.Patient) {
      return '${pInfo.pName} ${pInfo.pSurname}';
    } else {
      return '${dInfo.drName} ${dInfo.drSurname}';
    }
  }

  void triggerOnline() {
    online = !online;
    notifyListeners();
  }

  // Patient getPatientInfo() {
  //   return pInfo;
  // }
}
