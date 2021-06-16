import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:provider/provider.dart';
import './notiScript.dart';

import '../main.dart';
import '../Pages/appointmentPatient.dart';
import '../Pages/appointmentDoctor.dart';
import '../Pages/vitalSignStartPages.dart';
import '../Provider/vitalSign_Info.dart';
import '../Provider/user-info.dart';
import '../Provider/chatRoom_info.dart';

SocketIO socketIO;
SocketIO loginSocket;
SocketIO regisSocket;
SocketIO chatSocket;
SocketIOManager manager = new SocketIOManager();

aptPatientNoti(ChatRoomProvider chatroom, String userId) {
  chatroom.rCreateChat(userId, Role.Patient);
  notiNavigatorPush(
    context: scaffoldKey.currentContext,
    routeName: AppointmentPatientPage.routeName,
  );
}

// connect main socket
Future<Map<String, dynamic>> socketConnect(token) async {
  // setup
  socketIO = await manager.createInstance(SocketOptions(
    'http://35.186.150.220:3000/',
    query: token,
    enableLogging: true,
    transports: [Transports.webSocket],
  ));

  // connect
  await socketIO.connect();

  // wait for appointment_alert
  socketIO.on('appointment_alert').listen((data) async {
    notificationsPlugin.initialize(initSetttings);
    notificationsPlugin.show(0, 'Appointment Alert', 'You have appointment in 15 minutes', notiDetails);
  });

  // wait for appointment_noti
  socketIO.on('appointment_noti').listen((data) async {
    final userInfo = Provider.of<UserInfo>(scaffoldKey.currentContext, listen: false);
    final chatroom = Provider.of<ChatRoomProvider>(scaffoldKey.currentContext, listen: false);
    final payload = data[0]['value']['payload'];
    chatroom.pid = payload['pid'];
    chatroom.drid = payload['drid'];
    chatroom.tpid = payload['tpid_ref'];
    chatroom.apid = payload['_id'];
    notificationsPlugin.initialize(
      initSetttings,
      onSelectNotification: (userInfo.role == Role.Patient)
          ? aptPatientNoti(chatroom, userInfo.userId)
          : notiNavigatorPush(
              context: scaffoldKey.currentContext,
              routeName: AppointmentDoctorPage.routeName,
            ),
    );
    notificationsPlugin.show(0, 'Appointment Noti', 'You have appointment now!', notiDetails);
  });

  // wait for vital_alert
  socketIO.on('vital_alert').listen((data) async {
    notificationsPlugin.initialize(initSetttings);
    notificationsPlugin.show(0, 'Vital sign Noti', 'You have to measure your vital sign in 15 minutes', notiDetails);
  });

  // wait for vital_alert
  socketIO.on('vital_noti').listen((data) async {
    final vs = Provider.of<VitalSignProvider>(scaffoldKey.currentContext, listen: false);
    vs.tpId = data[0]['value']['payload']['tpid_ref'];
    vs.apId = data[0]['value']['payload']['_id'];
    notificationsPlugin.initialize(initSetttings,
      onSelectNotification: notiNavigatorPush(
        context: scaffoldKey.currentContext,
        routeName: VitalSignStartPage.routeName,
      ),
    );
    notificationsPlugin.show(0, 'Vital sign alert', 'You have to measure your vital sign now!', notiDetails);
  });
}

// connect login socket
Future<Map<String, dynamic>> loginSocketConnect(token) async {
  // setup
  loginSocket = await manager.createInstance(SocketOptions(
    'http://35.186.150.220:3000/',
    query: token,
    enableLogging: true,
    transports: [Transports.webSocket],
  ));

  // connect
  await loginSocket.connect();
}

// connect register socket
Future<Map<String, dynamic>> regisSocketConnect(Map<String, String> token) async {
  // setup
  regisSocket = await manager.createInstance(SocketOptions(
    'http://35.186.150.220:3000/',
    query: token,
    enableLogging: true,
    transports: [Transports.webSocket],
  ));

  // connect
  await regisSocket.connect();
}

// connect chat socket
Future<Map<String, dynamic>> chatSocketConnect(token) async {
  // setup
  chatSocket = await manager.createInstance(SocketOptions(
    'http://35.240.159.152:3000/',
    query: token,
    enableLogging: true,
    transports: [Transports.webSocket],
  ));

  // connect
  await chatSocket.connect();
}

// disconnect main socket
Future<void> socketDisconnect() async {
  await manager.clearInstance(socketIO);
}

// disconnect login socket
Future<void> loginSocketDisconnect() async {
  await manager.clearInstance(loginSocket);
}

// disconnect register socket
Future<void> regisSocketDisconnect() async {
  await manager.clearInstance(regisSocket);
}

// disconnect chat socket
Future<void> chatSocketDisconnect() async {
  await manager.clearInstance(chatSocket);
}
