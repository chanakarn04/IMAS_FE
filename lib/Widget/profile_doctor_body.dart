import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Provider/user-info.dart';

// import '../dummy_data.dart';

class ProfileDoctorBody extends StatelessWidget {
  final Function headerBox;

  ProfileDoctorBody(this.headerBox);

  Doctor dInfo;
  // final Map<String, Object> data = {
  //   'userName': 'example@mail.com',
  //   'namePrefix': 'Dr.',
  //   'drName': 'Samitanan',
  //   'drSurname': 'Techabunyawatthanakul',
  //   'dob': DateTime(1998, 4, 12),
  //   'gender': Gender.Female,
  //   'citizenID': '1234567890123',
  //   'mdID': 'XXXXXXXXXXXXX',
  //   'certID': 'XXXXXXXXXXXXX',
  // };

  String get genderText {
    switch (dInfo.gender) {
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

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    dInfo = userInfo.dInfo;
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
                            userInfo.getUserName(),
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
                            userInfo.userId,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        // Text(
                        //   'Date of birth',
                        //   style: TextStyle(
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //     left: 8.0,
                        //     bottom: 8.0,
                        //   ),
                        //   child: Text(
                        //     DateFormat.yMMMMd().format(dInfo.),
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 20,
                        //     ),
                        //   ),
                        // ),
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
                        Text(
                          'Citizen ID',
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
                            dInfo.citizenID.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Medical ID',
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
                            dInfo.mdID,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Certificate ID',
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
                            dInfo.certID,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
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
