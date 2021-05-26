import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart' as IO;
import 'package:homepage_proto/main.dart';

// import '../Models/model.dart';
import './user-info.dart';
import '../Script/socketioScript.dart';
import '../Widget/myAlertDialog.dart';
import '../Pages/homePages.dart';
import '../Pages/chatRoom.dart';
import '../Widget/WaitChatroomCreating.dart';

// import ;

class ChatMessage {
  final String message;
  // final String userID;
  final Role role;

  ChatMessage({
    // @required this.userID,
    @required this.message,
    @required this.role,
  });
}

class ChatRoomProvider with ChangeNotifier {
  var chatRoomRegis = false;
  String chatRoomId = '';
  var chatSearching = false;
  List<ChatMessage> messages = [];
  String pid = '';
  String drid = '';
  String tpid = '';
  String apid = '';
  String opName = '';

  String note = '';

  int status;
  String advice = '';
  List<String> symptoms = [];
  List<String> drugs = [];
  Map<String, String> conditions = {};

  StreamSubscription reqCreateChatNoti;

  var online = false;
  var isConsult = false;

  Future<void> initChatroom({
    String userId,
    Role role,
    String thisTpid,
    String thisApid,
  }) async {
    await chatSocketConnect({
      'token': '',
      'userid': '',
    });
    if ((thisTpid != null) && (thisApid != null)) {
      await chatSocket.emit('regisChatroom', [
        {
          'userId': userId,
          'roomId': chatRoomId,
          'tpid': thisTpid,
          'apid': thisApid,
        }
      ]);
    } else {
      await chatSocket.emit('regisChatroom', [
        {
          'userId': userId,
          'roomId': chatRoomId,
        }
      ]);
    }
    await for (dynamic data in chatSocket.on('regisChatroom')) {
      print('ChatSocket on regisChatroom:${data[0]['payload']['message']}');
        tpid = data[0]['payload']['treatment']['tpid'];
        apid = data[0]['payload']['treatment']['apid'];
        print('=====> tpid : $tpid');
        Map pl;
        if (role == Role.Patient) {
          pl = {
            'userRole': roleTranslate(Role.Doctor),
            'targetUserId': drid,
          };
        } else {
          pl = {
            'userRole': roleTranslate(Role.Patient),
            'targetUserId': pid,
          };
        }
        await socketIO.emit('event', [
          {
            'transaction': 'getProfile',
            'payload': pl,
          }
        ]);
        await for (dynamic data in socketIO.on('r-getProfile')) {
          print('On r-getProfile $data');
          if (data != null) {
            if (role == Role.Patient) {
              opName =
                  ('${data[0]['value']['payload']['DRName']} ${data[0]['value']['payload']['DRSurname']}');
              print('opponenname: $opName');
              break;
            } else {
              opName =
                  ('${data[0]['value']['payload']['PName']} ${data[0]['value']['payload']['PSurname']}');
              print('opponenname: $opName');
              break;
            }
          }
        }
        chatRoomRegis = true;
        chatSearching = false;
        notifyListeners();
        socketIO.emit('event', [
          {
            'transaction': 'updatePlan',
            'payload': {
              'tpid': tpid,
              'status': 0,
              'drid': userId,
            }
          }
        ]);
        await for (dynamic data in socketIO.on('r-updatePlan')) {
          print('On r-updatePlan ${data[0]['value']['payload']}');
          break;
        }
        break;
        // return true;

      // [{
      //   "transaction":"regisChatroom",
      //   "passport":null,
      //   "payload":{"message":"Successfully register user in chatroom!"}
      // }]
    }

    print('test');
    chatSocket.on('msg').listen((event) {
      print('On msg: $event');
      messages.add(ChatMessage(
        message: event[0]['payload']['message'],
        role: roleGenerater(event[0]['payload']['from']),
      ));
      print(messages);
      notifyListeners();
      // On msg:
      // [{
      //    transaction: msg,
      //    passport: null,
      //    payload: {from: patient, message: testPt}
      // }]
    });

    chatSocket.on('deleteChat').listen((data) {
      print('On deleteChat: $data');
      final payload = data[0]['payload'];
      // Received arguments::[{"transaction":"deleteChat","passport":null,"payload":{"message":"Successfully remove chatroom"}}]
      if (data != null) {
        print(payload);
        if (role == Role.Patient) {
          showDialog(
            context: scaffoldKey.currentContext,
            builder: (context) {
              return AlertDialog(
                title: Text('This chat was close by doctor'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName(HomePage.routeName));
                    },
                    child: Text(
                      'Ok',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
        isConsult = false;
        chatRoomRegis = false;
        chatRoomId = '';
        messages = [];
        note = '';
        chatSocketDisconnect();
        notifyListeners();
      } else {
        print('No data returned');
      }
    });
    print('finish on msg');
  }

  void onReqChatRoom({
    // BuildContext context,
    bool start,
    String userid,
  }) {
    if (start) {
      reqCreateChatNoti =
          socketIO.on('r-req-create-chat-noti').listen((data) async {
        print('on r-req-create-chat-noti: $data');
        if (data != null) {
          pid = data[0]['value']['payload']['patientId'];
          drid = data[0]['value']['payload']['doctorId'];
          await showDialog(
            barrierDismissible: false,
            context: scaffoldKey.currentContext,
            builder: (context) {
              var init;
              return AlertDialog(
                title: Text('New request coming in'),
                // content: Column(
                //   children: [],
                // ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      // print('Cancel');
                      // Send patient back to queue
                      Navigator.of(context).pop();
                      socketIO.emit('event', [
                        {
                          'transaction': 'manualAddQueue',
                          'payload': {
                            'role': 'patient',
                            'patId': pid,
                          },
                        }
                      ]);
                      reqCreateChatNoti.cancel();
                      online = false;
                      notifyListeners();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      print('Accept');
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(ChatRoom.routeName);
                      socketIO.emit('event', [
                        {
                          'transaction': 'createChat',
                          'payload': {
                            'patientId': pid,
                            'doctorId': drid,
                          },
                          // payload: {chatRoomId: pisut.s@mail.compasit.h@mail.com, patientId: pisut.s@mail.com, doctorId: pasit.h@mail.com}
                        }
                      ]);
                      await for (dynamic data in socketIO.on('r-createChat')) {
                        if (data != null) {
                          chatRoomId =
                              data[0]['value']['payload']['chatRoomId'];
                          // doctor not need apid / tpid
                          await initChatroom(
                            userId: userid,
                          );
                          break;
                        }
                      }
                      print('init chatroom');
                      reqCreateChatNoti.cancel();
                      online = false;
                      isConsult = true;
                      notifyListeners();
                      // if (init) {
                      // print('init chatroom');
                      //   reqCreateChatNoti.cancel();
                      //   online = false;
                      //   isConsult = true;
                      //   notifyListeners();
                      // } else {
                      //   print('cancel chatroom');
                      //   Navigator.of(context).pop();
                      //   reqCreateChatNoti.cancel();
                      //   online = false;
                      //   notifyListeners();
                      // }
                      // Navigator.of(context)
                      //     .pushNamed(WaitChatroomCreating.routeName);
                    },
                    child: Text('Accept'),
                  ),
                ],
              );
            },
          );
        }
      });
      print('finish onReqChatRoom');
    } else {
      reqCreateChatNoti.cancel();
    }
  }

  Future<void> triggerDoctorOnline() async {
    if (!isConsult) {
      if (!online) {
        await socketIO.emit('event', [
          {
            'transaction': 'chatQueue',
            'payload': {'role': 'doctor'},
          }
        ]);
        print('finish emitting');
        online = true;
        notifyListeners();
        // print('online in provider: $online');
        print('change online and notify');
      } else {
        await socketIO.emit('event', [
          {
            'transaction': 'deleteFromQueue',
            // 'payload': {}
          }
        ]);
        online = false;
        notifyListeners();
      }
    } else {
      print('inConsult');
    }
  }

  Future<void> patientReqChat(
    String userId,
    Role role,
    String newtpid,
    String newapid,
  ) async {
    online = true;
    tpid = newtpid;
    apid = newapid;
    chatSearching = true;
    await socketIO.emit('event', [
      {
        'transaction': 'chatQueue',
        'payload': {'role': roleTranslate(role)},
      }
    ]);
    await for (dynamic data in socketIO.on('r-createChat')) {
      isConsult = true;
      chatRoomId = data[0]['value']['payload']['chatRoomId'];
      pid = data[0]['value']['payload']['patientId'];
      drid = data[0]['value']['payload']['doctorId'];
      initChatroom(
        userId: userId,
        role: role,
        thisTpid: tpid,
        thisApid: apid,
      );
      break;
    }
  }

  // for doctor to createChat from appointment
  Future<void> aptCreateChat() async {
    await socketIO.emit('event', [
      {
        'transaction': 'createChat',
        'payload': {
          'patientId': pid,
          'doctorId': drid,
        },
        // payload: {chatRoomId: pisut.s@mail.compasit.h@mail.com, patientId: pisut.s@mail.com, doctorId: pasit.h@mail.com}
      }
    ]);
  }

  void aptDoctorCreateChat(
    Role role,
  ) {
    aptCreateChat();
    rCreateChat(drid, role);
  }

  // use for createChat from appointment
  Future<void> rCreateChat(
    String userId,
    Role role,
  ) async {
    await for (dynamic data in socketIO.on('r-createChat')) {
      isConsult = true;
      chatRoomId = data[0]['value']['payload']['chatRoomId'];
      pid = data[0]['value']['payload']['patientId'];
      drid = data[0]['value']['payload']['doctorId'];
      initChatroom(
        userId: userId,
        role: role,
        thisTpid: tpid,
        thisApid: apid,
      );
      break;
    }
  }

  Future<void> patientDeleteQueue() async {
    await socketIO.emit('event', [
      {
        'transaction': 'deleteFromQueue',
        // 'payload': {}
      }
    ]);
    chatSearching = false;
    online = false;
    notifyListeners();
  }

  Future<void> sendMessage({
    String message,
    String userId,
    Role role,
  }) async {
    await chatSocket.emit('sendMsg', [
      {
        'message': message,
        'chatRoomId': chatRoomId,
        // 'chatRoomId': 'pisut.s@mail.compasit.h@mail.com',
        'userId': userId,
        'role': roleTranslate(role),
      }
    ]);
    messages.add(ChatMessage(
      message: message,
      role: role,
    ));
    notifyListeners();
  }

  // Future<void> saveChatRoom() async {
  //   // Save data
  //   await socketIO.emit('event', [
  //     {
  //       'transaction': 'save-from-chatroom',
  //       'payload': {
  //         'apid': apid,
  //         'note': note,
  //         'advice': advice,
  //         'status': 2,
  //         'symptoms': symptoms,
  //         'conditions': conditions,
  //         'drugs': drugs
  //       }
  //     }
  //   ]);

  //   // Waiting for data return
  //   await for (dynamic data in socketIO.on('r-save-from-chatroom')) {
  //     print('On r-save-from-chatroom: $data');
  //     final payload = data[0]['value']['payload'];
  //     if (data != null) {
  //       print(payload);
  //       notifyListeners();
  //     } else {
  //       print('No data returned');
  //     }
  //     break;
  //   }
  // }

  // void chatRequest(Role role) {
  //   // in patient send userId to request
  //   socketIO.emit('event', [
  //     {
  //       'transaction': 'chatQueue',
  //       'payload': {'role': roleTranslate(role)}
  //     }
  //   ]);

  //   // ====> MOCK <=====
  //   socketIO.on('r-createChat').listen((data) async {
  //     print('On r-createChat: $data');
  //     chatSocket = await IO.SocketIOManager().createInstance(IO.SocketOptions(
  //       'http://35.240.159.152:3000/',
  //       query: {
  //         // 'token': token['token'],
  //         // 'userid': token['userid'],
  //         'token': '',
  //         'userid': '',
  //       },
  //       enableLogging: true,
  //       transports: [IO.Transports.webSocket],
  //     ));
  //     chatSocket.connect().then((value) => print('ChatScoket Connected'));
  //     chatSocket.emit('regisChatroom', [
  //       {
  //         'userId': 'pisut.s@mail.com',
  //       }
  //     ]);
  //     chatSocket.on('r-regisChatroom').listen((event) {
  //       print('On r-regisChatroom: $event');
  //     });
  //     chatSocket.on('msg').listen((event) {
  //       print('On msg: $event');
  //     });
  //   });

  //   // in doctor trigger status to online to request
  //   // ...

  //   // if chat Room was create will get notification
  //   // NOTIFICATION??

  //   // get chatRoomId
  //   // chatRoomId = 'x000yx000y';
  //   // get opposite User id
  //   // opUserId = 'x0001';
  //   // notifyListeners();
  // }

  // void chatRegistor() {
  //   // ... ???
  // }

  void updateNote(String newNote) {
    this.note = newNote;
  }

  Future<void> deleteChatroom() async {
    // Save data
    socketIO.emit('event', [
      {
        'transaction': 'deleteChat',
        'payload': {
          'roomId': chatRoomId,
        }
      }
    ]);
  }

  Future<void> loadChatState({
    Role role,
    // String thisApid,
    // String thisTpid,
    String userId,
  }) async {
    socketIO.emit('event', [
      {
        'transaction': 'loadChatState',
      }
    ]);
    await for (dynamic data in socketIO.on('r-loadChatState')) {
      print('On r-loadChatState: ${data[0]['value']['payload']}');
      // "payload":{
      //   chatDetail: {
      //     docId: pasit.h@mail.com,
      //     patId: qwerty@mail.com,
      //     messages: [{message: tyy, role: patient}],
      //     tpid: null,
      //     apid: null
      //     roomId: qwerty@mail.comdoctor01@mail.com
      //   }
      // }
      // "payload":{message: Client has no avilable chat}
      final Map<String, dynamic> payload =
          Map<String, dynamic>.from(data[0]['value']['payload']);
      if (payload.containsKey('message')) {
        print('No chat State');
      } else {
        print('Have Chat State');
        final thisTpid = payload['chatDetail']['tpid'];
        final thisApid = payload['chatDetail']['apid'];
        chatRoomId = payload['chatDetail']['roomId'];
        messages = [];
        for (dynamic message in payload['chatDetail']['messages']) {
          messages.add(
            ChatMessage(
              message: message['message'],
              role: roleGenerater(message['role']),
            ),
          );
        }
        initChatroom(
          role: role,
          thisApid: thisApid,
          thisTpid: thisTpid,
          userId: userId,
        );
      }
      break;
    }
  }

  Future<void> closeChat() {
    chatRoomRegis = false;
    chatRoomId = '';
    chatSearching = false;
    messages = [];
    pid = '';
    drid = '';
    tpid = '';
    apid = '';
    opName = '';
    note = '';
    status = 0;
    advice = '';
    symptoms = [];
    drugs = [];
    conditions = {};
    var online = false;
    var isConsult = false;
  }
//   void sendMessage(
//     String userId,
//     String messageText,
//     Role role,
//   ) {
//     ChatMessage message = ChatMessage(
//       // userID: userId,
//       message: messageText,
//       role: role,
//     );
//     // add message to list
//     messages.add(message);
//     // upload to server
//     // ...
//     notifyListeners();
//   }
// }
}
