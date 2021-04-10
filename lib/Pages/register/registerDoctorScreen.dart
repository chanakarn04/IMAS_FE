import 'package:flutter/material.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart' as ddp;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../loginPage.dart';
import '../../Widget/registeredBody.dart';

class RegisterDoctorScreen extends StatefulWidget {
  static const routeName = '/Register-doctor';

  @override
  _RegisterDoctorScreenState createState() => _RegisterDoctorScreenState();
}

class _RegisterDoctorScreenState extends State<RegisterDoctorScreen> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = false;

  final emailTxtCtrl = new TextEditingController();
  final passwordTxtCtrl = new TextEditingController();
  final cfPasswordTxtCtrl = new TextEditingController();
  final fnameTxtCtrl = new TextEditingController();
  final snameTxtCtrl = new TextEditingController();
  final citizenIdTxtCtrl = new TextEditingController();
  final medIdTxtCtrl = new TextEditingController();
  final certIdTxtCtrl = new TextEditingController();

  String email;
  String password;
  String cfPassword;
  String prefix = '-';
  String fname;
  String sname;
  String citizenID;
  String medID;
  String certID;
  DateTime dob;
  int selectedGender = 0;

  // Doctor Prefix List
  // AuD - Doctor of Audiology
  // DC - Doctor of Chiropractic
  // DDS - Doctor of Dental Surgery, Doctor of Dental Science
  // DMD - Doctor of Dental Medicine, Doctor of Medical Dentistry
  // DO or OD - Doctor of Optometry, Doctor of Osteopathic Medicine
  // DPM - Doctor of Podiatric Medicine
  // DPT - Doctor of Physical Therapy
  // DScPT - Doctor of Science in Physical Therapy
  // DSN - Doctor of Science in Nursing
  // DVM - Doctor of Veterinary Medicine
  // ENT - Ear, nose and throat specialist
  // GP - General Practitioner
  // GYN - Gynecologist
  // MD - Doctor of Medicine
  // MS - Master of Surgery
  // OB/GYN - Obstetrician and Gynecologist
  // PharmD - Doctor of Pharmacy
  final prefixList = [
    'AuD',
    'DC',
    'DDS',
    'DMD',
    'DO',
    'DPM',
    'DPT',
    'DScPT',
    'DSN',
    'DVM',
    'ENT',
    'GP',
    'GYN',
    'MD',
    'MS',
    'OB/GYN',
    'PharmD',
    '-'
  ];

  @override
  void dispose() {
    emailTxtCtrl.dispose();
    passwordTxtCtrl.dispose();
    cfPasswordTxtCtrl.dispose();
    fnameTxtCtrl.dispose();
    snameTxtCtrl.dispose();
    citizenIdTxtCtrl.dispose();
    medIdTxtCtrl.dispose();
    certIdTxtCtrl.dispose();
    // TODO: implement dispose
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
        dob = pickedDate;
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
      body: (_isLogin)
          ? regiterdBody(context)
          : Container(
              padding: EdgeInsets.only(
                // left: 15,
                // right: 15,
                // bottom: 30,
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
                    height: 5,
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
                          SingleChildScrollView(
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
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field must not empty';
                                        }
                                        if (!RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value)) {
                                          return 'Mail is not valid';
                                        }
                                        return null;
                                      },
                                      onEditingComplete: () {
                                        FocusScope.of(context).nextFocus();
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
                                      onEditingComplete: () {
                                        FocusScope.of(context).nextFocus();
                                      },
                                      onFieldSubmitted: (value) {
                                        password = value;
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
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                      onFieldSubmitted: (value) =>
                                          cfPassword = value,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Prefix',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 81, 81, 81),
                                            fontSize: 17,
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        DropdownButton<String>(
                                          value: prefix,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              prefix = newValue;
                                            });
                                          },
                                          items: prefixList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
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
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                      onFieldSubmitted: (value) =>
                                          fname = value,
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
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                      onFieldSubmitted: (value) =>
                                          sname = value,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Date of birth',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 81, 81, 81),
                                            fontSize: 16,
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        dropdownDatePicker,
                                      ],
                                    ),
                                  ),
                                  // Row(
                                  //   children: <Widget>[
                                  //     Text(
                                  //       'Date of Birth',
                                  //       style: TextStyle(
                                  //           color: Colors.grey[700], fontSize: 16),
                                  //     ),
                                  //     Expanded(
                                  //       child: Container(
                                  //         alignment: Alignment.centerRight,
                                  //         child: dob == null
                                  //             ? Text(
                                  //                 'No date chosen yet.',
                                  //                 style: TextStyle(
                                  //                   fontSize: 18,
                                  //                   color: Colors.grey,
                                  //                 ),
                                  //               )
                                  //             : Text(
                                  //                 '${DateFormat.yMd().format(dob)}',
                                  //                 style: TextStyle(
                                  //                   fontSize: 18,
                                  //                   color: Theme.of(context)
                                  //                       .primaryColor,
                                  //                   fontWeight: FontWeight.bold,
                                  //                 ),
                                  //               ),
                                  //       ),
                                  //     ),
                                  //     IconButton(
                                  //       iconSize: 36,
                                  //       icon: Icon(
                                  //         Icons.calendar_today_rounded,
                                  //         color: Theme.of(context).primaryColor,
                                  //       ),
                                  //       onPressed: _presentDatePicker,
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 50,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Gender',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 81, 81, 81),
                                              fontSize: 16),
                                        ),
                                        Expanded(child: Container()),
                                        buildGenderCard(context, 0, 'Male'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        buildGenderCard(context, 1, 'Female'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Citizen ID',
                                      ),
                                      controller: citizenIdTxtCtrl,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field must not empty';
                                        }
                                        return null;
                                      },
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                      onFieldSubmitted: (value) =>
                                          citizenID = value,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Medical ID',
                                      ),
                                      controller: medIdTxtCtrl,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field must not empty';
                                        }
                                        return null;
                                      },
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                      onFieldSubmitted: (value) =>
                                          medID = value,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Certificate ID',
                                      ),
                                      controller: certIdTxtCtrl,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This field must not empty';
                                        }
                                        return null;
                                      },
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                      onFieldSubmitted: (value) =>
                                          certID = value,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // print('password: $password');
                                      if (_formKey.currentState.validate()) {
                                        dob = DateTime(
                                          dropdownDatePicker.year,
                                          dropdownDatePicker.month,
                                          dropdownDatePicker.day,
                                        );
                                        print('emial:     $email');
                                        print('password:  $password');
                                        print('prefix:    $prefix');
                                        print('fname:     $fname');
                                        print('sname:     $sname');
                                        print(
                                            'dob:       ${DateFormat.yMd().format(dob)}');
                                        print('gender:    $selectedGender');
                                        print('citizID:   $citizenID');
                                        print('medID:     $medID');
                                        print('certID:    $certID');
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(SnackBar(
                                        //         content:
                                        //             Text('Processing Data')));
                                        // ...
                                        // send data to register in BE
                                        //
                                        setState(() {
                                          _isLogin = true;
                                        });
                                        //
                                        // ...
                                        // Navigator.of(context).popUntil(
                                        //     ModalRoute.withName(
                                        //         LogInPage.routeName));
                                      }
                                      // if (password != cfPassword)
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      padding: EdgeInsets.all(5),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      elevation: 0,
                                    ),
                                    child: Container(
                                      // padding: EdgeInsets.all(7),
                                      height: 30,
                                      width: 120,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Sign Up',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
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
              )),
    );
  }
}
