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
  var _loadedData = false;
  // not select = 0
  // Critical = 1
  // Cured = 2
  // On track = 3
  int selectIndex;

  @override
  void didChangeDependencies() {
    if (!_loadedData) {
      selectIndex = 0;
    }
    super.didChangeDependencies();
  }

  Widget _buildBox({
    String title,
    String description,
    int selfIndex,
    int selectingIndex,
  }) {
    return InkWell(
      onTap: () {
        if (selectIndex == selfIndex) {
          setState(() {
            selectIndex = 0;
          });
        } else {
          setState(() {
            selectIndex = selfIndex;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: (selectingIndex == selfIndex)
              ? Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                )
              : Border.all(
                  color: Colors.grey[400],
                  width: 2,
                ),
        ),
        // height: 50,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    // softWrap: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 30,
              width: 30,
              decoration: (selectingIndex == selfIndex)
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    )
                  : BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
            ),
          ],
        ),
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
          top: MediaQuery.of(context).padding.top + 15,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: InkWell(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'Conclude',
                style: TextStyle(
                  fontSize: 32,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'Select one of the options below to end the consultation',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: _buildBox(
                title: 'Critical',
                description:
                    'Patient get more serious illness, should to be treated ugmently',
                selectingIndex: selectIndex,
                selfIndex: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: _buildBox(
                title: 'Recovered',
                description:
                    'Patient has no longer illness or can be cured by him/herself',
                selectingIndex: selectIndex,
                selfIndex: 2,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: _buildBox(
                title: 'Continue follow up',
                description: 'Create an appointment to follow up symtoms',
                selectingIndex: selectIndex,
                selfIndex: 3,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 8),
              alignment: Alignment.centerRight,
              child: (selectIndex != 0)
                  ? InkWell(
                      onTap: () async {
                        if (selectIndex == 1) {
                          print('close case as critical');
                          Navigator.of(context).popAndPushNamed(
                            CloseCasePage.routneName,
                            arguments: {
                              'name': cmInfo.pName,
                              'closeCase': true,
                            },
                          );
                          // close chatroom
                          await chatroom.deleteChatroom();
                          await cmInfo.upload(chatroom.apid, chatroom.note, 0);
                          await userInfo.updatePlan(chatroom.tpid, 2);
                          chatroom.closeChat();
                          cmInfo.cleanDispose();
                          // cmInfo.dispose();
                        } else if (selectIndex == 2) {
                          Navigator.of(context).popAndPushNamed(
                            CloseCasePage.routneName,
                            arguments: {
                              'name': cmInfo.pName,
                              'closeCase': true,
                            },
                          );
                          print('close case as Cured');
                          await chatroom.deleteChatroom();
                          await cmInfo.upload(chatroom.apid, chatroom.note, 0);
                          await userInfo.updatePlan(chatroom.tpid, 1);
                          chatroom.closeChat();
                          cmInfo.cleanDispose();
                          // cmInfo.dispose()
                        } else {
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
                              return CaseManagementCreateAppointment([]);
                            },
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
            )
          ],
        ));
  }
}
// class _CaseManagementTabState extends State<CaseManagementTab> {
//   // DateTime selectedDate = DateTime.now().add(Duration(days: 2));
//   // TimeOfDay selectedTime = TimeOfDay.now();
//   // DateTime selectedApDt;

//   List<Map<String, dynamic>> _loadEvent(
//       // String userId,
//       ) {
//     // load data from server
//     // get apDt of last ap and dr Name

