import 'package:flutter/material.dart';

import '../Widget/AdaptiveRaisedButton.dart';

class ForgetPswPage extends StatelessWidget {
  static const routeName = '/forget-password';
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 30,
            right: 20,
            top: 70,
            bottom: 30,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Forget passwaord',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.1, 0.1),
                        blurRadius: 2,
                        color: Color.fromARGB(63, 0, 0, 0),
                      ),
                      Shadow(
                        offset: Offset(0.1, 0.1),
                        blurRadius: 3,
                        color: Color.fromARGB(31, 0, 0, 0),
                      ),
                      Shadow(
                        offset: Offset(0.1, 0.1),
                        blurRadius: 4,
                        color: Color.fromARGB(1, 0, 0, 0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  'Please enter your email',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  'we will send recovery link to your email',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 150, 150, 150),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: textController,
                decoration: InputDecoration(hintText: 'Example@mail.com'),
              ),
              SizedBox(
                height: 25,
              ),
              AdaptiveRaisedButton(
                buttonText: 'Submit',
                handlerFn: () {
                  print('Submit fgt psw');
                  print('${textController.text}');
                },
                height: 35,
                width: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
