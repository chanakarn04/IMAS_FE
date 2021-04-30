import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/user-info.dart';
import '../Pages/profilePages.dart';
import '../Pages/assessmentHistoryPage.dart';
import '../Pages/appointmentPatient.dart';
// import '../Pages/nearbyHospitalPages.dart';
// import '../Pages/settingPages.dart';
import 'package:homepage_proto/Pages/loggingOut.dart';
import '../Pages/loginPage.dart';
import '../Pages/vitalSignStartPages.dart';

List<Widget> buildSideDrawerPatient(
  BuildContext context,
  Function menuDrawerFlatButton,
) {
  return [
    menuDrawerFlatButton(Icons.account_circle_outlined, 'Profile', (() {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(
        ProfilePages.routeName,
      );
    })),
    menuDrawerFlatButton(Icons.analytics_outlined, 'Assessment History', (() {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(
        AssessmentHistoryPage.routeName,
      );
    })),
    menuDrawerFlatButton(Icons.chat_bubble_outline, 'Medical consult', (() {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(
        // ChatRoom.routeName,
        AppointmentPatientPage.routeName,
      );
    })),
    // menuDrawerFlatButton(Icons.location_on_outlined, 'Nearby hospital',
    //     (() {
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pushNamed(
    //     NearbyHospitalPages.routeName,
    //   );
    // })),
    Consumer<UserInfo>(
      builder: (context, userInfo, child) {
        return menuDrawerFlatButton(Icons.logout, 'Log out', (() {
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
                          onPressed: () {
                            userInfo.logout();
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
        }));
      },
    ),

    menuDrawerFlatButton(Icons.casino, 'vs', (() {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(
        VitalSignStartPage.routeName,
      );
    })),
  ];
}
