import 'package:flutter/material.dart';

import '../Provider/user-info.dart';

class TextBoxItem extends StatelessWidget {
  final Role userRole;
  final Role msgRole;
  final String text;

  TextBoxItem(this.userRole, this.msgRole, this.text);

  @override
  Widget build(BuildContext context) {
    final raisedDeco = BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(5),
    );
    final borderDeco = BoxDecoration(
      border: Border.all(
        width: 2,
        color: Theme.of(context).primaryColor,
      ),
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(5),
    );

    return Container(
      margin: msgRole != userRole
        ? EdgeInsets.only(left: 10)
        :EdgeInsets.only(right: 10),
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(10),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
          decoration: msgRole != userRole ? raisedDeco : borderDeco,
          child: Text(
            text,
            style: TextStyle(
              color: msgRole != userRole
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              fontSize: 18,
            ),
            overflow: TextOverflow.clip,
          ),
        ),
      ),
    );
  }
}
