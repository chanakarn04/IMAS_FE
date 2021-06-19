import 'package:flutter/material.dart';

import '../Models/model.dart';

class ProfileDoctorBody extends StatelessWidget {
  final Function headerBox;
  final Map<String, dynamic> dInfo;

  ProfileDoctorBody(this.headerBox, this.dInfo);

  String genderText(Gender gender) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
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
                    onTap: () => Navigator.of(context).pop(),
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
                            image: AssetImage('assets/images/default_photo.png'),
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        '${dInfo['fname']} ${dInfo['surname']}',
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
            height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + 154),
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
                    offset: Offset(0, 3),
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
                                SizedBox(height: 10),
                                Text(
                                  'Gender',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${dInfo['userName']}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  genderText(dInfo['gender']),
                                  style: TextStyle(fontSize: 18),
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
                    'Medical certification',
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Medical ID',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Certificcate ID',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 125, 125, 125),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${dInfo['medID']}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${dInfo['certID']}',
                                  style: TextStyle(fontSize: 18),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
