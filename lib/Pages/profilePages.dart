import 'package:flutter/material.dart';

import '../Widget/profile_patinent_body.dart';
import '../Widget/profile_doctor_body.dart';

class ProfilePages extends StatelessWidget {
  static const routeName = '/profile';

  // role of user
  //  0 = patient
  //  1 = doctor
  final int role = 1;

  Widget _buildHeaderBox(BuildContext context, String title, Widget child) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 24,
              ),
            ),
            Expanded(child: Container()),
            // SizedBox(
            //   height: 40,
            //   width: 40,
            //   child: InkWell(
            //     onTap: () {},
            //     child: Icon(
            //       Icons.edit_outlined,
            //       color: Theme.of(context).accentColor,
            //       size: 30,
            //     ),
            //   ),
            // )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
            top: 4,
            bottom: 4,
            right: 8,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Theme.of(context).accentColor,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            child: child,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pop()),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.transparent,
            ),
            onPressed: null,
          )
        ],
      ),
      body: (role == 0)
          ? ProfilePatientBody(_buildHeaderBox)
          : ProfileDoctorBody(_buildHeaderBox),
    );
  }
}
