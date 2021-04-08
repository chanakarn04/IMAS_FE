import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/user-info.dart';
import '../Pages/profilePages.dart';
import '../Pages/appointmentDoctor.dart';
import '../Pages/patientFollowUpPage.dart';
// import '../Pages/settingPages.dart';
import '../Pages/loginPage.dart';

List<Widget> buildSideDrawerDoctor(
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
    menuDrawerFlatButton(Icons.logout, 'Log out', (() {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          // return Consumer<CartModel>(
          //   builder: (context, cart, child) {
          //     return Text("Total price: ${cart.totalPrice}");
          //   },
          // );
          return AlertDialog(
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
              Consumer<UserInfo>(
                builder: (context, userInfo, child) {
                  return TextButton(
                    onPressed: () {
                      userInfo.logout();
                      Navigator.of(context).popUntil(ModalRoute.withName('/'));
                      Navigator.of(context).pushNamed(LogInPage.routeName);
                    },
                    child: Text('Confirm'),
                  );
                },
              ),
            ],
          );
        },
      );
    })),
  ];
}
