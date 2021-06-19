import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/user-info.dart';
import '../Provider/chatRoom_info.dart';
import '../Pages/profilePages.dart';
import '../Pages/assessmentHistoryPage.dart';
import '../Pages/appointmentPatient.dart';
import '../Pages/loggingOut.dart';
import '../Pages/chatRoom.dart';
import '../Pages/WaitingDoctor.dart';
import '../Pages/predictionResultPage.dart';

List<Widget> buildSideDrawerPatient(
  BuildContext context,
  Function menuDrawerFlatButton,
) {
  return [
    menuDrawerFlatButton(Icons.account_circle_outlined, 'Rsult', (() {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(PredictionResultPage.routeName);
    })),
    menuDrawerFlatButton(Icons.account_circle_outlined, 'Profile', (() {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(ProfilePages.routeName);
    })),
    menuDrawerFlatButton(Icons.analytics_outlined, 'Assessment History', (() {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(AssessmentHistoryPage.routeName);
    })),
    Consumer<ChatRoomProvider>(builder: (context, chatRoomProvider, child) {
      return menuDrawerFlatButton(Icons.chat_bubble_outline, 'Medical consult', (() {
        Navigator.of(context).pop();
        if (chatRoomProvider.chatRoomRegis) {
          Navigator.of(context).pushNamed(ChatRoom.routeName);
        } else if (chatRoomProvider.chatSearching) {
          Navigator.of(context).pushNamed(WaitingPage.routeName);
        } else {
          Navigator.of(context).pushNamed(AppointmentPatientPage.routeName);
        }
      }));
    }),
    Consumer<UserInfo>(
      builder: (context, userInfo, child) {
        return menuDrawerFlatButton(Icons.logout, 'Log out', () =>
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              var _isLogingOut = false;
              return (_isLogingOut)
                  ? CircularProgressIndicator(
                      strokeWidth: 8.0,
                      valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    )
                  : AlertDialog(
                      title: Text('Logout?'),
                      content: Text('Confirm to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await userInfo.logout();
                            Navigator.of(context).popUntil(ModalRoute.withName('/'));
                            Navigator.of(context).pushNamed(LoggingOut.routeName);
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    );
            },
          ),
        );
      },
    ),
  ];
}
