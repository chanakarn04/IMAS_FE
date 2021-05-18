import 'package:flutter/material.dart';

myAlertDialog({
  @required BuildContext context,
  @required Function cancelFn,
  @required Function acceptFn,
  @required Widget title,
  Widget content,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('New request coming in'),
        // content: Column(
        //   children: [],
        // ),
        actions: [
          TextButton(
            onPressed: () {
              print('Cancel');
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              print('Accept');
              Navigator.of(context).pop();
            },
            child: Text('Accept'),
          ),
        ],
      );
    },
  );
}
