import 'package:flutter/material.dart';

import '../Pages/profilePages.dart';
import '../Pages/appointmentDoctor.dart';
import '../Pages/patientFollowUpPage.dart';
import '../Pages/settingPages.dart';

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
    menuDrawerFlatButton(Icons.chat_bubble_outline, 'Medical consult', (() {
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
    menuDrawerFlatButton(Icons.settings_outlined, 'Setting', (() {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(
        SettingPages.routeName,
      );
    })),
  ];
}
