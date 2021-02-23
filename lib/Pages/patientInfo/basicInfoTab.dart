import 'package:flutter/material.dart';

import '../../dummy_data.dart';

class BasicInfoTab extends StatelessWidget {
  final pInfo = dummy_Patient;

  String get genderText {
    switch (pInfo.gender) {
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
    switch (pInfo.isSmoke) {
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
    switch (pInfo.isDiabetes) {
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
    switch (pInfo.hasHighPress) {
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

  Widget _buildLineHeader(BuildContext context, String title) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            color: Theme.of(context).primaryColor,
            height: 3,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.orange[200],
      // height: 200,
      padding: EdgeInsets.only(
        top: 30,
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Column(
        children: <Widget>[
          _buildLineHeader(context, 'Basic Info'),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 5,
                  left: 15,
                  bottom: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Age:',
                      style: TextStyle(
                        color: Color.fromARGB(255, 150, 150, 150),
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Gender:',
                      style: TextStyle(
                        color: Color.fromARGB(255, 150, 150, 150),
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // '${((DateTime.now().month - pInfo.dob.month) / 12)}',
                    '${((DateTime.now().difference(pInfo.dob).inDays) / 365).floor()}',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '$genderText',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          _buildLineHeader(context, 'Chronic health conditions'),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 5,
                  left: 15,
                  bottom: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'High bloodpressure:',
                      style: TextStyle(
                        color: Color.fromARGB(255, 150, 150, 150),
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Diabete:',
                      style: TextStyle(
                        color: Color.fromARGB(255, 150, 150, 150),
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Smoke:',
                      style: TextStyle(
                        color: Color.fromARGB(255, 150, 150, 150),
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$highPressText',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '$diabeteText',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '$smokeText',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          _buildLineHeader(context, 'Drug allergy'),
          Container(
            height: (pInfo.drugAllegy.length.toDouble() * 30),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                left: 20,
                right: 5,
                top: 5,
                bottom: 5,
              ),
              itemBuilder: (context, index) {
                return Text(
                  '\u2022 ${pInfo.drugAllegy[index]}',
                  style: TextStyle(fontSize: 24),
                );
              },
              itemCount: pInfo.drugAllegy.length,
            ),
          ),
        ],
      ),
    );
  }
}
