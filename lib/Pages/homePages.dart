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
import './caseMangementPage.dart';

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
              // child: TextButton(
              //     onPressed: () {
              //       Navigator.of(context)
              //           .pushNamed(CaseManagementPage.routeName);
              //     },
              //     child: Container(
              //       height: 50,
              //       width: 50,
              //       color: Colors.teal,
              //     )),
            ),
            // child: InkWell(
            //   onTap: () {
                
            //   },
            //   child: Container(
            //     alignment: Alignment.center,
            //     height: 50,
            //     width: 100,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(45),
            //       color: Colors.deepPurple[400],
            //     ),
            //     child: Text('Add Condition', style: TextStyle(color: Colors.white),),
            //   ),
            // ),
            //
            // =====> BREAK <=====
            //
            // Container(
            //   height: 10,
            //   width: 10,
            //   color: Colors.pink,
            //   child: TextButton(
            //     onPressed: () async {
            //       String tpid;
            //       String apid;
            //       await IO.socketIO.emit('event', [
            //         {
            //           'transaction': 'save-from-api',
            //           'payload': {
            //             'pid': userInfo.userId,
            //             'status': 3,
            //             'apDt': DateTime.now().toString(),
            //             'symptoms': ['Back Pain'],
            //             'conditions': {
            //               'c_test1': 'Conditioner 1',
            //               'c_test2': 'Condtioner 2'
            //             },
            //           },
            //         }
            //       ]);
            //       await for (dynamic data
            //           in IO.socketIO.on('r-save-from-api')) {
            //         print('On r-save-from-api: ${data[0]['value']['payload']}');
            //         if (data != null) {
            //           tpid = data[0]['value']['payload']['tpid'];
            //           apid = data[0]['value']['payload']['apid'];
            //           break;
            //         }
            //       }
            //       await IO.socketIO.emit('event', [
            //         {
            //           'transaction': 'updatePlan',
            //           'payload': {
            //             'tpid': tpid,
            //             'status': 0,
            //             'drid': 'doctor01@mail.com'
            //           },
            //         }
            //       ]);
            //       chatProvider.patientReqChat(
            //         userInfo.userData['userName'],
            //         userInfo.role,
            //         tpid,
            //         apid,
            //       );
            //     },
            //     child: Text(
            //       'chat',
            //       style: TextStyle(
            //         color: Colors.teal,
            //         // fontSize: 24,
            //       ),
            //     ),
            //   ),
            // ),
            //       // ==== >> Test Appointment
                  // IO.socketIO.emit('event', [
                  //     {
                  //       'transaction': 'create-new-appointment',
                  //       'payload': {
                  //         // 'tpid': '608e6cc18f0f9c001e97ff97',
                  //         'tpid': tpid,
                  //         'apdt': DateTime(
                  //           DateTime.now().year,
                  //           DateTime.now().month,
                  //           DateTime.now().day,
                  //           DateTime.now().hour,
                  //           DateTime.now().minute + 3,
                  //         ).toString(),
                  //       },
                  //     }
                  //   ]);
                  //   await for (dynamic data in IO.socketIO.on('r-create-appointment')) {
                  //     print('On r-create-appointment: ${data[0]['value']['payload']}');
                  //     break;
                  //   }
            //       //  ==== >> Vital Sign Test
            //       // await IO.socketIO.emit('event', [
            //       //   {
            //       //     'transaction': 'save-vital-pain',
            //       //     'payload': {
            //       //       // 'vsid': ,
            //       //       'tpid': tpid,
            //       //       'apid': apid,
            //       //       'pain_score': {'Back pain': 10},
            //       //       'vsdt': DateTime(
            //       //         DateTime.now().year,
            //       //         DateTime.now().month,
            //       //         DateTime.now().day,
            //       //         DateTime.now().hour,
            //       //         DateTime.now().minute,
            //       //       ).toString(),
            //       //       'body_temp': 42.5,
            //       //       'pulse': 254,
            //       //       'blood_pressure_top': 200,
            //       //       'blood_pressure_bottom': 10,
            //       //       'respiratory_rate': 164,
            //       //     },
            //       //   }
            //       // ]);
            //       // await for (dynamic data
            //       //     in IO.socketIO.on('r-save-vital-pain')) {
            //       //   print('On r-save-vital-pain: $data');
            //       //   if (data != null) {
            //       //     break;
            //       //   }
            //       // }
            //       // ==== >> Chat test
              //     chatProvider.patientReqChat(
              //       userInfo.userData['userName'],
              //       userInfo.role,
              //       tpid,
              //       apid,
              //     );
              //   },
              //   child: Text(
              //     'chat',
              //     style: TextStyle(
              //       color: Colors.teal,
              //       // fontSize: 24,
              //     ),
              //   ),
              // ),
            //   //
            //   // ====> BREAK <===
            // ),
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
