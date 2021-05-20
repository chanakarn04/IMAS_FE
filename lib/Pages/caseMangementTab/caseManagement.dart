import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';

import '../closeCasePage.dart';
import '../../Models/model.dart';
import '../../Widget/showMyDialog.dart';
import '../../Widget/caseManagementCreateAppointment.dart';
import '../../Provider/caseManagement_Info.dart';
import '../../Provider/chatRoom_info.dart';
import '../../Provider/user-info.dart';

class CaseManagementTab extends StatefulWidget {
  @override
  _CaseManagementTabState createState() => _CaseManagementTabState();
}

class _CaseManagementTabState extends State<CaseManagementTab> {
  // DateTime selectedDate = DateTime.now().add(Duration(days: 2));
  // TimeOfDay selectedTime = TimeOfDay.now();
  // DateTime selectedApDt;

  List<Map<String, dynamic>> _loadEvent(
      // String userId,
      ) {
    // load data from server
    // get apDt of last ap and dr Name

    List<Map<String, dynamic>> data = [
      // {
      //   'apId': 'ap001',
      //   'tpId': 'tp001',
      //   'image': 'assets/images/default_photo.png',
      //   'pName': 'Samitanan Techabunyawatthanakul',
      //   'apDt': DateTime(2021, 2, 25, 14, 30),
      // },
      // {
      //   'apId': 'ap002',
      //   'tpId': 'tp002',
      //   'image': 'assets/images/default_photo.png',
      //   'pName': 'Never More',
      //   'apDt': DateTime(2021, 2, 24, 20, 30),
      // },
      // {
      //   'apId': 'ap003',
      //   'tpId': 'tp003',
      //   'image': 'assets/images/default_photo.png',
      //   'pName': 'Mega Tron',
      //   'apDt': DateTime(2021, 2, 24, 10, 30),
      // },
      // {
      //   'apId': 'ap004',
      //   'tpId': 'tp004',
      //   'image': 'assets/images/default_photo.png',
      //   'pName': 'Hot Rod',
      //   'apDt': DateTime(2021, 2, 24, 9, 20),
      // },
      // {
      //   'apId': 'ap005',
      //   'tpId': 'tp005',
      //   'image': 'assets/images/default_photo.png',
      //   'pName': 'Manta Style',
      //   'apDt': DateTime(2021, 2, 24, 18, 15),
      // },
      {
        'apId': 'ap006',
        'tpId': 'tp006',
        'image': 'assets/images/default_photo.png',
        'pName': 'Battle Fury',
        'apDt': DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          DateTime.now().hour,
          15,
        ),
      },
      {
        'apId': 'ap007',
        'tpId': 'tp007',
        'image': 'assets/images/default_photo.png',
        'pName': 'Nyx Azzin',
        'apDt': DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day + 2,
          DateTime.now().hour,
          15,
        ),
      },
      {
        'apId': 'ap007',
        'tpId': 'tp007',
        'image': 'assets/images/default_photo.png',
        'pName': 'Nyx Azzin',
        'apDt': DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day + 2,
          DateTime.now().hour + 2,
          30,
        ),
      },
      {
        'apId': 'ap007',
        'tpId': 'tp007',
        'image': 'assets/images/default_photo.png',
        'pName': 'Nyx Azzin',
        'apDt': DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day + 2,
          DateTime.now().hour-8,
          50,
        ),
      },
      // {
      //   'apId': 'ap007',
      //   'tpId': 'tp007',
      //   'image': 'assets/images/default_photo.png',
      //   'pName': 'Nyx Azzin',
      //   'apDt': DateTime(
      //     DateTime.now().year,
      //     DateTime.now().month,
      //     DateTime.now().day + 2,
      //     DateTime.now().hour + 4,
      //     0,
      //   ),
      // },
      // {
      //   'apId': 'ap008',
      //   'tpId': 'tp008',
      //   'image': 'assets/images/default_photo.png',
      //   'pName': 'Mona Lisa',
      //   'apDt': DateTime(2021, 2, 26, 13, 0),
      // },
    ];
    return data;
  }

  Widget _buildBox({
    BuildContext context,
    Color color,
    String title,
    String description,
    String buttonTitle,
    Function buttonFn,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: color,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            topLeft: Radius.circular(15),
          )),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              subtitle: Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 40,
              width: 180,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: color,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  child: Text(
                    buttonTitle,
                    style: TextStyle(color: color),
                  ),
                  onPressed: buttonFn,
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cmInfo = Provider.of<CMinfoProvider>(context, listen: false);
    final chatroom = Provider.of<ChatRoomProvider>(context);
    final userInfo = Provider.of<UserInfo>(context);
    return Container(
      padding: EdgeInsets.only(
        top: 15,
        // left: 20,
        // bottom: 20,
      ),
      child: Column(
        children: [
          Expanded(
            child: _buildBox(
                context: context,
                color: Color.fromARGB(255, 255, 0, 0),
                title: 'Critical',
                description: '    Patient need to go to hospital right now!',
                buttonTitle: 'Close case',
                buttonFn: () {
                  showMyDialog(
                    context,
                    'Critical?',
                    'Confirm to close case as critical?',
                    'cancel',
                    'confirm',
                    () async {
                      print('close case as critical');
                      Navigator.of(context).popAndPushNamed(
                        CloseCasePage.routneName,
                        arguments: {
                          'name': cmInfo.pName,
                          'closeCase': true,
                        },
                      );
                      // close chatroom 
                      await cmInfo.upload(chatroom.apid, chatroom.note, 0);
                      await userInfo.updatePlan(chatroom.tpid, 3);
                      cmInfo.cleanDispose();
                      await chatroom.deleteChatroom();
                      // cmInfo.dispose();
                    },
                  );
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: _buildBox(
                context: context,
                color: Color.fromARGB(255, 81, 195, 169),
                title: 'Cured',
                description: '    Patient has cured or has no symptom anymore.',
                buttonTitle: 'Close case',
                buttonFn: () {
                  showMyDialog(
                    context,
                    'Cured?',
                    'Confirm to close case as cured?',
                    'cancel',
                    'confirm',
                    () async {
                      Navigator.of(context).popAndPushNamed(
                        CloseCasePage.routneName,
                        arguments: {
                          'name': cmInfo.pName,
                          'closeCase': true,
                        },
                      );
                      print('close case as Cured');
                      await cmInfo.upload(chatroom.apid, chatroom.note, 0);
                      await userInfo.updatePlan(chatroom.tpid, 2);
                      cmInfo.cleanDispose();
                      await chatroom.deleteChatroom();
                      // cmInfo.dispose();
                    },
                  );
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: _buildBox(
              context: context,
              color: Color.fromARGB(255, 77, 159, 206),
              title: 'On track',
              description:
                  '    Close this consult and make appointment of next consult.',
              buttonTitle: 'Create appointment',
              buttonFn: () {
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  builder: (context) {
                    return CaseManagementCreateAppointment(
                      // _loadEvent(),
                      []
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 2,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
