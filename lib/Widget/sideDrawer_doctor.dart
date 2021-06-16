import 'package:flutter/material.dart';
import 'package:homepage_proto/Provider/chatRoom_info.dart';
import 'package:provider/provider.dart';

import '../Provider/user-info.dart';
import '../Pages/profilePages.dart';
import '../Pages/appointmentDoctor.dart';
import '../Pages/patientFollowUpPage.dart';
import '../Pages/chatRoom.dart';
// import '../Pages/settingPages.dart';
import '../Pages/loggingOut.dart';

List<Widget> buildSideDrawerDoctor(
  BuildContext context,
  Function menuDrawerFlatButton,
  var chatRegis,
) {
  return [
    menuDrawerFlatButton(Icons.account_circle_outlined, 'Profile', (() {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(
        ProfilePages.routeName,
      );
    })),
    // if (chatRegis)
      menuDrawerFlatButton(Icons.chat_bubble_outline_rounded, 'Chatroom', (() {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(
          ChatRoom.routeName,
        );
      })),
    // menuDrawerFlatButton(Icons.analytics_outlined, 'Assessment', (() {
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pushNamed(
    //     AssessmentHistoryPage.routeName,
    //   );
    // })),
    menuDrawerFlatButton(Icons.event, 'Appointment', (() {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(
        // ChatRoom.routeName,
        AppointmentDoctorPage.routeName,
      );
    })),
    menuDrawerFlatButton(Icons.analytics_outlined, 'Patient follow up', (() {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(
        // ChatRoom.routeName,
        PatientFollowUpPage.routeName,
      );
    })),
    // menuDrawerFlatButton(Icons.location_on_outlined, 'Nearby hospital',
    //     (() {
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pushNamed(
    //     NearbyHospitalPages.routeName,
    //   );
    // })),
    Consumer<ChatRoomProvider>(
      builder: (context, chatroom, child) {
        return Consumer<UserInfo>(
          builder: (context, userInfo, child) {
            return menuDrawerFlatButton(
              Icons.logout,
              'Log out',
              (() {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    // return Consumer<CartModel>(
                    //   builder: (context, cart, child) {
                    //     return Text("Total price: ${cart.totalPrice}");
                    //   },
                    // );
                    var _isLogingOut = false;
                    return (_isLogingOut)
                        ? CircularProgressIndicator(
                            strokeWidth: 8.0,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          )
                        : AlertDialog(
                            title: Text(
                              'Logout?',
                            ),
                            content: Text(
                              'Confirm to logout?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await userInfo.logout();
                                  await chatroom.closeChat();
                                  Navigator.of(context)
                                      .popUntil(ModalRoute.withName('/'));
                                  Navigator.of(context)
                                      .pushNamed(LoggingOut.routeName);
                                },
                                child: Text('Confirm'),
                              ),
                            ],
                          );
                  },
                );
              }),
            );
          },
        );
      },
    )
  ];
}
