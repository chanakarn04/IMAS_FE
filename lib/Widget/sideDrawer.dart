import 'package:flutter/material.dart';

import '../Pages/profilePages.dart';
// import '../Pages/assessmentPages.dart';
// import '../Pages/assessmentHistoryPage.dart';
import '../Pages/predictionResultPage.dart';
import '../Pages/chatRoom.dart';
import '../Pages/nearbyHospitalPages.dart';
import '../Pages/settingPages.dart';

//Test zone
import '../Pages/painScoreStartPage.dart';
import '../Pages/vitalSignStartPages.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer();

  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[
            menuDrawerFlatButton(Icons.account_circle_outlined, 'Profile', (() {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(
                ProfilePages.routeName,
              );
            })),
            menuDrawerFlatButton(Icons.analytics_outlined, 'Assessment', (() {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(
                PredictionResultPage.routeName,
              );
            })),
            menuDrawerFlatButton(Icons.chat_bubble_outline, 'Medical consult',
                (() {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(
                ChatRoom.routeName,
              );
            })),
            menuDrawerFlatButton(Icons.location_on_outlined, 'Nearby hospital',
                (() {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(
                NearbyHospitalPages.routeName,
              );
            })),
            menuDrawerFlatButton(Icons.settings_outlined, 'Setting', (() {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(
                SettingPages.routeName,
              );
            })),
            menuDrawerFlatButton(Icons.traffic_outlined, 'Test', (() {
              // Navigator.of(context).pushNamed(
              //   PainScoreStartPage.routeName,
              // );
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(
                VitalSignStartPage.routeName,
              );
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //   VitalSignStartPage.routeName,
              //   ModalRoute.withName('/home'),
              // );
            })),
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
