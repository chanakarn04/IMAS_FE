import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Pages/loginPage.dart';
import '../Provider/user-info.dart';

class LoggingOut extends StatelessWidget {
  static const routeName = '/logout';
  @override
  Widget build(BuildContext context) {
  final userInfo = Provider.of<UserInfo>(context);
    if (userInfo.role == Role.UnAuthen) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
        // Navigator.of(context).pushReplacementNamed(LogInPage.routeName);
        Navigator.of(context).pushNamed(LogInPage.routeName);
      });
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                strokeWidth: 8.0,
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Logging out...',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
