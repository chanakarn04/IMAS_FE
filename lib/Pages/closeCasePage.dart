import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './homePages.dart';
import '../Widget/adaptiveRaisedButton.dart';

class CloseCasePage extends StatelessWidget {
  static const routneName = '/CloseCase';

  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context).settings.arguments as Map;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Icon(
                Icons.check_circle_outline_rounded,
                color: Theme.of(context).primaryColor,
                size: 120,
              ),
              SizedBox(height: 15),
              if (routeArg['closeCase'])
                Text(
                  '${routeArg['name']} case\nhave successful close',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              if (!routeArg['closeCase'])
                Text(
                  'Create Appointment\nwith ${routeArg['name']}\non ${DateFormat.yMd().add_jm().format(routeArg['date'])}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              Expanded(child: Container()),
              AdaptiveRaisedButton(
                buttonText: 'Home',
                height: 30,
                width: 140,
                handlerFn: () => Navigator.of(context).popUntil(ModalRoute.withName(HomePage.routeName)),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
