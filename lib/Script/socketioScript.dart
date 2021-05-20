import 'package:adhara_socket_io/adhara_socket_io.dart';
import './notiScript.dart';

import '../main.dart';
import '../Pages/appointmentPatient.dart';
import '../Pages/vitalSignStartPages.dart';

SocketIO socketIO;
SocketIO loginSocket;
SocketIO regisSocket;
SocketIO chatSocket;
SocketIOManager manager = new SocketIOManager();
// Map<String, dynamic> token;

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void notiTest() {
  notificationsPlugin.initialize(initSetttings);
  notificationsPlugin.show(
        0, 'Appointment Alert', 'You have appointment in 15 minutes', notiDetails);
}

Future<Map<String, dynamic>> socketConnect(token) async {
  socketIO = await manager.createInstance(SocketOptions(
    //Socket IO server URI
    'http://35.186.150.220:3000/',
    // header
    query: token,
    //Enable or disable platform channel logging
    enableLogging: true,
    transports: [Transports.webSocket],
  ));
  await socketIO.connect();
  socketIO.onConnect.listen((data) async {
    print('main socket connected');
  });
  socketIO.onError.listen((data) async {
    print('onError: $data');
  });
  socketIO.onDisconnect.listen((data) async {
    print('Disconnect');
  });
  socketIO.on('appointment_alert').listen((data) async {
    print('appointment_alert: $data');
    notificationsPlugin.initialize(initSetttings);
    notificationsPlugin.show(
        0, 'Appointment Alert', 'You have appointment in 15 minutes', notiDetails);
  });
  socketIO.on('appointment_noti').listen((data) async {
    print('appointment_noti: $data');
    notificationsPlugin.initialize(initSetttings,
        onSelectNotification: notiNavigatorPush(
            context: scaffoldKey.currentContext,
            routeName: VitalSignStartPage.routeName));
    notificationsPlugin.show(
        0, 'Appointment Noti', 'You have appointment now!', notiDetails);
  });
  socketIO.on('vital_alert').listen((data) async {
    print('vital_alert: $data');
    notificationsPlugin.initialize(initSetttings,
        onSelectNotification: notiNavigatorPush(
            context: scaffoldKey.currentContext,
            routeName:  VitalSignStartPage.routeName));
    notificationsPlugin.show(
        0, 'Vital sign alert', 'You have to measure your vital sign in 15 minutes', notiDetails);
  });
  socketIO.on('vital_noti').listen((data) async {
    print('vital_noti: $data');
    notificationsPlugin.initialize(initSetttings,
        onSelectNotification: notiNavigatorPush(
            context: scaffoldKey.currentContext,
            routeName:  VitalSignStartPage.routeName));
    notificationsPlugin.show(
        0, 'Vital sign alert', 'You have to measure your vital sign now!', notiDetails);
  });
}

Future<Map<String, dynamic>> loginSocketConnect(token) async {
  loginSocket = await manager.createInstance(SocketOptions(
    //Socket IO server URI
    'http://35.186.150.220:3000/',
    // header
    query: token,
    //Enable or disable platform channel logging
    enableLogging: true,
    transports: [Transports.webSocket],
  ));
  await loginSocket.connect().then((value) {
    loginSocket.onConnect.listen((data) async {
      print('login socket connected');
    });
  });
}

Future<Map<String, dynamic>> regisSocketConnect(Map<String, String> token) async {
  regisSocket = await manager.createInstance(SocketOptions(
    //Socket IO server URI
    'http://35.186.150.220:3000/',
    // header
    query: token,
    //Enable or disable platform channel logging
    enableLogging: true,
    transports: [Transports.webSocket],
  ));
  await regisSocket.connect().then((value) {
    regisSocket.onConnect.listen((data) async {
      print('regis socket connected');
    });
  });
}

Future<Map<String, dynamic>> chatSocketConnect(token) async {
  chatSocket = await manager.createInstance(SocketOptions(
    //Socket IO server URI
    'http://35.240.159.152:3000/',
    // header
    query: token,
    //Enable or disable platform channel logging
    enableLogging: true,
    transports: [Transports.webSocket],
  ));
  await chatSocket.connect().then((value) {
    chatSocket.onConnect.listen((data) async {
      print('chat socket connected');
    });
  });
}

// Future<Map<String, dynamic>> login(String password) async {
//   await socketIO.emit('event', [
//     {
//       'transaction': 'login',
//       'payload': {'password': password}
//     }
//   ]).then((_) {
//     socketIO.on('r-login').listen((data) {
//       print('On r-login: $data');
//       if (data != null) {
//         return {
//           'userToken': data[0]['value']['passport']['token'],
//           'userId': data[0]['value']['passport']['userid'],
//           'role': data[0]['value']['payload']['userRole'],
//         };
//       }
//     });
//   });
// }

// Future<Map<String, dynamic>> register(Map<String, dynamic> payload) async {
//   await socketIO.emitWithAck('event', [
//     {
//       'transaction': 'register',
//       'payload': payload,
//     }
//   ]).then((data) {
//     print(data);
//   });
// }

Future<void> socketDisconnect() async {
  await manager
      .clearInstance(socketIO)
      .then((value) => print('clearInstance socketIO: $value'));
}

Future<void> loginSocketDisconnect() async {
  await manager
      .clearInstance(loginSocket)
      .then((value) => print('clearInstance loginSocket: $value'));
}

Future<void> regisSocketDisconnect() async {
  await manager
      .clearInstance(regisSocket)
      .then((value) => print('clearInstance regisScoket: $value'));
}

Future<void> chatSocketDisconnect() async {
  await manager
      .clearInstance(chatSocket)
      .then((value) => print('clearInstance chatSocket: $value'));
}
