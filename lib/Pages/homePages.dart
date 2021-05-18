import 'dart:async';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/material.dart';
import 'package:homepage_proto/Pages/chatRoom.dart';
import 'package:homepage_proto/main.dart';
import 'package:provider/provider.dart';

import './assessmentPages.dart';
import './patientFollowUpPage.dart';
import '../Widget/adaptiveRaisedButton.dart';
import '../Widget/Logo.dart';
import '../Widget/sideDrawer.dart';
import '../Provider/user-info.dart';
import '../Provider/chatRoom_info.dart';
import '../Script/socketioScript.dart' as IO;

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  // data if role = doctor
  // String drName = 'Samitanan';

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context, listen: false);
    final chatProvider = Provider.of<ChatRoomProvider>(context, listen: false);
    final mdqr = MediaQuery.of(context);
    final scndColor = Color.fromARGB(255, 75, 75, 75);
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      endDrawer: SideDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mdqr.size.width * 0.05,
          vertical: mdqr.size.width * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Drawer(),
            SizedBox(
              height: mdqr.size.height * 0.35,
              child: (userInfo.role == Role.Doctor)
                  ? ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        TextButton(
                          onPressed: () async {
                            userInfo.countStreamSubscriptionTest(true);
                          },
                          child: Container(
                              color: Colors.amber[200],
                              child: Text('Stream Test')),
                        ),
                        TextButton(
                          onPressed: () async {
                            userInfo.countStreamSubscriptionTest(false);
                          },
                          child: Container(
                              color: Colors.amber[200],
                              child: Text('Stream Test')),
                        ),
                        TextButton(
                          onPressed: () async {
                            IO.notiTest();
                          },
                          child: Container(
                            child: Text(
                              'Noti Test',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // print('=======> chat queue <=======');
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'chatQueue',
                                'payload': {'role': 'doctor'},
                              }
                            ]);
                            IO.socketIO
                                .on('r-req-create-chat-noti')
                                .listen((event) {
                              print('On r-req-create-chat-noti: $event');
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return AlertDialog(
                              //       title: Text('New Request'),
                              //       // content: Column(
                              //       //   children: [],
                              //       // ),
                              //       actions: [
                              //         TextButton(
                              //           onPressed: () {
                              //             print('Cancel');
                              //             Navigator.of(context).pop();
                              //           },
                              //           child: Text('Cancel'),
                              //         ),
                              //         TextButton(
                              //           onPressed: () {
                              //             print('Accept');
                              //             Navigator.of(context).pop();
                              //           },
                              //           child: Text('Accept'),
                              //         ),
                              //       ],
                              //     );
                              //   },
                              // );
                            });
                          },
                          child: Text('online'),
                        ),
                        SizedBox(width: 15),
                        TextButton(
                          onPressed: () {
                            // print('=======> delete from queue <=======');
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'deleteFromQueue',
                                // 'payload': {'role': 'doctor'},
                              }
                            ]);
                          },
                          child: Text('offline'),
                        ),
                        TextButton(
                          onPressed: () {
                            // print('=======> delete from queue <=======');
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'createChat',
                                'payload': {
                                  'patientId': 'pisut.s@mail.com',
                                  'doctorId': 'pasit.h@mail.com'
                                },
                                // payload: {patientId: pisut.s@mail.com, doctorId: pasit.h@mail.com}
                                // payload: {chatRoomId: pisut.s@mail.compasit.h@mail.com, patientId: pisut.s@mail.com, doctorId: pasit.h@mail.com}
                              }
                            ]);
                            IO.socketIO.on('r-createChat').listen((data) async {
                              print('On r-createChat: $data');
                              IO.chatSocket = await SocketIOManager()
                                  .createInstance(SocketOptions(
                                'http://35.240.159.152:3000/',
                                query: {
                                  'token': '',
                                  'userid': '',
                                  // 'token': IO.token['token'],
                                  // 'userid': IO.token['userid'],
                                },
                                enableLogging: true,
                                transports: [Transports.webSocket],
                              ));
                              IO.chatSocket.connect().then(
                                  (value) => print('ChatScoket Connected'));
                              IO.chatSocket.emit('regisChatroom', [
                                {
                                  'userId': 'pasit.h@mail.com',
                                  'tpid': '',
                                  'apid': '',
                                }
                              ]);
                              IO.chatSocket.on('regisChatroom').listen((event) {
                                print('On regisChatroom: $event');
                              });
                              IO.chatSocket.on('msg').listen((event) {
                                print('On msg: $event');
                              });
                            });
                          },
                          child: Text('createChat'),
                        ),
                        TextButton(
                          onPressed: () {
                            // print('=======> delete from queue <=======');
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'deleteChat',
                                'payload': {
                                  'roomId': 'pisut.s@mail.compasit.h@mail.com'
                                },
                              }
                            ]);
                            IO.chatSocket.on('deleteChat').listen((data) {
                              print('On r-deleteChat: $data');
                            });
                          },
                          child: Text('deleteChatroom'),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'save-from-chatroom',
                                'payload': {
                                  'apid': '608e6cc18f0f9c001e97ff98',
                                  'note': '',
                                  'advice': 'Kin khao Yer Yer',
                                  'status': 0,
                                  'symtoms': <String>['Headache', 'Paralyze'],
                                  'conditions': {
                                    'c_780': 'Nose injury',
                                  },
                                  'drugs': ['Weeds', 'Heroin']
                                },
                              }
                            ]);
                            IO.socketIO
                                .on('r-save-from-chatroom')
                                .listen((data) {
                              print('On r-save-from-chatroom: $data');
                            });
                          },
                          child: Text('Save from chat'),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'get-appointments',
                                'payload': {
                                  'tpid': '608e6cc18f0f9c001e97ff97',
                                },
                              }
                            ]);
                            IO.socketIO.on('r-get-appointments').listen((data) {
                              print('On r-get-appointments: $data');
                            });
                          },
                          child: Text(
                            'Get APT',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'get-prescription',
                                'payload': {
                                  'tpid': '608e6cc18f0f9c001e97ff97',
                                },
                              }
                            ]);
                            IO.socketIO.on('r-get-prescription').listen((data) {
                              print('On r-get-prescription: $data');
                              // payload: [{prescription: [Weeds, Heroin], advice: Kin khao Yer Yer}]
                            });
                          },
                          child: Text(
                            'Get Prescription',
                            style: TextStyle(color: Colors.teal),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'create-new-appointment',
                                'payload': {
                                  // 'tpid': '608e6cc18f0f9c001e97ff97',
                                  'tpid': '609a336dc5100400298ed475',
                                  // this is Doctor UserName
                                  'drid': userInfo.userData['userName'],
                                  // this is Patient UserName
                                  'pid': 'pisut.s@mail.com',
                                  'apdt': DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    DateTime.now().hour,
                                    DateTime.now().minute + 18,
                                  ).toString(),
                                },
                              }
                            ]);
                            IO.socketIO
                                .on('r-create-appointment')
                                .listen((data) {
                              print('On r-create-appointment: $data');
                              // payload: [{prescription: [Weeds, Heroin], advice: Kin khao Yer Yer}]
                            });
                          },
                          child: Text(
                            'create-Appoitment',
                            style: TextStyle(color: Colors.lime),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // print('=======> chat queue <=======');
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'insert-condition-data',
                                'payload': {
                                  'conditions': [
                                    {
                                      "id": "c_test",
                                      "type": "condition",
                                      "name": "Condition for testing",
                                      "common_name": "Condition test",
                                      "description": "This is description"
                                    }
                                  ]
                                },
                              }
                            ]);
                            IO.socketIO
                                .on('r-insert-condition-data')
                                .listen((event) {
                              print('On r-insert-condition-data: $event');
                            });
                          },
                          child: Text('insert condition detail'),
                        ),
                      ],
                    )
                  // ====> TEST BUTTON OF PATIENT <====
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        TextButton(
                          onPressed: () async {
                            print('This is 0 second');
                            await Future.delayed(Duration(seconds: 5));
                            print('This is 5 second pass');
                            await for (int value in IO.countStream(5)) {
                              print('Stream Value: $value');
                            }
                            ;
                            print('This is Stream pass');
                            await Future.delayed(Duration(seconds: 5));
                            print('This is 5 second pass');
                          },
                          child: Container(
                              color: Colors.amber[200],
                              child: Text('Future Test')),
                        ),
                        TextButton(
                          onPressed: () async {
                            userInfo.countStreamSubscriptionTest(true);
                          },
                          child: Container(
                              color: Colors.amber[200],
                              child: Text('Stream Test')),
                        ),
                        TextButton(
                          onPressed: () async {
                            userInfo.countStreamSubscriptionTest(false);
                          },
                          child: Container(
                              color: Colors.amber[200],
                              child: Text('Stream Test')),
                        ),
                        TextButton(
                          onPressed: () {
                            // print('=======> chat queue <=======');
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'chatQueue',
                                'payload': {'role': 'patient'},
                              }
                            ]);

                            IO.socketIO.on('r-createChat').listen((data) async {
                              print('On r-createChat: $data');
                              chatProvider.chatRoomId =
                                  data[0]['value']['payload']['chatRoomId'];
                              chatProvider.pid =
                                  data[0]['value']['payload']['patientId'];
                              chatProvider.drid =
                                  data[0]['value']['payload']['doctorId'];
                              // Emit updatePlan
                              IO.chatSocket = await SocketIOManager()
                                  .createInstance(SocketOptions(
                                'http://35.240.159.152:3000/',
                                query: {
                                  'token': '',
                                  'userid': '',
                                  // 'token': IO.token['token'],
                                  // 'userid': IO.token['userid'],
                                },
                                enableLogging: true,
                                transports: [Transports.webSocket],
                              ));
                              IO.chatSocket.connect().then(
                                  (value) => print('ChatScoket Connected'));
                              IO.chatSocket.emit('regisChatroom', [
                                {
                                  'userId': 'pisut.s@mail.com',
                                  'tpid': '608e6cc18f0f9c001e97ff97',
                                  'apid': '608e6cc18f0f9c001e97ff98',
                                }
                              ]);
                              IO.chatSocket.on('regisChatroom').listen((event) {
                                print('On regisChatroom: $event');
                                chatProvider.chatRoomRegis = true;
                                Navigator.of(context)
                                    .pushNamed(ChatRoom.routeName);
                              });
                              IO.chatSocket.on('msg').listen((event) {
                                print('On msg: $event');
                                chatProvider.messages.add(ChatMessage(
                                  message: event[0]['payload']['message'],
                                  role: roleGenerater(
                                      event[0]['payload']['from']),
                                  // notifylistenner()
                                ));
                              });
                            });
                          },
                          child: Text('online'),
                        ),
                        SizedBox(width: 15),
                        TextButton(
                          onPressed: () {
                            // print('=======> delete from queue <=======');
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'deleteFromQueue',
                                // 'payload': {'role': 'doctor'},
                              }
                            ]);
                          },
                          child: Text('offline'),
                        ),
                        TextButton(
                          onPressed: () {
                            // print('=======> delete from queue <=======');
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'deleteChat',
                                'payload': {
                                  'roomId': 'pisut.s@mail.compasit.h@mail.com'
                                },
                              }
                            ]);
                            IO.socketIO.on('r-deleteChat').listen((data) {
                              print('On r-deleteChat: $data');
                            });
                          },
                          child: Text('deleteChatroom'),
                        ),
                        TextButton(
                          onPressed: () {
                            // print('=======> delete from queue <=======');
                            // emit this when meet doctor at prediction result // api dianos finish
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'save-from-api',
                                'payload': {
                                  'pid': userInfo.userData['userName'],
                                  // 'drid': 'pasit.h@mail.com',
                                  'status': 3,
                                  'apDt': DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day,
                                          DateTime.now().hour,
                                          DateTime.now().minute + 7)
                                      .toString(),
                                  'symptoms': ['headache'],
                                  'conditions': {
                                    'c_255': 'Tetanus',
                                  }
                                },
                              }
                            ]);
                            IO.socketIO.on('r-save-from-api').listen((data) {
                              print('On r-save-from-api: $data');
                              // get apid and tpid
                              // tpid: 609a336dc5100400298ed475, apid: 609a336dc5100400298ed476
                              // payload: {message: Successfully save data from API, tpid: 609a31b09596b50029d5fff8, apid: 609a31b09596b50029d5fff9}
                            });
                          },
                          child: Text('SaveFromAPI'),
                        ),
                        TextButton(
                          onPressed: () {
                            // print('=======> delete from queue <=======');
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'updatePlan',
                                'payload': {
                                  'tpid':
                                      '609a336dc5100400298ed475', // get from save-to-API
                                  'status': 0, // talk to doctor status
                                  'drid':
                                      'pasit.h@mail.com' // get from createChat
                                },
                              }
                            ]);
                            IO.socketIO.on('r-updatePlan').listen((data) {
                              print('On r-updatePlan: $data');
                            });
                          },
                          child: Text('Update-TP-Status'),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'save-vital-pain',
                                'payload': {
                                  // 'vsid': ,
                                  'tpid': '609a336dc5100400298ed475',
                                  'apid': '609a336dc5100400298ed476',
                                  'pain_score': {
                                    'head ache': 3,
                                    'leg pain': 5,
                                  },
                                  'vsdt': DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    DateTime.now().hour,
                                    DateTime.now().minute,
                                  ).toString(),
                                  'body_temp': 36.5,
                                  'pulse': 120,
                                  'blood_pressure_top': 120,
                                  'blood_pressure_bottom': 80,
                                  'respiratory_rate': 90,
                                },
                              }
                            ]);
                            IO.socketIO.on('r-save-vital-pain').listen((data) {
                              print('On r-save-vital-pain: $data');
                            });
                          },
                          child: Text('save_vitalS_painS'),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'get-vital-sign-records',
                                'payload': {'tpid': '608e6cc18f0f9c001e97ff97'},
                              }
                            ]);
                            IO.socketIO
                                .on('r-get-vital-sign-records')
                                .listen((data) {
                              print('On r-get-vital-sign-records: $data');
                              // value: {transaction: r-get-appointments, passport: {token: , userid: pisut.s@mail.com}, payload: {appointment: null}}
                            });
                          },
                          child: Text(
                            'get-vital-sign-records',
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'get-appointments',
                                'payload': {
                                  'tpid': '608e6cc18f0f9c001e97ff97',
                                },
                              }
                            ]);
                            IO.socketIO.on('r-get-appointments').listen((data) {
                              print('On r-get-appointments: $data');
                              // value: {transaction: r-get-appointments, passport: {token: , userid: pasit.h@mail.com}, payload: {}}
                              // "payload":{"appointment":[
                              // {"status":2,"apdt":"2021-05-11T07:32:00.000Z","_id":"609a2ee41b45ee001e423709","tpid_ref":"608e6cc18f0f9c001e97ff97","__v":0},
                              // {"status":2,"apdt":"2021-05-09T14:42:00.000Z","_id":"6097f0aeb352ef0029f70c54","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-09T14:19:00.000Z","_id":"6097eb9feb45ca00292a9fed","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-09T14:01:00.000Z","_id":"6097ea28ff9bf400296e427d","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-09T13:52:00.000Z","_id":"6097e7e80fdfc20029f941f1","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-09T13:32:00.000Z","_id":"6097e335dece86001eb99bb8","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-07T17:28:00.000Z","_id":"609511b07fd282001e3e4945","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-07T17:14:00.000Z","_id":"609511c87fd282001e3e4946","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-07T17:02:00.000Z","_id":"60950b8ff986ba001e7b360b","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-07T16:25:00.000Z","_id":"609502e723b7fa001f826d3c","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-07T11:11:00.000Z","_id":"60951f20cd886d001ea5e9d0","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-06T18:31:00.000Z","_id":"6093c3611ddac9001e7d9e04","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-06T18:29:00.000Z","_id":"6093c2ee1ddac9001e7d9e03","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"Pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-06T18:18:00.000Z","_id":"6093c17c1ddac9001e7d9e02","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"P-00001","drid":"DR-00001","__v":0},
                              // {"status":2,"apdt":"2021-05-06T17:46:00.000Z","_id":"6093c88a4fa09c001e9c7852","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-06T17:40:00.000Z","_id":"6093c86b4fa09c001e9c7851","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"pisut.s@mail.com","drid":"pasit.h@mail.com","__v":0},
                              // {"status":2,"apdt":"2021-05-06T17:25:00.000Z","_id":"6093c0761ddac9001e7d9e01","tpid_ref":"608e6cc18f0f9c001e97ff97","pid":"P-00001","drid":"DR-00001","__v":0}]}}
                            });
                          },
                          child: Text(
                            'Query APT',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'get-prescription',
                                'payload': {
                                  'tpid': '608e6cc18f0f9c001e97ff97',
                                },
                              }
                            ]);
                            IO.socketIO.on('r-get-prescription').listen((data) {
                              print('On r-get-prescription: $data');
                              // payload: [{prescription: [Weeds, Heroin], advice: Kin khao Yer Yer}]
                            });
                          },
                          child: Text(
                            'Get Prescription',
                            style: TextStyle(color: Colors.teal),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'get-condition-symptom',
                                'payload': {'tpid': '608e6cc18f0f9c001e97ff97'},
                              }
                            ]);
                            IO.socketIO
                                .on('r-get-condition-symptom')
                                .listen((data) {
                              print('On r-get-condition-symptom: $data');
                              // [{apid: 608e6cc18f0f9c001e97ff98, date: 2021-05-02T09:11:29.896Z, pat_symptom: null}]
                            });
                          },
                          child: Text('get-condition-symptom'),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'close-plan',
                                'payload': {
                                  'tpid': '608e6cc18f0f9c001e97ff97',
                                  'status': 1
                                  // INPROGRESS = 0,
                                  // HEALED = 1,
                                  // HOSPITAL = 2,
                                  // API = 3
                                },
                              }
                            ]);
                            IO.socketIO.on('r-close-plan').listen((data) {
                              print('On r-close-plan: $data');
                            });
                          },
                          child: Text('close-plan'),
                        ),
                        TextButton(
                          onPressed: () {
                            // print('=======> chat queue <=======');
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'insert-condition-data',
                                'payload': {
                                  'conditions': [
                                    {
                                      "id": "c_test",
                                      "type": "condition",
                                      "name": "Condition for testing",
                                      "common_name": "Condition test",
                                      "description": "This is description"
                                    }
                                  ]
                                },
                              }
                            ]);
                            IO.socketIO
                                .on('r-insert-condition-data')
                                .listen((event) {
                              print('On r-insert-condition-data: $event');
                            });
                          },
                          child: Text('insert condition detail'),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'search-condition',
                                'payload': {
                                  'common_name': 'con',
                                },
                              }
                            ]);
                            IO.socketIO.on('r-search-condition').listen((data) {
                              print('On r-search-condition: $data');
                              // payload: {conditions: [{id: c_test, type: condition, name: Condition for testing, common_name: Condition test, description: This is description}]}
                            });
                          },
                          child: Text('search-cond-id'),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'get-condition-detail',
                                'payload': {
                                  'cid': 'c_test',
                                },
                              }
                            ]);
                            IO.socketIO
                                .on('r-get-condition-detail')
                                .listen((data) {
                              print('On r-get-condition-detail: $data');
                            });
                          },
                          child: Text('get-more-cond-detail'),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'manualAddQueue',
                                'payload': {
                                  // 'role': 'patient',
                                  // 'patId': 'pisut.s@mail.com'
                                  'role': 'doctor',
                                  'docId': 'pasit.h@mail.com'
                                },
                              }
                            ]);
                            // IO.socketIO.on('r-addHere').listen((data) {
                            //   print('On r-addHere: $data');
                            // });
                          },
                          child: Text('manualAddQueue'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await IO.socketIO.emit('event', [
                              {
                                'transaction': 'get-plan',
                                'payload': {
                                  'role': roleTranslate(userInfo.role),
                                  'status': 3,
                                }
                              }
                            ]);
                            await for (dynamic data
                                in IO.socketIO.on('r-getPlan')) {
                              print(data[0]['value']['payload']);
                              break;
                            }
                          },
                          child: Text('query tpid'),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'getProfile',
                                'payload': {
                                  'role': 'doctor',
                                  'targetUserId': 'pasit.h@mail.com',
                                  // 'role': 'patient',
                                  // 'targetUserId': 'pisut.s@mail.com',
                                },
                              }
                            ]);
                            IO.socketIO.on('r-getProfile').listen((data) {
                              print('On r-getProfile: $data');
                            });
                          },
                          child: Text('getAnotherProfile'),
                        ),
                        TextButton(
                          onPressed: () {
                            IO.socketIO.emit('event', [
                              {
                                'transaction': 'get-plan',
                                'payload': {
                                  'role': roleTranslate(Role.Patient),
                                  'status': [0, 1],
                                }
                              }
                            ]);
                            IO.socketIO.on('r-get-plan').listen((event) {
                              print('On r-get-plan: $event');
                            });
                          },
                          child: Text('getPlan'),
                        ),
                        TextButton(
                          onPressed: () {
                            // IO.socketIO.emit('event', [
                            //   {
                            //     'transaction': 'addHere',
                            //     'payload': {},
                            //   }
                            // ]);
                            // IO.socketIO.on('r-addHere').listen((data) {
                            //   print('On r-addHere: $data');
                            // });
                          },
                          child: Text('Anoter-test -Button'),
                        ),
                        TextButton(
                          onPressed: () {
                            // IO.socketIO.emit('event', [
                            //   {
                            //     'transaction': 'addHere',
                            //     'payload': {},
                            //   }
                            // ]);
                            // IO.socketIO.on('r-addHere').listen((data) {
                            //   print('On r-addHere: $data');
                            // });
                          },
                          child: Text('Anoter-test -Button'),
                        ),
                      ],
                    ),
            ),
            Container(
                height: mdqr.size.height * 0.25,
                child: FittedBox(child: Logo())),
            SizedBox(
              height: 20,
              // height: mdqr.size.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(left: mdqr.size.width * 0.05),
              child: Text(
                (userInfo.role == Role.Patient)
                    ? 'Hi. I can help you find\nwhat’s going on.\nJust start a symptom\nassessment.'
                    : 'Welcome ${userInfo.userData['fname']}',
                // : 'Welcome ${userInfo.userData['fname']}',
                style: TextStyle(
                  color: scndColor,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(child: Container()),
            // SizedBox(
            //   // height: mdqr.size.height * 0.05,
            //   height: 40,
            // ),
            Align(
              alignment: Alignment.centerRight,
              child: AdaptiveRaisedButton(
                buttonText: (userInfo.role == Role.Patient)
                    ? 'Start symptom assessment'
                    : 'See patient',
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.6,
                handlerFn: (() {
                  if (userInfo.role == Role.Patient) {
                    Navigator.of(context).pushNamed(
                      AssessmentPages.routeName,
                    );
                  } else {
                    Navigator.of(context).pushNamed(
                      PatientFollowUpPage.routeName,
                    );
                  }
                }),
              ),
            ),
            SizedBox(
              // height: mdqr.size.height * 0.01,
              height: 5,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: scndColor,
                  size: mdqr.size.width * 0.1,
                ),
                onPressed: () {
                  scaffoldKey.currentState.openEndDrawer();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
