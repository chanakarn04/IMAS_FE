import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart' as ddp;

import './registerPatientScreen_2.dart';
import '../../Widget/progressDot.dart';

class RegisterPatient1Screen extends StatefulWidget {
  static const routeName = '/Register-patient-step1';

  @override
  _RegisterPatient1ScreenState createState() => _RegisterPatient1ScreenState();
}

class _RegisterPatient1ScreenState extends State<RegisterPatient1Screen> {
  final _formKey = GlobalKey<FormState>();

  final emailTxtCtrl = TextEditingController();
  final passwordTxtCtrl = TextEditingController();
  final cfPasswordTxtCtrl = TextEditingController();
  final fnameTxtCtrl = TextEditingController();
  final snameTxtCtrl = TextEditingController();
  String email;
  String password;
  String cfPassword;
  String fname;
  String sname;
  DateTime selectedDate;
  bool selectedGender = true;

  Map<String, dynamic> registerData = {};

  @override
  void dispose() {
    emailTxtCtrl.dispose();
    passwordTxtCtrl.dispose();
    cfPasswordTxtCtrl.dispose();
    fnameTxtCtrl.dispose();
    snameTxtCtrl.dispose();
    super.dispose();
  }

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
        selectedDate = pickedDate;
      });
    });
  }

  void toggleGender() {
    setState(() {
      selectedGender = !selectedGender;
    });
  }

  Widget buildGenderCard(BuildContext context, bool gender, String text) {
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

  final dropdownDatePicker = ddp.DropdownDatePicker(
    underLine: Container(
      height: 1.0,
      color: Colors.grey,
    ),
    initialDate:
        ddp.ValidDate(year: DateTime.now().year - 15, month: 1, day: 1),
    firstDate: ddp.ValidDate(year: DateTime.now().year - 80, month: 1, day: 1),
    lastDate: ddp.ValidDate(
        year: DateTime.now().year,
        month: DateTime.now().month,
        day: DateTime.now().day),
    textStyle: TextStyle(fontWeight: FontWeight.bold),
    dropdownColor: Colors.white,
    dateHint: ddp.DateHint(year: 'year', month: 'month', day: 'day'),
    ascending: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 5,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                child: InkWell(
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(left: 25),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 27),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Personal Infomation',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 20,
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                  ),
                                  controller: emailTxtCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field must not empty';
                                    }
                                    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                      return 'Mail is not valid';
                                    }
                                    if (value.length > 50) {
                                      return 'email is too long (50 characters)';
                                    }
                                    return null;
                                  },
                                  onChanged: (_) {
                                    email = emailTxtCtrl.text;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                  ),
                                  controller: passwordTxtCtrl,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field must not empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (_) {
                                    password = passwordTxtCtrl.text;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Confirm Password',
                                  ),
                                  controller: cfPasswordTxtCtrl,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value != password) {
                                      passwordTxtCtrl.clear();
                                      cfPasswordTxtCtrl.clear();
                                      return 'Password are not macthing';
                                    }
                                    return null;
                                  },
                                  onChanged: (_) {
                                    cfPassword = cfPasswordTxtCtrl.text;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'First name',
                                  ),
                                  controller: fnameTxtCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field must not empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (_) {
                                    fname = fnameTxtCtrl.text;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Surname',
                                  ),
                                  controller: snameTxtCtrl,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field must not empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (_) {
                                    sname = snameTxtCtrl.text;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Row(
                                  children: [
                                    Text(
                                      'Date of birth',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 81, 81, 81),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    dropdownDatePicker,
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Gender',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 81, 81, 81),
                                          fontSize: 16),
                                    ),
                                    Expanded(child: Container()),
                                    buildGenderCard(context, true, 'Male'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    buildGenderCard(context, false, 'Female'),
                                  ],
                                ),
                              ),
                              Expanded(child: Container()),
                              ProgressDot(
                                length: 3,
                                markedIndex: 1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    selectedDate = DateTime(
                                      dropdownDatePicker.year,
                                      dropdownDatePicker.month,
                                      dropdownDatePicker.day,
                                    );
                                    registerData.addAll({
                                      'userRole': 'patient',
                                      'userName': email,
                                      'password': password,
                                      'PName': fname,
                                      'PSurname': sname,
                                      'DoB': selectedDate.toString(),
                                      'gender': selectedGender,
                                    });
                                    Navigator.of(context).pushNamed(
                                        RegisterPatient2Screen.routeName,
                                        arguments: registerData);
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
                                  height: 30,
                                  width: 120,
                                  alignment: Alignment.center,
                                  child: Text('Next'),
                                ),
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withAlpha(0),
                                Colors.white,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
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
