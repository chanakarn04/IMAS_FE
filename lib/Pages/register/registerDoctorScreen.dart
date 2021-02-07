import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Widget/AdaptiveRaisedButton.dart';
import '../../Widget/adaptiveBorderButton.dart';

class RegisterDoctorScreen extends StatefulWidget {
  static const routeName = '/Register-doctor';

  @override
  _RegisterDoctorScreenState createState() => _RegisterDoctorScreenState();
}

class _RegisterDoctorScreenState extends State<RegisterDoctorScreen> {
  final _scrollCrtl = ScrollController();
  final usrnTxtCtrl = TextEditingController();
  final pswTxtCtrl = TextEditingController();
  final cfPswTxtCtrl = TextEditingController();
  final nameTxtCtrl = TextEditingController();
  final surnameTxtCtrl = TextEditingController();
  final citizenIdTxtCtrl = TextEditingController();
  final medIdTxtCtrl = TextEditingController();
  final certIdTxtCtrl = TextEditingController();
  String prefix = 'Dr.';
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
    if (pswTxtCtrl.text == cfPswTxtCtrl.text) {
      setState(() {
        _validate = true;
      });
    } else {
      setState(() {
        pswTxtCtrl.clear();
        cfPswTxtCtrl.clear();
        _validate = false;
        _scrollCrtl.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 100),
        );
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
            // bottom: 30,
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
              Expanded(
                child: ListView(
                  controller: _scrollCrtl,
                  children: [
                    TextField(
                      controller: usrnTxtCtrl,
                      decoration: InputDecoration(labelText: 'Email/Username'),
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
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
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
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
                      onEditingComplete: () => FocusScope.of(context).unfocus(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Prefix',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          // alignment: Alignment.centerRight,
                          width: 100,
                          child: DropdownButton(
                            value: prefix,
                            icon: Icon(Icons.arrow_drop_down_rounded),
                            underline: Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                prefix = newValue;
                              });
                            },
                            items: <String>[
                              'Dr.',
                              'Doctor',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: nameTxtCtrl,
                      decoration: InputDecoration(labelText: 'Name'),
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
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
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 18),
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
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 18),
                        ),
                        Expanded(child: Container()),
                        buildGenderCard(context, 0, 'Male'),
                        SizedBox(
                          width: 10,
                        ),
                        buildGenderCard(context, 1, 'Female'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: citizenIdTxtCtrl,
                      decoration: InputDecoration(labelText: 'Citizen ID'),
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: medIdTxtCtrl,
                      decoration: InputDecoration(labelText: 'Medical ID'),
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: certIdTxtCtrl,
                      decoration: InputDecoration(labelText: 'Certificate ID'),
                      onSubmitted: (_) => FocusScope.of(context).unfocus(),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
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
                    height: 50,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  AdaptiveRaisedButton(
                    buttonText: 'Submit',
                    handlerFn: () {
                      print(usrnTxtCtrl.text);
                      print(pswTxtCtrl.text);
                      print(cfPswTxtCtrl.text);
                      print(nameTxtCtrl.text);
                      print(surnameTxtCtrl.text);
                      print(citizenIdTxtCtrl.text);
                      print(medIdTxtCtrl.text);
                      print(certIdTxtCtrl.text);
                      if (usrnTxtCtrl.text.isNotEmpty &&
                          pswTxtCtrl.text.isNotEmpty &&
                          cfPswTxtCtrl.text.isNotEmpty &&
                          nameTxtCtrl.text.isNotEmpty &&
                          surnameTxtCtrl.text.isNotEmpty &&
                          citizenIdTxtCtrl.text.isNotEmpty &&
                          medIdTxtCtrl.text.isNotEmpty &&
                          certIdTxtCtrl.text.isNotEmpty &&
                          _selectedDate != null) {
                        if (pswTxtCtrl.text == cfPswTxtCtrl.text) {
                          checkCfPwd();
                          print('Register Done!!');
                          // Navigator.of(context)
                          //     .pushNamed(RegisterPatient2Screen.routeName);
                        } else {
                          checkCfPwd();
                        }
                      }
                    },
                    width: 120,
                    height: 40,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
