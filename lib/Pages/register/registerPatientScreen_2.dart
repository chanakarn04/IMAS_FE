import 'package:flutter/material.dart';

import '../../dummy_data.dart';
import '../../Widget/AdaptiveRaisedButton.dart';
import '../../Widget/adaptiveBorderButton.dart';
import '../../Widget/progressDot.dart';
import './registerPatientScreen_3.dart';

class RegisterPatient2Screen extends StatefulWidget {
  static const routeName = '/Register-patient-step2';

  @override
  _RegisterPatient2ScreenState createState() => _RegisterPatient2ScreenState();
}

class _RegisterPatient2ScreenState extends State<RegisterPatient2Screen> {
  int selectedGender = 0;
  Status isSmoke = Status.NotSure;
  Status isDiabetes = Status.NotSure;
  Status hasHighPress = Status.NotSure;

  void toggleHasHighPress(Status selectStatus) {
    setState(() {
      hasHighPress = selectStatus;
    });
  }

  void toggleIsDiabetes(Status selectStatus) {
    setState(() {
      isDiabetes = selectStatus;
    });
  }

  void toggleIsSmoke(Status selectStatus) {
    setState(() {
      isSmoke = selectStatus;
    });
  }

  Widget buildSelectionDot(
    String text,
    Status labelStatus,
    Status selectedStatus,
    Function handlerFn,
  ) {
    if (selectedStatus == labelStatus) {
      return Container(
        height: 65,
        width: 65,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () => handlerFn(labelStatus),
        child: Container(
          height: 65,
          width: 65,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // color: Colors.white,
            border: Border.all(
              width: 2,
              // color: Theme.of(context).primaryColor,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              // color: Theme.of(context).primaryColor,
              color: Colors.grey,
              // fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      );
    }
  }

  Widget buildSelectionRow(
    String title,
    int type,
  ) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        if (type == 0)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                buildSelectionDot(
                    'No', Status.No, hasHighPress, toggleHasHighPress),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                buildSelectionDot('Not\nsure', Status.NotSure, hasHighPress,
                    toggleHasHighPress),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                buildSelectionDot(
                    'Yes', Status.Yes, hasHighPress, toggleHasHighPress),
              ],
            ),
          ),
        if (type == 1)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                buildSelectionDot(
                    'No', Status.No, isDiabetes, toggleIsDiabetes),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                buildSelectionDot(
                    'Not\nsure', Status.NotSure, isDiabetes, toggleIsDiabetes),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                buildSelectionDot(
                    'Yes', Status.Yes, isDiabetes, toggleIsDiabetes),
              ],
            ),
          ),
        if (type == 2)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                buildSelectionDot('No', Status.No, isSmoke, toggleIsSmoke),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                buildSelectionDot(
                    'Not\nsure', Status.NotSure, isSmoke, toggleIsSmoke),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                buildSelectionDot('Yes', Status.Yes, isSmoke, toggleIsSmoke),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
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
                height: 35,
              ),
              buildSelectionRow('Do you have high blood pressure?', 0),
              SizedBox(
                height: 35,
              ),
              buildSelectionRow('Do You have diabetes?', 1),
              SizedBox(
                height: 35,
              ),
              buildSelectionRow('Do you smoke?', 2),
              Expanded(child: Container()),
              ProgressDot(
                length: 3,
                markedIndex: 2,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AdaptiveBorderButton(
                    buttonText: 'Back',
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
                    buttonText: 'Next',
                    handlerFn: () {
                      Navigator.of(context)
                          .pushNamed(RegisterPatient3Screen.routeName);
                    },
                    width: 120,
                    height: 40,
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
