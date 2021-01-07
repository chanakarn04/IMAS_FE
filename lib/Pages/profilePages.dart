import 'package:flutter/material.dart';

class ProfilePages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile Page',
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
