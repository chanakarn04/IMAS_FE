import 'package:flutter/material.dart';

import '../Pages/profilePages.dart';
import '../Pages/assessmentPages.dart';
import '../Pages/medicalConsultPages.dart';
import '../Pages/nearbyHospitalPages.dart';
import '../Pages/settingPages.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer();

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
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
                size: constraints.maxHeight * 0.06,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: constraints.maxHeight * 0.04,
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePages()),
              );
            })),
            menuDrawerFlatButton(Icons.analytics_outlined, 'Assessment', (() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AssessmentPages()),
              );
            })),
            menuDrawerFlatButton(Icons.chat_bubble_outline, 'Medical consult',
                (() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MedicalConsultPages()),
              );
            })),
            menuDrawerFlatButton(Icons.location_on_outlined, 'Nearby hospital',
                (() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NearbyHospitalPages()),
              );
            })),
            menuDrawerFlatButton(Icons.settings_outlined, 'Setting', (() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingPages()),
              );
            })),
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: constraints.maxHeight * 0.05,
                  ),
                  onPressed: () => Navigator.of(context).pop()),
            )
          ]);
    })

        // Container(
        //   // color: Colors.amber,
        //   padding: EdgeInsets.symmetric(
        //     vertical: 15,
        //     horizontal: 10,
        //   ),
        //   alignment: Alignment(-0.9, 0.9),
        //   child: Container(
        //     color: Colors.redAccent,
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: <Widget>[
        //         Text('item 2'),
        //         Text('item 3'),
        //         Text('item 4'),
        //         Container(
        //           color: Colors.blueAccent,
        //           child: IconButton(
        //               icon: Icon(Icons.close),
        //               onPressed: () => Navigator.of(context).pop()),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
