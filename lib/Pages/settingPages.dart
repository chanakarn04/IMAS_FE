import 'package:flutter/material.dart';

class SettingPages extends StatelessWidget {
  static const routeName = '/setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Setting Page',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            RaisedButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
