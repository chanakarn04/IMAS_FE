import 'package:flutter/material.dart';

import '../../Models/model.dart';
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

  int statusTranslate(Status status) {
    if (status == Status.No) {
      return 0;
    } else if (status == Status.NotSure) {
      return 1;
    } else {
      return 2;
    }
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
    Map<String, dynamic> registerData =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
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
                    ElevatedButton(
                      onPressed: () {
                        registerData.addAll({
                          'isSmoke': statusTranslate(isSmoke),
                          'isDiabetes': statusTranslate(isDiabetes),
                          'hasHighPress': statusTranslate(hasHighPress),
                        });
                        Navigator.of(context)
                            .pushNamed(RegisterPatient3Screen.routeName, arguments: registerData);
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
                        child: Text(
                          'Next',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
