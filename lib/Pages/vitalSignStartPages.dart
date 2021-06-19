import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/vitalSign_Info.dart';
import './vitalSign/vs_BodyTempPage.dart';
import '../Widget/adaptiveRaisedButton.dart';

class VitalSignStartPage extends StatefulWidget {
  static const routeName = '/vitalSign-start';
  @override
  _VitalSignStartPageState createState() => _VitalSignStartPageState();
}

class _VitalSignStartPageState extends State<VitalSignStartPage> {
  var _loadedData = false;
  VitalSignProvider vitalSign;

  @override
    void didChangeDependencies() {
      if (!_loadedData) {
        vitalSign = Provider.of<VitalSignProvider>(context);
        vitalSign.querySymptom();
        _loadedData = true;
      }
      super.didChangeDependencies();
    }

  @override
  Widget build(BuildContext context) {
    final vitalSign = Provider.of<VitalSignProvider>(context);
    final appBar = AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      backgroundColor: Colors.white,
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
    return Provider(
      create: (context) => VitalSignProvider(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: appBar,
          body: Container(
            padding: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              bottom: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                  child: Text('Vital Sign Measurement',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.clip),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
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
                SizedBox(height: 240),
                Align(
                  alignment: Alignment.center,
                  child: AdaptiveRaisedButton(
                    buttonText: 'Start',
                    height: 35,
                    width: MediaQuery.of(context).size.width * 0.35,
                    handlerFn: (() {
                      Navigator.of(context).pushNamed(
                        VSBodyTempPage.routeName,
                        arguments: vitalSign,
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
