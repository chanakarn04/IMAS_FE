import 'package:adhara_socket_io/adhara_socket_io.dart';

SocketIO socketIO;
SocketIOManager manager = new SocketIOManager();
Map<String, dynamic> token;

Future<Map<String, dynamic>> socketConnect(Map<String, String> token) async {
  // Map<String, dynamic> returnValue;
  socketIO = await manager.createInstance(SocketOptions(
    //Socket IO server URI
    'http://35.186.150.220:3000/',
    // header
    query: token,
    //Enable or disable platform channel logging
    // enableLogging: true,
    transports: [Transports.webSocket],
  ));
  // socketIO.onDisconnect.listen((event) {
  //   print('socket disconnected');
  // });
  // socketIO.onError.listen((event) {print('socket error');});
  await socketIO.connect().then((value) {
    socketIO.onConnect.listen((data) async {
      print('connected');
    });
  });
}

Future<Map<String, dynamic>> login(String password) async {
  await socketIO.emit('event', [
    {
      'transaction': 'login',
      'payload': {'password': password}
    }
  ]).then((_) {
    socketIO.on('r-login').listen((data) {
      print('On r-login: $data');
      if (data != null) {
        return {
          'userToken': data[0]['value']['passport']['token'],
          'userId': data[0]['value']['passport']['userid'],
          'role': data[0]['value']['payload']['userRole'],
        };
      }
    });
  });
}

Future<Map<String, dynamic>> register(Map<String, dynamic> payload) async {
  await socketIO.emitWithAck('event', [
    {
      'transaction': 'register',
      'payload': payload,
    }
  ]).then((data) {
    print(data);
  });
}

Future<void> socketDisconnect() async {
  manager
      .clearInstance(socketIO)
      .then((value) => print('clearInstance: $value'));
}
