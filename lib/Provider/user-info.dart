import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

// calculate age
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

  // get user profile information
  Future<void> getUserProfile() async {

    // emit data to getProfile
    await IO.socketIO.emit('event', [
      {
        'transaction': 'getProfile',
        'payload': {'userRole': roleTranslate(role)}
      }
    ]);

    // waif response of getProfile
    await for (dynamic data in IO.socketIO.on('r-getProfile')) {
      final tempData = data[0]['value']['payload'];
      if (role == Role.Patient) {
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
    }
  }

  // get treatment plan and appointment
  Future<void> getTpApt() async {

    // get treatment plan
    // emit data to get-plan
    IO.socketIO.emit('event', [
      {
        'transaction': 'get-plan',
        'payload': {
          'role': roleTranslate(role),
          'status': [0, 1, 2, 3],
        }
      }
    ]);

    // wait response of get-plan
    await for (dynamic event in IO.socketIO.on('r-get-plan')) {
      final data = List.from(event[0]['value']['payload']);
      if (data.isNotEmpty) {
        for (dynamic tp in data) {
          treatmentPlan.add({
            'tpid': tp['_id'],
            'status': tpStatusGenerate(tp['status']),
            'pid': tp['pid'],
            'drid': tp['drid'],
          });
        }

        // find last treatment plan
        Map<String, dynamic> _lastTpid;
        if (treatmentPlan.isEmpty) {
          _lastTpid = null;
        } else {
          _lastTpid = treatmentPlan.firstWhere(
              (element) => element['status'] == TreatmentStatus.InProgress,
              orElse: () => null);
        }

        // get appointment of last treatment plan
        if (_lastTpid != null) {

          // emit data to get-appointment
          await IO.socketIO.emit('event', [
            {
              'transaction': 'get-appointments',
              'payload': {
                'tpid': _lastTpid['tpid'],
              },
            }
          ]);

          // wait response of get-appointment
          await for (dynamic data in IO.socketIO.on('r-get-appointments')) {
            for (dynamic apt in data[0]['value']['payload']['appointment']) {
              appointment.add({
                'apid': apt['_id'],
                'tpid': apt['tpid_ref'],
                'aptDate': DateTime.parse(apt['apdt']),
                'status': aptStatusGenerate(apt['status']),
              });
            }
            lastApt = appointment.firstWhere(
              (apt) =>
                  (apt['status'] == AptStatus.Waiting) &&
                  (DateTime.parse(apt['aptDate'].toString())
                              .difference(DateTime.now())
                              .inMinutes -
                          390 <=
                      30),
              orElse: () => {},
            );
            break;
          }
        }
        break;
      }
    }
  }

  Future<void> login(
    String userName,
    String password,
  ) async {

    // connect login scoket
    await IO.loginSocketConnect({
      'token': '',
      'userid': userName,
    });

    // emit data to login
    await IO.loginSocket.emit('event', [
      {
        'transaction': 'login',
        'payload': {'password': password}
      }
    ]);

    // wait response of login
    await for (var event in IO.loginSocket.on('r-login')) {
      final data = Map<String, dynamic>.from(event[0]);
      if (data['value']['payload'].containsKey('userRole')) {
        userToken = data['value']['passport']['token'];
        userId = data['value']['passport']['userid'];
        role = roleGenerater(data['value']['payload']['userRole']);
        // disconnect login socket
        await IO.loginSocketDisconnect();
        // connect main socket
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
    }
  }

  // update last appointment
  Future<void> updatePatientLastApt() async {

    Map<String, dynamic> _lastTpid;

    // emit data to get-plan
    IO.socketIO.emit('event', [
      {
        'transaction': 'get-plan',
        'payload': {
          'role': roleTranslate(role),
          'status': [0, 1, 2, 3],
        }
      }
    ]);
    // wait response of get-plan
    await for (dynamic event in IO.socketIO.on('r-get-plan')) {
      final data = List.from(event[0]['value']['payload']);
      if (data.isNotEmpty) {
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

    // find last treatment plan
    if (treatmentPlan.isEmpty) {
      _lastTpid = null;
    } else {
      _lastTpid = treatmentPlan.firstWhere(
          (element) => element['status'] == TreatmentStatus.InProgress,
          orElse: () => null);
    }

    // get appointment of last treatment plan
    if (_lastTpid != null) {

      // emit data to get-appointment
      await IO.socketIO.emit('event', [
        {
          'transaction': 'get-appointments',
          'payload': {
            'tpid': _lastTpid['tpid'],
          },
        }
      ]);

      // wait response of get-appointment
      await for (dynamic data in IO.socketIO.on('r-get-appointments')) {
        for (dynamic apt in data[0]['value']['payload']['appointment']) {
          appointment.add({
            'apid': apt['_id'],
            'tpid': apt['tpid_ref'],
            'aptDate': DateTime.parse(apt['apdt']).add(Duration(hours: 7)),
            'status': aptStatusGenerate(apt['status']),
          });
        }
        lastApt = appointment.firstWhere(
          (apt) =>
              (apt['status'] == AptStatus.Waiting) &&
              (apt['aptDate']
                          .difference(DateTime.now())
                          .inDays >= 0),
          orElse: () => {},
        );
        break;
      }
      notifyListeners();
    }
  }

  // get appointment data to map in calendar
  Future<void> calendarAppointment() async {

    ptFollowUp = [];
    List<Map<String, dynamic>> _pNameOfTreatment = [];
    List<String> _treatmentPlans = [];

    // emit data to get-plan
    IO.socketIO.emit('event', [
      {
        'transaction': 'get-plan',
        'payload': {
          'role': roleTranslate(role),
          'status': [0, 1, 2, 3],
        }
      }
    ]);

    // wait response of get-plan
    await for (dynamic event in IO.socketIO.on('r-get-plan')) {
      final data = List.from(event[0]['value']['payload']);
      if (data.isNotEmpty) {
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

      await for (dynamic data in IO.socketIO.on('r-get-calendar-appointments')) {
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
    }
  }

  // get patient info to show in patient follow up page
  Future<void> patientFollowUpInfo() async {
    
    List<Map<String, dynamic>> _tempApt;

    for (Map<String, dynamic> tp in treatmentPlan) {
      _tempApt = calendarApt.where((element) => element['tpid'] == tp['tpid']).toList();
      _tempApt.sort((a, b) => b['apDt'].compareTo(a['apDt']));
      ptFollowUp.add(_tempApt[0]);
    }
    ptFollowUpLoading = false;
    notifyListeners();
  }


  // update treatment plan status
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
      break;
    }
  }

  // logout
  Future<void> logout() async {

    // emit data to logout
    await IO.socketIO.emit('event', [
      {
        'transaction': 'logout',
      }
    ]);
    // wait response of logout
    await for (dynamic data in IO.socketIO.on('r-logout')) {
      if (data != null) {
        IO.socketDisconnect();
        IO.chatSocketDisconnect();
        userToken = '';
        userId = '';
        userData = {};
        treatmentPlan = [];
        appointment = [];
        role = Role.UnAuthen;
        notifyListeners();
        break;
      }
    }
  }
}
