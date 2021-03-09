import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './sideDrawer_patient.dart';
import './sideDrawer_doctor.dart';
import '../Provider/user-info.dart';

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

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    return Drawer(child: LayoutBuilder(builder: (ctx, constraints) {
      Widget menuDrawerFlatButton(
        IconData icon,
        String text,
        Function handler,
      ) {
        return FlatButton(
          onPressed: handler,
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
                    Switch(
                      value: userInfo.online,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool newValue) {
                        userInfo.triggerOnline();
                        if (newValue) {
                          setState(() {
                            drOnlineColor = Theme.of(context).primaryColor;
                            onlineText = 'Online';
                          });
                        } else {
                          setState(() {
                            drOnlineColor = Colors.red;
                            onlineText = 'Offline';
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
              ...buildSideDrawerDoctor(context, menuDrawerFlatButton),
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
                  onPressed: () => Navigator.of(context).pop()),
            )
          ]);
    }));
  }
}