//     List<Map<String, dynamic>> data = [
//       // {
//       //   'apId': 'ap001',
//       //   'tpId': 'tp001',
//       //   'image': 'assets/images/default_photo.png',
//       //   'pName': 'Samitanan Techabunyawatthanakul',
//       //   'apDt': DateTime(2021, 2, 25, 14, 30),
//       // },
//       // {
//       //   'apId': 'ap002',
//       //   'tpId': 'tp002',
//       //   'image': 'assets/images/default_photo.png',
//       //   'pName': 'Never More',
//       //   'apDt': DateTime(2021, 2, 24, 20, 30),
//       // },
//       // {
//       //   'apId': 'ap003',
//       //   'tpId': 'tp003',
//       //   'image': 'assets/images/default_photo.png',
//       //   'pName': 'Mega Tron',
//       //   'apDt': DateTime(2021, 2, 24, 10, 30),
//       // },
//       // {
//       //   'apId': 'ap004',
//       //   'tpId': 'tp004',
//       //   'image': 'assets/images/default_photo.png',
//       //   'pName': 'Hot Rod',
//       //   'apDt': DateTime(2021, 2, 24, 9, 20),
//       // },
//       // {
//       //   'apId': 'ap005',
//       //   'tpId': 'tp005',
//       //   'image': 'assets/images/default_photo.png',
//       //   'pName': 'Manta Style',
//       //   'apDt': DateTime(2021, 2, 24, 18, 15),
//       // },
//       {
//         'apId': 'ap006',
//         'tpId': 'tp006',
//         'image': 'assets/images/default_photo.png',
//         'pName': 'Battle Fury',
//         'apDt': DateTime(
//           DateTime.now().year,
//           DateTime.now().month,
//           DateTime.now().day,
//           DateTime.now().hour,
//           15,
//         ),
//       },
//       {
//         'apId': 'ap007',
//         'tpId': 'tp007',
//         'image': 'assets/images/default_photo.png',
//         'pName': 'Nyx Azzin',
//         'apDt': DateTime(
//           DateTime.now().year,
//           DateTime.now().month,
//           DateTime.now().day + 2,
//           DateTime.now().hour,
//           15,
//         ),
//       },
//       {
//         'apId': 'ap007',
//         'tpId': 'tp007',
//         'image': 'assets/images/default_photo.png',
//         'pName': 'Nyx Azzin',
//         'apDt': DateTime(
//           DateTime.now().year,
//           DateTime.now().month,
//           DateTime.now().day + 2,
//           DateTime.now().hour + 2,
//           30,
//         ),
//       },
//       {
//         'apId': 'ap007',
//         'tpId': 'tp007',
//         'image': 'assets/images/default_photo.png',
//         'pName': 'Nyx Azzin',
//         'apDt': DateTime(
//           DateTime.now().year,
//           DateTime.now().month,
//           DateTime.now().day + 2,
//           DateTime.now().hour-8,
//           50,
//         ),
//       },
//       // {
//       //   'apId': 'ap007',
//       //   'tpId': 'tp007',
//       //   'image': 'assets/images/default_photo.png',
//       //   'pName': 'Nyx Azzin',
//       //   'apDt': DateTime(
//       //     DateTime.now().year,
//       //     DateTime.now().month,
//       //     DateTime.now().day + 2,
//       //     DateTime.now().hour + 4,
//       //     0,
//       //   ),
//       // },
//       // {
//       //   'apId': 'ap008',
//       //   'tpId': 'tp008',
//       //   'image': 'assets/images/default_photo.png',
//       //   'pName': 'Mona Lisa',
//       //   'apDt': DateTime(2021, 2, 26, 13, 0),
//       // },
//     ];
//     return data;
//   }

