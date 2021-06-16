import 'package:flutter/material.dart';
import 'package:homepage_proto/Provider/chatRoom_info.dart';
import 'package:provider/provider.dart';

import './sideDrawer_patient.dart';
import './sideDrawer_doctor.dart';
import '../Provider/user-info.dart';
import '../Script/socketioScript.dart' as IO;

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  // role of user
  //  0 = patient
  //  1 = doctor
  // final int role = 0;
  Color drOnlineColor = Colors.red;
  // bool onlineState = false;
  String onlineText = 'Offline';

  ChatRoomProvider chatRoomProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    chatRoomProvider = Provider.of<ChatRoomProvider>(context);
    if (chatRoomProvider.online) {
      drOnlineColor = Theme.of(context).primaryColor;
      onlineText = 'Online';
    } else {
      drOnlineColor = Colors.red;
      onlineText = 'Offline';
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final chatroom = Provider.of<ChatRoomProvider>(context);
    final userInfo = Provider.of<UserInfo>(context);
    return Drawer(child: LayoutBuilder(builder: (ctx, constraints) {
      Widget menuDrawerFlatButton(
        IconData icon,
        String text,
        Function handler,
      ) {
        return TextButton(
          onPressed: handler,
          style: TextButton.styleFrom(
            primary: Colors.grey[900],
          ),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: constraints.maxHeight * 0.04,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: constraints.maxHeight * 0.03,
                child: FittedBox(
                  child: Text(text),
                ),
              ),
            ],
          ),
        );
      }

      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (userInfo.role == Role.Patient)
              ...buildSideDrawerPatient(context, menuDrawerFlatButton),
            if (userInfo.role == Role.Doctor) ...[
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: drOnlineColor,
                        shape: BoxShape.circle,
                      ),
                      height: constraints.maxHeight * 0.04,
                      width: constraints.maxHeight * 0.04,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.03,
                      child: FittedBox(
                        child: Text(
                          onlineText,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Consumer<ChatRoomProvider>(
                        builder: (context, chatRoomProvider, child) {
                      return Switch(
                        value: chatRoomProvider.online,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (bool newValue) async {
                          if (chatRoomProvider.online) {
                            // online = true ==> online = false
                            await chatRoomProvider.triggerDoctorOnline();
                            chatRoomProvider.onReqChatRoom(
                                start: false, userid: userInfo.userId);
                            setState(() {
                              drOnlineColor = Colors.red;
                              onlineText = 'Offline';
                            });
                          } else {
                            // online = true ==> online = false
                            await chatRoomProvider.triggerDoctorOnline();
                            chatRoomProvider.onReqChatRoom(
                                start: true, userid: userInfo.userId);
                            setState(() {
                              drOnlineColor = Theme.of(context).primaryColor;
                              onlineText = 'Online';
                            });
                          }
                          // Navigator.of(context).pop();
                        },
                      );
                    }),
                  ],
                ),
              ),
              ...buildSideDrawerDoctor(
                context,
                menuDrawerFlatButton,
                chatRoomProvider.chatRoomRegis,
              ),
            ],

            // <Widget>[
            //   menuDrawerFlatButton(Icons.account_circle_outlined, 'Profile', (() {
            //     Navigator.of(context).pop();
            //     Navigator.of(context).pushNamed(
            //       ProfilePages.routeName,
            //     );
            //   })),
            //   menuDrawerFlatButton(Icons.analytics_outlined, 'Assessment', (() {
            //     Navigator.of(context).pop();
            //     Navigator.of(context).pushNamed(
            //       AssessmentHistoryPage.routeName,
            //     );
            //   })),
            //   menuDrawerFlatButton(Icons.chat_bubble_outline, 'Medical consult',
            //       (() {
            //     Navigator.of(context).pop();
            //     Navigator.of(context).pushNamed(
            //       // ChatRoom.routeName,
            //       AppointmentPatientPage.routeName,
            //     );
            //   })),
            //   menuDrawerFlatButton(Icons.location_on_outlined, 'Nearby hospital',
            //       (() {
            //     Navigator.of(context).pop();
            //     Navigator.of(context).pushNamed(
            //       NearbyHospitalPages.routeName,
            //     );
            //   })),
            //   menuDrawerFlatButton(Icons.settings_outlined, 'Setting', (() {
            //     Navigator.of(context).pop();
            //     Navigator.of(context).pushNamed(
            //       SettingPages.routeName,
            //     );
            //   })),

            // menuDrawerFlatButton(Icons.traffic_outlined, 'PatientInfo', (() {
            //   // **********************
            //   Navigator.of(context).pop();
            //   Navigator.of(context).pushNamed(
            //     PatientInfoPage.routeName,
            //   );
            //   // **********************
            // })),
            // menuDrawerFlatButton(Icons.traffic_outlined, 'login', (() {
            //   // **********************
            //   Navigator.of(context).pop();
            //   Navigator.of(context).pushNamed(
            //     LogInPage.routeName,
            //   );
            // })),
            // menuDrawerFlatButton(Icons.traffic_outlined, 'Patient-FollowUp',
            //     (() {
            //   // **********************
            //   Navigator.of(context).pop();
            //   Navigator.of(context).pushNamed(
            //     PatientFollowUpPage.routeName,
            //   );
            // })),
            // // menuDrawerFlatButton(Icons.traffic_outlined, 'VS/PS', (() {
            // //   // **********************
            // //   Navigator.of(context).pop();
            // //   Navigator.of(context).pushNamed(
            // //     VitalSignStartPage.routeName,
            // //   );
            // //   // **********************
            // // })),
            // // menuDrawerFlatButton(Icons.traffic_outlined, 'PredRes', (() {
            // //   // **********************
            // //   Navigator.of(context).pop();
            // //   Navigator.of(context).pushNamed(
            // //     PredictionResultPage.routeName,
            // //   );
            // //   // **********************
            // // })),
            // menuDrawerFlatButton(Icons.traffic_outlined, 'CaseMgn', (() {
            //   // **********************
            //   Navigator.of(context).pop();
            //   Navigator.of(context).pushNamed(
            //     CaseManagementPage.routeName,
            //   );
            //   // **********************
            // })),
            // menuDrawerFlatButton(Icons.traffic_outlined, 'aptDr', (() {
            //   // **********************
            //   Navigator.of(context).pop();
            //   Navigator.of(context).pushNamed(
            //     AppointmentDoctorPage.routeName,
            //   );
            //   // **********************
            // })),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  size: constraints.maxHeight * 0.05,
                  color: Colors.grey,
                ),
                onPressed: () => Navigator.of(context).pop(),
              
                // onPressed: () async {
                //   String tpid;
                //   String apid;
                //   await IO.socketIO.emit('event', [
                //     {
                //       'transaction': 'save-from-api',
                //       'payload': {
                //         'pid': 'patApt1@mail.com',
                //         // 'pid': 'chanakarn.s@mail.com',
                //         'status': 3,
                //         'apDt': DateTime.now().toString(),
                //         'symptoms': ['Back Pain'],
                //         'conditions': {
                //           'c_test1': 'Conditioner 1',
                //           'c_test2': 'Conditioner 2'
                //         },
                //       },
                //     }
                //   ]);
                //   await for (dynamic data
                //       in IO.socketIO.on('r-save-from-api')) {
                //     print('On r-save-from-api: ${data[0]['value']['payload']}');
                //     if (data != null) {
                //       tpid = data[0]['value']['payload']['tpid'];
                //       apid = data[0]['value']['payload']['apid'];
                //       break;
                //     }
                //   }
                //   await IO.socketIO.emit('event', [
                //     {
                //       'transaction': 'updatePlan',
                //       'payload': {
                //         'tpid': tpid,
                //         'status': 0,
                //         // 'drid': 'phawinphat.ben@gmail.com'
                //         'drid': 'docApt1@mail.com'
                //       },
                //     }
                //   ]);
                //   chatroom.patientReqChat(
                //     userInfo.userData['userName'],
                //     userInfo.role,
                //     tpid,
                //     apid,
                //   );
                //   // appointment
                //   IO.socketIO.emit('event', [
                //       {
                //         'transaction': 'create-new-appointment',
                //         'payload': {
                //           // 'tpid': '608e6cc18f0f9c001e97ff97',
                //           'tpid': tpid,
                //           'apdt': DateTime(
                //             DateTime.now().year,
                //             DateTime.now().month,
                //             DateTime.now().day,
                //             DateTime.now().hour,
                //             DateTime.now().minute + 3,
                //           ).toString(),
                //         },
                //       }
                //     ]);
                //     await for (dynamic data in IO.socketIO.on('r-create-appointment')) {
                //       print('On r-create-appointment: ${data[0]['value']['payload']}');
                //       break;
                //     }
                    // viatal
                  // await IO.socketIO.emit('event', [
                  //   {
                  //     'transaction': 'save-vital-pain',
                  //     'payload': {
                  //       // 'vsid': ,
                  //       'tpid': tpid,
                  //       'apid': apid,
                  //       'pain_score': {'Back pain': 10},
                  //       'vsdt': DateTime(
                  //         DateTime.now().year,
                  //         DateTime.now().month,
                  //         DateTime.now().day,
                  //         DateTime.now().hour,
                  //         DateTime.now().minute,
                  //       ).toString(),
                  //       'body_temp': 42.5,
                  //       'pulse': 254,
                  //       'blood_pressure_top': 200,
                  //       'blood_pressure_bottom': 10,
                  //       'respiratory_rate': 164,
                  //     },
                  //   }
                  // ]);
                  // await for (dynamic data
                  //     in IO.socketIO.on('r-save-vital-pain')) {
                  //   print('On r-save-vital-pain: $data');
                  //   if (data != null) {
                  //     break;
                  //   }
                  // }
                // },
              ),
            )
          ]);
    }));
  }
}
