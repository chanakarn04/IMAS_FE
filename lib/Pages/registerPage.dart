import 'package:flutter/material.dart';

import './register/registerPatientScreen_1.dart';
import './register/registerDoctorScreen.dart';
import '../Widget/AdaptiveRaisedButton.dart';
import '../Widget/adaptiveBorderButton.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var role = 0;
  Widget buildRoleCard(
    BuildContext context,
    var activeRole,
    IconData iconData,
    String title,
  ) {
    if (role == activeRole) {
      return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ],
            stops: [0.4, 0.9],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 72,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 3,
              color: Theme.of(context).primaryColor,
            )),
        child: InkWell(
          onTap: toggleRole,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: Theme.of(context).primaryColor,
                size: 56,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  toggleRole() {
    setState(() {
      if (role == 0) {
        role = 1;
      } else {
        role = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Register as',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildRoleCard(
                  context,
                  0,
                  Icons.account_box_outlined,
                  'Patient',
                ),
                SizedBox(
                  width: 20,
                ),
                buildRoleCard(
                  context,
                  1,
                  Icons.medical_services_outlined,
                  'Doctor',
                ),
              ],
            ),
            SizedBox(
              height: 75,
            ),
            AdaptiveRaisedButton(
              buttonText: 'Next',
              handlerFn: () {
                if (role == 0) {
                  // print('to patient register');
                  Navigator.of(context)
                      .pushNamed(RegisterPatient1Screen.routeName);
                } else {
                  // print('to doctor registor');
                  Navigator.of(context)
                      .pushNamed(RegisterDoctorScreen.routeName);
                }
              },
              height: 30,
              width: MediaQuery.of(context).size.width * 0.85,
            ),
            SizedBox(
              height: 10,
            ),
            AdaptiveBorderButton(
              buttonText: 'Cancel',
              handlerFn: () {
                Navigator.of(context).pop();
              },
              height: 40,
              width: (MediaQuery.of(context).size.width * 0.85) + 10,
            ),
          ],
        ),
      ),
    );
  }
}
