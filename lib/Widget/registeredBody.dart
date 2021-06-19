import 'package:flutter/material.dart';

import '../Pages/loginPage.dart';

Widget registerdBody(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 25,
      ),
      child: Column(
        children: [
          Expanded(child: Container()),
          Container(
            height: MediaQuery.of(context).size.width - 60,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/registeredImage.png'),
              ),
            ),
          ),
          Text(
            'Brilliant!',
            style: TextStyle(fontSize: 32),
          ),
          Text(
            'Your account has been create\nHope you enjoy using our application',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromARGB(255, 165, 165, 165)),
          ),
          Expanded(child: Container()),
          ElevatedButton(
            onPressed: () =>
              Future.delayed(Duration.zero, () => Navigator.of(context).popUntil(ModalRoute.withName(LogInPage.routeName))),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(5),
              shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 0,
            ),
            child: Container(
              padding: EdgeInsets.all(7),
              height: 30,
              width: 200,
              alignment: Alignment.center,
              child: Text('Log in'),
            ),
          ),
        ],
      ),
    ),
  );
}
