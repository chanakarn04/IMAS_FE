import 'package:flutter/material.dart';

import './vitalSign/vs_BodyTempPage.dart';
import '../Widget/adaptiveRaisedButton.dart';

class VitalSignStartPage extends StatefulWidget {
  static const routeName = '/vitalSign-start';
  @override
  _VitalSignStartPageState createState() => _VitalSignStartPageState();
}

class _VitalSignStartPageState extends State<VitalSignStartPage> {
  // Map<String, Object> vitalSign = {
  //   'Temp': null,
  //   'Pulse': null,
  //   'Breath': null,
  //   'Pressure': null,
  // };

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop()),
      title: Container(
        alignment: Alignment.center,
        child: Text('IMAS'),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.menu_rounded,
            color: Colors.transparent,
          ),
          onPressed: null,
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: 40,
        ),
        // alignment: Alignment.bottomCenter,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              child: Text('Vital Sign Measurement',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.clip),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              // color: Colors.deepPurple,
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: Text(
                  'We want to gather some information from you. That can help in diaganosis',
                  style: TextStyle(
                    color: Color.fromARGB(255, 75, 75, 75),
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
            SizedBox(
              height: 240,
            ),
            Align(
              alignment: Alignment.center,
              child: AdaptiveRaisedButton(
                buttonText: 'Start',
                height: 35,
                width: MediaQuery.of(context).size.width * 0.35,
                handlerFn: (() {
                  Navigator.of(context)
                      .pushNamed(VSBodyTempPage.routeName, arguments: {
                    'temp': 0,
                    'pulse': 0,
                    'breath': 0,
                    'pressure': '',
                  });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => VSBodyTempPage()),
                  // );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
