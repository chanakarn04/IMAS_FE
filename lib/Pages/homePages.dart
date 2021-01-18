import 'package:flutter/material.dart';

import 'assessmentPages.dart';
import '../Widget/adaptiveRaisedButton.dart';
import '../Widget/Logo.dart';
import '../Widget/sideDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mdqr = MediaQuery.of(context);
    final scndColor = Color.fromARGB(255, 75, 75, 75);
    return Scaffold(
      key: _scaffoldState,
      endDrawer: SideDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mdqr.size.width * 0.05,
          vertical: mdqr.size.width * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Drawer(),
            Container(
                height: mdqr.size.height * 0.2,
                child: FittedBox(child: Logo())),
            SizedBox(
              height: mdqr.size.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(left: mdqr.size.width * 0.05),
              child: Container(
                height: mdqr.size.height * 0.12,
                child: FittedBox(
                    child: Text(
                  'Hi. I can help you find\nwhat’s going on.\nJust start a symptom\nassessment.',
                  style: TextStyle(
                    color: scndColor,
                  ),
                )),
              ),
            ),
            SizedBox(
              height: mdqr.size.height * 0.05,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AdaptiveRaisedButton(
                buttonText: 'Start symptom assessment',
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.55,
                handlerFn: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AssessmentPages()),
                  );
                }),
              ),
            ),
            SizedBox(
              height: mdqr.size.height * 0.01,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: scndColor,
                  size: mdqr.size.width * 0.1,
                ),
                onPressed: () {
                  // print('Open drawer!');
                  _scaffoldState.currentState.openEndDrawer();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
