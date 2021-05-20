import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../dummy_data.dart';
import '../../Models/model.dart';
import '../../Provider/patientInfo.dart';

class BasicInfoTab extends StatelessWidget {
  // final String userId;

  // // tpID from main Page
  // BasicInfoTab(this.userId);

  Map<String, dynamic> _loadData(
    String userId,
  ) {
    // ... use tpId to get data

    return {
      'gender': Gender.Male,
      'DoB': DateTime(1998, 4, 15),
      'isSmoke': Status.No,
      'isDiabetes': Status.NotSure,
      'hasHighPress': Status.Yes,
      'drugAllergy': ['Paracetamol'],
    };
  }

  // final pInfo = dummy_Patient;

  String genderText(gender) {
    switch (gender) {
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

  String smokeText(isSmoke) {
    switch (isSmoke) {
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

  String diabeteText(isDiabetes) {
    switch (isDiabetes) {
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

  String highPressText(hasHighPress) {
    switch (hasHighPress) {
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
    final patientInfo = Provider.of<PatientInfo>(context);
    final Map<String, dynamic> data = patientInfo.pInfo;
    // final String userId = ModalRoute.of(context).settings.arguments;
    // final data = _loadData(userId);
    // final Map<String, dynamic> data = {
    //   'gender': Gender.Male,
    //   'DoB': DateTime(1998, 4, 15),
    //   'isSmoke': Status.No,
    //   'isDiabetes': Status.NotSure,
    //   'hasHighPress': Status.Yes,
    //   'drugAllergy': ['Paracetamol'],
    // };
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
                    '${((DateTime.now().difference(data['dob']).inDays) / 365).floor()}',
                    // '${((DateTime.now().difference(data['dob']).inDays) / 365).floor()}',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${genderText(data['gender'])}',
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
                    '${highPressText(data['hasHighPress'])}',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${diabeteText(data['isDiabetes'])}',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${(smokeText(data['isSmoke']))}',
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
            height: (data['drugAllergy'].length.toDouble() * 30),
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
                  '\u2022 ${data['drugAllergy'][index]}',
                  style: TextStyle(fontSize: 24),
                );
              },
              itemCount: data['drugAllergy'].length,
            ),
          ),
        ],
      ),
    );
  }
}
