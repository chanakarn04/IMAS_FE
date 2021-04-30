import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../Provider/user-info.dart';
import '../Models/model.dart';

// import '../dummy_data.dart';

class ProfilePatientBody extends StatelessWidget {
  final Function headerBox;
  final String userId;

  ProfilePatientBody(this.headerBox, this.userId);

  //user data
  Patient pInfo;

  // load pInfo
  Patient _loadData() {
    // ...

    return Patient(
      pId: 'p0001',
      pName: 'pName',
      pSurname: 'pSurname',
      dob: DateTime(1998, 4, 12),
      gender: Gender.Female,
      drugAllegy: ['Paracetamol'],
      isSmoke: Status.No,
      isDiabetes: Status.Yes,
      hasHighPress: Status.NotSure,
      image: 'assets/images/default_photo.png',
    );
  }

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

  int get _getDrugAllergyLength {
    List temp = pInfo.drugAllegy;
    return temp.length;
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    pInfo = _loadData();
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
            ),
            decoration: BoxDecoration(
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
            height: 250,
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(
                              'assets/images/default_photo.png',
                            ),
                          ),
                          shape: BoxShape.circle,

                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${pInfo.pName} ${pInfo.pSurname}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top + 154),
            width: MediaQuery.of(context).size.width - 40,
            bottom: 0,
            left: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListView(
                children: [
                  headerBox(
                    context,
                    'General Infomation',
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Date of birth',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Gender',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userId,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  DateFormat.yMMMMd().format(pInfo.dob),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  genderText,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12),
                          height: 2,
                          color: Colors.grey.withAlpha(100),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'High Bloodpressure',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Diabetes',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Smokes',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  highPressText,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  diabeteText,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  smokeText,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12),
                          height: 2,
                          color: Colors.grey.withAlpha(100),
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
                                List drugs = pInfo.drugAllegy;
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    '${drugs[index]}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
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
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
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
    );
  }
}
