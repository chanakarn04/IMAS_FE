import 'package:flutter/material.dart';

class TextBoxItem extends StatelessWidget {
  final int role;
  final String text;

  TextBoxItem(this.role, this.text);

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

    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(10),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        decoration: role == 0 ? raisedDeco : borderDeco,
        child: Text(
          text,
          style: TextStyle(
            color: role == 0 ? Colors.white : Theme.of(context).primaryColor,
            fontSize: 18,
          ),
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
