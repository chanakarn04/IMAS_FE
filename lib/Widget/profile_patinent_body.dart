import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dummy_data.dart';

class ProfilePatientBody extends StatelessWidget {
  final Function headerBox;

  ProfilePatientBody(this.headerBox);

  //user data
  final Map<String, Object> data = {
    'userName': 'example@mail.com',
    'pName': 'Samitanan',
    'pSurname': 'Techabunyawatthanakul',
    'dob': DateTime(1998, 4, 12),
    'gender': Gender.Female,
    'drugAllergy': [
      'Paracetamol',
      'Bakamol',
    ],
    'isSmoke': Status.No,
    'isDiabetes': Status.No,
    'hasHighPress': Status.NotSure,
  };

  String get genderText {
    switch (data['gender']) {
      case Gender.Male:
        return 'Male';
        break;
      case Gender.Female:
        return 'Female';
        break;
      default:
        return 'Unknown';
    }
  }

  String get smokeText {
    switch (data['isSmoke']) {
      case Status.NotSure:
        return 'Not sure';
        break;
      case Status.No:
        return 'No';
        break;
      case Status.Yes:
        return 'Yes';
        break;
      default:
        return 'Unknown';
    }
  }

  String get diabeteText {
    switch (data['isDiabetes']) {
      case Status.NotSure:
        return 'Not sure';
        break;
      case Status.No:
        return 'No';
        break;
      case Status.Yes:
        return 'Yes';
        break;
      default:
        return 'Unknown';
    }
  }

  String get highPressText {
    switch (data['hasHighPress']) {
      case Status.NotSure:
        return 'Not sure';
        break;
      case Status.No:
        return 'No';
        break;
      case Status.Yes:
        return 'Yes';
        break;
      default:
        return 'Unknown';
    }
  }

  int get _getDrugAllergyLength {
    List temp = data['drugAllergy'];
    return temp.length;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            alignment: Alignment.center,
            height: 120,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/images/default_photo.png',
                  ),
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
                right: 8.0,
              ),
              child: ListView(
                children: [
                  headerBox(
                    context,
                    'Basic info',
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            bottom: 8.0,
                          ),
                          child: Text(
                            '${data['pName']} ${data['pSurname']}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            bottom: 8.0,
                          ),
                          child: Text(
                            data['userName'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Date of birth',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            bottom: 8.0,
                          ),
                          child: Text(
                            DateFormat.yMMMMd().format(data['dob']),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Gender',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            bottom: 8.0,
                          ),
                          child: Text(
                            genderText,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  headerBox(
                    context,
                    'Chronic health condition',
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '\u2022 High Bloddpressure',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(child: Container()),
                            Container(
                              height: 30,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                highPressText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              '\u2022 Diabetes',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(child: Container()),
                            Container(
                              height: 30,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                diabeteText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              '\u2022 Smoke',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Expanded(child: Container()),
                            Container(
                              height: 30,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                smokeText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  headerBox(
                      context,
                      'Drug allergy',
                      (_getDrugAllergyLength > 0)
                          ? SizedBox(
                              height: _getDrugAllergyLength * 30.0,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  List drugs = data['drugAllergy'];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      '\u2022 ${drugs[index]}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  );
                                },
                                itemCount: _getDrugAllergyLength,
                              ),
                            )
                          : SizedBox(
                              height: 60,
                              child: Center(
                                child: Text(
                                  'No drug allergy',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
