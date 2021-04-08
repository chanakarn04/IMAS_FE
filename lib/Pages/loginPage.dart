import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Pages/homePages.dart';
import '../Widget/Logo.dart';
import '../Widget/AdaptiveRaisedButton.dart';
// import './forgetPswPage.dart';
import './registerPage.dart';
import '../Provider/user-info.dart';

class LogInPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final usrnTextController = TextEditingController();

  final pswTextController = TextEditingController();

  var _tryLogin = false;

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    if (userInfo.role != Role.UnAuthen) {
      // prevent animation for prevent state/listener problem
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      });
      // Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 70,
            bottom: 20,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: (userInfo.role == Role.UnAuthen && _tryLogin)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 130,
                        child: FittedBox(child: Logo()),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                        controller: usrnTextController,
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        controller: pswTextController,
                        onSubmitted: (_) => FocusScope.of(context).unfocus(),
                        obscureText: true,
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   height: 40,
                    //   child: TextButton(
                    //     onPressed: () {
                    //       // print('to forget password');
                    //       Navigator.of(context).pushNamed(ForgetPswPage.routeName);
                    //     },
                    //     child: FittedBox(
                    //       child: Text(
                    //         'Forget Password?',
                    //         style:
                    //             TextStyle(color: Color.fromARGB(255, 125, 125, 125)),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 25,
                    ),
                    AdaptiveRaisedButton(
                      buttonText: 'LOGIN',
                      handlerFn: () {
                        if (usrnTextController.text.isNotEmpty &&
                            pswTextController.text.isNotEmpty) {
                          // passing data to verify
                          // print('call login service');
                          // print('user: ${usrnTextController.text}');
                          // print('pswd: ${pswTextController.text}');
                          setState(() {
                            _tryLogin = true;
                          });
                          // print(_isLogin);
                          userInfo.login(
                            usrnTextController.text,
                            pswTextController.text,
                          );
                        }
                      },
                      height: 35,
                      width: 120,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\u0027t have an account? ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 75, 75, 75),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RegisterPage.routeName);
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
