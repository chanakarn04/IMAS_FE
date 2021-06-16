import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homepage_proto/main.dart';

import './user-info.dart';
import '../Script/socketioScript.dart';
import '../Pages/homePages.dart';
import '../Pages/chatRoom.dart';

// chat message class
class ChatMessage {
  final String message;
  final Role role;

  ChatMessage({
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

  // initial chatroom
  Future<void> initChatroom({
    String userId,
    Role role,
    String thisTpid,
    String thisApid,
  }) async {

    // connect chat socket
    await chatSocketConnect({
      'token': '',
      'userid': '',
    });

    if ((thisTpid != null) && (thisApid != null)) {
      // emit data to regisChatroom in patient role
      await chatSocket.emit('regisChatroom', [
        {
          'userId': userId,
          'roomId': chatRoomId,
          'tpid': thisTpid,
          'apid': thisApid,
        }
      ]);
    } else {
      // emit data to regisChatroom in doctor role
      await Future.delayed(Duration(seconds: 1));
      await chatSocket.emit('regisChatroom', [
        {
          'userId': userId,
          'roomId': chatRoomId,
        }
      ]);
    }

    // wait response of regisChatroom
    await for (dynamic data in chatSocket.on('regisChatroom')) {
        tpid = data[0]['payload']['treatment']['tpid'];
        apid = data[0]['payload']['treatment']['apid'];

        // create payload to send in getProfile
        Map payload;
        if (role == Role.Patient) {
          payload = {
            'userRole': roleTranslate(Role.Doctor),
            'targetUserId': drid,
          };
        } else {
          payload = {
            'userRole': roleTranslate(Role.Patient),
            'targetUserId': pid,
          };
        }

        // emit data to getProfile
        await socketIO.emit('event', [
          {
            'transaction': 'getProfile',
            'payload': payload,
          }
        ]);

        // wait response of getProfile
        await for (dynamic data in socketIO.on('r-getProfile')) {
          if (data != null) {
            if (role == Role.Patient) {
              opName = ('${data[0]['value']['payload']['DRName']} ${data[0]['value']['payload']['DRSurname']}');
              break;
            } else {
              opName = ('${data[0]['value']['payload']['PName']} ${data[0]['value']['payload']['PSurname']}');
              break;
            }
          }
        }
        chatRoomRegis = true;
        chatSearching = false;
        notifyListeners();

        // change treatmentPlan status
        // emit data to updatePlan
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

        // wait response of updatePlan
        await for (dynamic data in socketIO.on('r-updatePlan')) {
          break;
        }

        break;
    }

    // wait response of chat message
    chatSocket.on('msg').listen((event) {
      messages.add(ChatMessage(
        message: event[0]['payload']['message'],
        role: roleGenerater(event[0]['payload']['from']),
      ));
      notifyListeners();
    });

    // wait for process when chatroom close
    chatSocket.on('deleteChat').listen((data) {
      isConsult = false;
      if (role == Role.Patient) {
        showDialog(
          context: scaffoldKey.currentContext,
          builder: (context) => AlertDialog(
              title: Text('This chat was close by doctor'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).popUntil(ModalRoute.withName(HomePage.routeName)),
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
        );
      }
      isConsult = false;
      chatRoomRegis = false;
      chatRoomId = '';
      messages = [];
      note = '';
      chatSocketDisconnect();
      notifyListeners();
    });
  }

  // doctor user use to wait for chat request from patient
  void onReqChatRoom({
    bool start,
    String userid,
  }) {
    // start waiting
    if (start) {
      reqCreateChatNoti = socketIO.on('r-req-create-chat-noti').listen((data) async {
        if (data != null) {
          pid = data[0]['value']['payload']['patientId'];
          drid = data[0]['value']['payload']['doctorId'];

          // popup to notify request to user
          await showDialog(
            barrierDismissible: false,
            context: scaffoldKey.currentContext,
            builder: (context) =>
              AlertDialog(
                title: Text('New request coming in'),
                actions: [

                  // cancel request
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();

                      // send patient request back to queue
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

                  // accept request
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(ChatRoom.routeName);

                      // create chat of doctor and patient
                      // emit data to createChat
                      socketIO.emit('event', [
                        {
                          'transaction': 'createChat',
                          'payload': {
                            'patientId': pid,
                            'doctorId': drid,
                          },
                        }
                      ]);

                      // wait response of createChat
                      await for (dynamic data in socketIO.on('r-createChat')) {
                        if (data != null) {
                          chatRoomId = data[0]['value']['payload']['chatRoomId'];
                          await initChatroom(
                            userId: userid,
                          );
                          break;
                        }
                      }
                      reqCreateChatNoti.cancel();
                      online = false;
                      isConsult = true;
                      notifyListeners();
                    },
                    child: Text('Accept'),
                  ),
                ],
              ),
          );
        }
      });
    // cancle waiting
    } else {
      reqCreateChatNoti.cancel();
    }
  }

  // trigger doctor online status
  Future<void> triggerDoctorOnline() async {
    // user must not in consulting
    if (!isConsult) {
      if (!online) {
        await socketIO.emit('event', [
          {
            'transaction': 'chatQueue',
            'payload': {'role': 'doctor'},
          }
        ]);
        online = true;
        notifyListeners();
      } else {
        await socketIO.emit('event', [
          {
            'transaction': 'deleteFromQueue',
          }
        ]);
        online = false;
        notifyListeners();
      }
    }
  }

  // patinet user request chat
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

  // doctor createChat from appointment
  void aptDoctorCreateChat(
    Role role,
  ) {
    aptCreateChat();
    rCreateChat(drid, role);
  }

  // emit to create chat from appointment
  Future<void> aptCreateChat() async {
    await socketIO.emit('event', [
      {
        'transaction': 'createChat',
        'payload': {
          'patientId': pid,
          'doctorId': drid,
        },
      }
    ]);
  }

  // create Chatroom from appointment
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

  // patient cancel chatroom request
  Future<void> patientDeleteQueue() async {
    await socketIO.emit('event', [
      {
        'transaction': 'deleteFromQueue',
      }
    ]);
    chatSearching = false;
    online = false;
    notifyListeners();
  }

  // send message
  Future<void> sendMessage({
    String message,
    String userId,
    Role role,
  }) async {
    await chatSocket.emit('sendMsg', [
      {
        'message': message,
        'chatRoomId': chatRoomId,
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

  // update chat note
  // for doctor user only
  void updateNote(String newNote) {
    this.note = newNote;
  }

  // close chatroom
  // for doctor user only
  Future<void> deleteChatroom() async {
    isConsult = false;
    socketIO.emit('event', [
      {
        'transaction': 'deleteChat',
        'payload': {
          'roomId': chatRoomId,
        }
      }
    ]);
  }

  // load chat state after login
  Future<void> loadChatState({
    Role role,
    String userId,
  }) async {
    socketIO.emit('event', [
      {
        'transaction': 'loadChatState',
      }
    ]);
    await for (dynamic data in socketIO.on('r-loadChatState')) {
      final Map<String, dynamic> payload =
          Map<String, dynamic>.from(data[0]['value']['payload']);
      if (!payload.containsKey('message')) {
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

  // clear every data in chat provider
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
}
