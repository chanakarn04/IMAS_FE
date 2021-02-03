import 'package:flutter/material.dart';

import '../Widget/Logo.dart';
import '../Widget/AdaptiveRaisedButton.dart';

class LogInPage extends StatelessWidget {
  static const routeName = '/login';
  final usrnTextController = TextEditingController();
  final pswTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: Logo(),
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
              controller: usrnTextController,
            ),
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              controller: pswTextController,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Forget Password?'),
          ),
          AdaptiveRaisedButton(
            buttonText: 'LOGIN',
            handlerFn: () {},
            height: 30,
            width: 100,
          ),
          Row(
            children: <Widget>[
              Text(
                'Don\u0027t have an account? ',
              ),
              Text('Sign Up'),
            ],
          ),
        ],
      ),
    );
  }
}
