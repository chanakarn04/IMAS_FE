import 'package:flutter/material.dart';

import '../Pages/registerPage.dart';

Widget registerError({
  @required BuildContext context,
  @required Widget title,
  @required Widget describe,
}) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        Icon(
          Icons.close_rounded,
          size: 100,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(height: 20),
        title,
        SizedBox(height: 15),
        describe,
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
              onPressed: () => Navigator.of(context).popUntil(ModalRoute.withName(RegisterPage.routeName)),
              child: Text('Register'),
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    ),
  );
}
