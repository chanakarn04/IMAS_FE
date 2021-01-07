import 'package:flutter/material.dart';

import './Widget/sideDrawer.dart';
import './Widget/AdaptiveRaisedButton.dart';
import './Widget/Logo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IMAS - Home Page',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 81, 195, 169),
          primaryColorDark: Color.fromARGB(255, 38, 117, 99),
          primaryColorLight: Color.fromARGB(255, 133, 255, 226),
          accentColor: Color.fromARGB(255, 77, 159, 206),
        ),
        home: MyHomePage(),
        color: Color.fromARGB(255, 255, 255, 255));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mdqr = MediaQuery.of(context);
    final scndColor = Color.fromARGB(255, 75, 75, 75);
    return Scaffold(
      key: _scaffoldState,
      // appBar: AppBar(
      //   title: Text('Test'),
      // ),
      endDrawer: SideDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mdqr.size.width * 0.05,
          vertical: mdqr.size.width * 0.1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Drawer(),
            Container(
                height: mdqr.size.height * 0.3,
                child: FittedBox(child: Logo())),
            SizedBox(
              height: mdqr.size.height * 0.01,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: mdqr.size.width * 0.05),
                  child: Container(
                    // color: Colors.amber,
                    width: mdqr.size.width * 0.55,
                    height: mdqr.size.height * 0.2,
                    child: FittedBox(
                        child: Text(
                      'Hi. I can help you find\nwhat’s going on.\nJust start a symptom\nassessment.',
                      style: TextStyle(
                        color: scndColor,
                      ),
                    )),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              // mainAxisSize: MainAxisSize.min,
              child: AdaptiveRaisedButton('Start symptom assessment', 0.6, 0.07,
                  (() {
                print('Go to SA!');
              })),
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
                  print('Open drawer!');
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