//   Widget _buildBox({
//     BuildContext context,
//     Color color,
//     String title,
//     String description,
//     String buttonTitle,
//     Function buttonFn,
//   }) {
//     return Container(
//       margin: EdgeInsets.only(left: 20),
//       width: double.infinity,
//       decoration: BoxDecoration(
//           border: Border.all(
//             width: 3,
//             color: color,
//           ),
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(15),
//             topLeft: Radius.circular(15),
//           )),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(5),
//             child: ListTile(
//               title: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 28,
//                 ),
//               ),
//               subtitle: Text(
//                 description,
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(child: Container()),
//           Container(
//             padding: EdgeInsets.all(10),
//             alignment: Alignment.centerRight,
//             child: SizedBox(
//               height: 40,
//               width: 180,
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 2,
//                     color: color,
//                   ),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: TextButton(
//                   child: Text(
//                     buttonTitle,
//                     style: TextStyle(color: color),
//                   ),
//                   onPressed: buttonFn,
//                 ),
//               ),
//             ),
//           ),
//           // SizedBox(
//           //   height: 10,
//           // ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cmInfo = Provider.of<CMinfoProvider>(context, listen: false);
//     final chatroom = Provider.of<ChatRoomProvider>(context);
//     final userInfo = Provider.of<UserInfo>(context);
//     return Container(
//       padding: EdgeInsets.only(
//         top: 15,
//         // left: 20,
//         // bottom: 20,
//       ),
//       child: Column(
//         children: [
//           Expanded(
//             child: _buildBox(
//                 context: context,
//                 color: Color.fromARGB(255, 255, 0, 0),
//                 title: 'Critical',
//                 description: '    Patient need to go to hospital right now!',
//                 buttonTitle: 'Close case',
//                 buttonFn: () {
//                   showMyDialog(
//                     context,
//                     'Critical?',
//                     'Confirm to close case as critical?',
//                     'cancel',
//                     'confirm',
// () async {
//   print('close case as critical');
//   Navigator.of(context).popAndPushNamed(
//     CloseCasePage.routneName,
//     arguments: {
//       'name': cmInfo.pName,
//       'closeCase': true,
//     },
//   );
//   // close chatroom
//   await chatroom.deleteChatroom();
//   await cmInfo.upload(chatroom.apid, chatroom.note, 0);
//   await userInfo.updatePlan(chatroom.tpid, 2);
//   chatroom.closeChat();
//   cmInfo.cleanDispose();
//   // cmInfo.dispose();
// },
//                   );
//                 }),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Expanded(
//             child: _buildBox(
//                 context: context,
//                 color: Color.fromARGB(255, 81, 195, 169),
//                 title: 'Cured',
//                 description: '    Patient has cured or has no symptom anymore.',
//                 buttonTitle: 'Close case',
//                 buttonFn: () {
//                   showMyDialog(
//                     context,
//                     'Cured?',
//                     'Confirm to close case as cured?',
//                     'cancel',
//                     'confirm',
                    // () async {
                    //   Navigator.of(context).popAndPushNamed(
                    //     CloseCasePage.routneName,
                    //     arguments: {
                    //       'name': cmInfo.pName,
                    //       'closeCase': true,
                    //     },
                    //   );
                    //   print('close case as Cured');
                    //   await chatroom.deleteChatroom();
                    //   await cmInfo.upload(chatroom.apid, chatroom.note, 0);
                    //   await userInfo.updatePlan(chatroom.tpid, 1);
                    //   chatroom.closeChat();
                    //   cmInfo.cleanDispose();
                    //   // cmInfo.dispose();
                    // },
//                   );
//                 }),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Expanded(
//             child: _buildBox(
//               context: context,
//               color: Color.fromARGB(255, 77, 159, 206),
//               title: 'On track',
//               description:
//                   '    Close this consult and make appointment of next consult.',
//               buttonTitle: 'Create appointment',
              // buttonFn: () {
              //   showModalBottomSheet(
              //     context: context,
              //     isDismissible: false,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(20),
              //         topRight: Radius.circular(20),
              //       ),
              //     ),
              //     builder: (context) {
              //       return CaseManagementCreateAppointment(
              //         // _loadEvent(),
              //         []
              //       );
              //     },
              //   );
              // },
            // ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             width: double.infinity,
//             height: 2,
//             color: Theme.of(context).primaryColor,
//           )
//         ],
//       ),
//     );
//   }
// }
