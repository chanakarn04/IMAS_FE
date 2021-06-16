import 'package:flutter/material.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart' as ddp;
import 'package:provider/provider.dart';

import '../../Provider/user-info.dart';
import '../../Widget/registeredBody.dart';
import '../../Widget/registerError.dart';
import '../../Script/socketioScript.dart';

class RegisterDoctorScreen extends StatefulWidget {
  static const routeName = '/Register-doctor';

  @override
  _RegisterDoctorScreenState createState() => _RegisterDoctorScreenState();
}

class _RegisterDoctorScreenState extends State<RegisterDoctorScreen> {
  final _formKey = GlobalKey<FormState>();

  var _isRegistered = false;
  var _isRegistering = false;
  var _isRegisterSuccess = false;
  var _init = false;
  String errorDescribe;

  @override
  void didChangeDependencies() {
    if (!_init) {
      errorDescribe = '';
      _init = !_init;
    }
    super.didChangeDependencies();
  }

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
  bool selectedGender = true;

  Map<String, dynamic> registerData = {};

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
    final userInfo = Provider.of<UserInfo>(context);
    return Scaffold(
      body: (_isRegistering)
          ? (_isRegistered)
              ? (_isRegisterSuccess)
                  ? registerdBody(context)
                  : registerError(
                      context: context,
                      title: Text(
                        'Oops!',
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                      describe: Text(
                        errorDescribe,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ))
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: CircularProgressIndicator(
                          strokeWidth: 8.0,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Registering...',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                )
          : Container(
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
                                        if (value == null || value.isEmpty) {
                                          return 'This field must not empty';
                                        }
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
                                          items: prefixList.map<DropdownMenuItem<String>>((String value) {
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
                                  SizedBox(
                                    height: 50,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Gender',
                                          style: TextStyle(
                                              color: Color.fromARGB(255, 81, 81, 81),
                                              fontSize: 16),
                                        ),
                                        Expanded(child: Container()),
                                        buildGenderCard(context, true, 'Male'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        buildGenderCard(
                                            context, false, 'Female'),
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
                                        if (value.length > 13) {
                                          citizenIdTxtCtrl.clear();
                                          return 'This field must have no more than 13 charactor';
                                        }
                                        return null;
                                      },
                                      onChanged: (_) {
                                        citizenID = citizenIdTxtCtrl.text;
                                      },
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
                                        if (value.length > 11) {
                                          medIdTxtCtrl.clear();
                                          return 'This field must have no more than 11 charactor';
                                        }
                                        return null;
                                      },
                                      onChanged: (_) {                          
                                        medID = medIdTxtCtrl.text;
                                      },
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
                                        if (value.length > 20) {
                                          certIdTxtCtrl.clear();
                                          return 'This field must have no more than 11 charactor';
                                        }
                                        return null;
                                      },
                                      onChanged: (_) {
                                        certID = certIdTxtCtrl.text;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          _isRegistering = true;
                                        });
                                        dob = DateTime(
                                          dropdownDatePicker.year,
                                          dropdownDatePicker.month,
                                          dropdownDatePicker.day,
                                        );
                                        registerData.addAll({
                                          'userRole': 'doctor',
                                          'userName': email,
                                          'password': password,
                                          'DRName': fname,
                                          'DRSurname': sname,
                                          'nameSuffix': prefix,
                                          'gender': selectedGender,
                                          'citizenID': citizenID,
                                          'MDID': medID,
                                          'certID': certID,
                                        });
                                        await regisSocketConnect({
                                          'token': '',
                                          'userid': email,
                                        });
                                        await regisSocket.emit('event', [
                                          {
                                            'transaction': 'register',
                                            'payload': registerData
                                          }
                                        ]);
                                        await for (dynamic data in regisSocket.on('r-register')) {
                                          if (data != null) {
                                            setState(() {
                                              _isRegistered = true;
                                            });
                                            if (data[0]['value']['payload']['message'] == 'Register success') {
                                              setState(() {
                                                _isRegisterSuccess = true;
                                              });
                                            } else {
                                              setState(() {
                                                errorDescribe = data[0]['value']['payload']['message'];
                                              });
                                            }
                                          }
                                        }
                                        await regisSocketDisconnect();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      padding: EdgeInsets.all(5),
                                      shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      elevation: 0,
                                    ),
                                    child: Container(
                                      height: 30,
                                      width: 120,
                                      alignment: Alignment.center,
                                      child: Text('Submit'),
                                    ),
                                  ),
                                  SizedBox(height: 40),
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
    );
  }
}
