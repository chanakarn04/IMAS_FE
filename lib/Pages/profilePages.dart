import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/profile_patinent_body.dart';
import '../Widget/profile_doctor_body.dart';
import '../Provider/user-info.dart';

class ProfilePages extends StatelessWidget {
  static const routeName = '/profile';

  Widget _buildHeaderBox(BuildContext context, String title, Widget child) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
            top: 15,
            bottom: 8,
            right: 8,
          ),
          child:  child,
        ),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context, listen: false);
    return Scaffold(
      body: (userInfo.role == Role.Patient)
          ? ProfilePatientBody(_buildHeaderBox, userInfo.userData)
          : ProfileDoctorBody(_buildHeaderBox, userInfo.userData),
    );
  }
}
