import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Widget/progressDot.dart';
import '../../Widget/AdaptiveRaisedButton.dart';
import '../../Widget/adaptiveBorderButton.dart';

class RegisterPatient3Screen extends StatefulWidget {
  static const routeName = '/Register-patient-step3';

  @override
  _RegisterPatient3ScreenState createState() => _RegisterPatient3ScreenState();
}

class _RegisterPatient3ScreenState extends State<RegisterPatient3Screen> {
  final txtCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 30,
            top: 50,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
