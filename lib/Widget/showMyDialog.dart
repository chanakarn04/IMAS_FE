import 'package:flutter/material.dart';

showMyDialog(
  BuildContext context,
  String title,
  String description,
  String cancelButtonText,
  String confirmButtonText,
  Function handler,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          FlatButton(
            onPressed: () {
              print('Cancel');
              Navigator.of(context).pop();
            },
            child: Text(
              cancelButtonText,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          FlatButton(
            onPressed: handler,
            child: Text(
              confirmButtonText,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}
