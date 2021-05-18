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
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        topLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
    );
    final borderDeco = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        topLeft: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
    );

    return Container(
      margin: msgRole != userRole
          ? EdgeInsets.only(left: 10)
          : EdgeInsets.only(right: 10),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: msgRole != userRole
                ? BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  )),
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
                  : Colors.black,
              fontSize: 18,
            ),
            overflow: TextOverflow.clip,
          ),
        ),
      ),
    );
  }
}
