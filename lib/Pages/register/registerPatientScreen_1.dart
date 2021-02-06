import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './registerPatientScreen_2.dart';
import '../../Widget/progressDot.dart';
import '../../Widget/AdaptiveRaisedButton.dart';
import '../../Widget/adaptiveBorderButton.dart';

class RegisterPatient1Screen extends StatefulWidget {
  static const routeName = '/Register-patient-step1';

  @override
  _RegisterPatient1ScreenState createState() => _RegisterPatient1ScreenState();
}

class _RegisterPatient1ScreenState extends State<RegisterPatient1Screen> {
  final usrnTxtCtrl = TextEditingController();
  final pswTxtCtrl = TextEditingController();
  final cfPswTxtCtrl = TextEditingController();
  final nameTxtCtrl = TextEditingController();
  final surnameTxtCtrl = TextEditingController();
  DateTime _selectedDate;
  int selectedGender = 0; // 0 as Male, 1 as Female
  var _validate = true;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child,
        );
      },
    ).then((pickedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void toggleGender() {
    setState(() {
      if (selectedGender == 0) {
        selectedGender = 1;
      } else {
        selectedGender = 0;
      }
    });
  }

  void checkCfPwd() {
    if (pswTxtCtrl.text == cfPswTxtCtrl) {
      setState(() {
        _validate = true;
      });
    } else {
      setState(() {
        pswTxtCtrl.clear();
        cfPswTxtCtrl.clear();
        _validate = false;
      });
    }
  }

  Widget buildGenderCard(BuildContext context, int gender, String text) {
    if (selectedGender == gender) {
      return Container(
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: toggleGender,
        child: Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
      );
    }
  }

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
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: usrnTxtCtrl,
                decoration: InputDecoration(labelText: 'Email/Username'),
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: pswTxtCtrl,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    errorText:
                        _validate ? null : '**Password are not macthing'),
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: cfPswTxtCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: nameTxtCtrl,
                decoration: InputDecoration(labelText: 'Name'),
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: surnameTxtCtrl,
                decoration: InputDecoration(labelText: 'Surname'),
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Date of Birth',
                    style: TextStyle(color: Colors.grey[700], fontSize: 18),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: _selectedDate == null
                          ? Text(
                              'No date chosen yet.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            )
                          : Text(
                              '${DateFormat.yMd().format(_selectedDate)}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  IconButton(
                    iconSize: 36,
                    icon: Icon(
                      Icons.calendar_today_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Gender',
                    style: TextStyle(color: Colors.grey[700], fontSize: 18),
                  ),
                  Expanded(child: Container()),
                  buildGenderCard(context, 0, 'Male'),
                  SizedBox(
                    width: 10,
                  ),
                  buildGenderCard(context, 1, 'Female'),
                ],
              ),
              Expanded(child: Container()),
              Align(
                alignment: Alignment.center,
                child: ProgressDot(
                  length: 3,
                  markedIndex: 1,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AdaptiveBorderButton(
                    buttonText: 'Cancel',
                    handlerFn: () {
                      Navigator.of(context).pop();
                    },
                    width: 130,
                    height: 40,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  AdaptiveRaisedButton(
                    buttonText: 'Next',
                    handlerFn: () {
                      Navigator.of(context)
                          .pushNamed(RegisterPatient2Screen.routeName);
                      // print(usrnTxtCtrl.text);
                      // print(pswTxtCtrl.text);
                      // print(cfPswTxtCtrl.text);
                      // print(nameTxtCtrl.text);
                      // print(surnameTxtCtrl.text);
                      // if (usrnTxtCtrl.text.isNotEmpty &&
                      //     pswTxtCtrl.text.isNotEmpty &&
                      //     cfPswTxtCtrl.text.isNotEmpty &&
                      //     nameTxtCtrl.text.isNotEmpty &&
                      //     surnameTxtCtrl.text.isNotEmpty &&
                      //     _selectedDate != null) {
                      //   if (pswTxtCtrl.text == cfPswTxtCtrl.text) {
                      //     // if (cfPswTxtCtrl.text.compareTo(pswTxtCtrl.text) == 0) {
                      //     print('Hello true');
                      //     Navigator.of(context)
                      //         .pushNamed(RegisterPatient2Screen.routeName);
                      //   } else {
                      //     print('Hello false');
                      //     checkCfPwd();
                      //   }
                      // }
                    },
                    width: 120,
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
