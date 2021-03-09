import 'package:flutter/material.dart';

import '../Pages/profilePages.dart';
import '../Pages/assessmentHistoryPage.dart';
import '../Pages/appointmentPatient.dart';
// import '../Pages/nearbyHospitalPages.dart';
import '../Pages/settingPages.dart';

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
    menuDrawerFlatButton(Icons.settings_outlined, 'Setting', (() {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(
        SettingPages.routeName,
      );
    })),
  ];
}
