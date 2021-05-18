import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/AdaptiveRaisedButton.dart';
import './painScorePage.dart';
import '../Provider/vitalSign_Info.dart';

class PainScoreStartPage extends StatelessWidget {
  static const routeName = '/painScore-start';

  @override

  Widget build(BuildContext context) {
    final vitalSign = Provider.of<VitalSignProvider>(context);
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
              child: Text('Pain score',
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
                  'We want you to help us determine pain level of your symptom',
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
                  // print('JaJa');
                  Navigator.of(context).pushNamed(
                    PainScorePage.routeName,
                    arguments: {
                      'index': 0,
                      'symptom': vitalSign.symptoms,
                    },
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
