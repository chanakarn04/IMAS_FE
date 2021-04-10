import 'package:flutter/material.dart';

import './register/registerPatientScreen_1.dart';
import './register/registerDoctorScreen.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String role = 'Patient';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 50,
          bottom: 30,
        ),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(),
                      flex: 2,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width - 100,
                      width: MediaQuery.of(context).size.width - 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/images/registerImage.png',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Please select your role',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 165, 165, 165),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 60) / 2.5,
                        child: DropdownButton<String>(
                          itemHeight: 60,
                          isExpanded: true,
                          value: role,
                          onChanged: (String newValue) {
                            setState(() {
                              role = newValue;
                            });
                          },
                          items: <String>[
                            'Patient',
                            'Doctor',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (role == 'Patient') {
                  // print('to patient register');
                  Navigator.of(context)
                      .pushNamed(RegisterPatient1Screen.routeName);
                } else {
                  // print('to doctor registor');
                  Navigator.of(context)
                      .pushNamed(RegisterDoctorScreen.routeName);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(5),
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: Container(
                padding: EdgeInsets.all(7),
                height: 30,
                width: 200,
                alignment: Alignment.center,
                child: Text(
                  'Next',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
