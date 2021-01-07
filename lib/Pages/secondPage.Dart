import 'package:flutter/material.dart';

class SecondPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SecondPage'),
      ),
      body: RaisedButton(
        child: Text('back'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
