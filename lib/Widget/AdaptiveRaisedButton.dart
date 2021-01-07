import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveRaisedButton extends StatelessWidget {
  final String buttonText;
  final Function handlerFn;
  final double pctWidth;
  final double pctHeight;

  AdaptiveRaisedButton(
      this.buttonText, this.pctWidth, this.pctHeight, this.handlerFn);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * pctWidth,
      height: MediaQuery.of(context).size.height * pctHeight,
      child: CupertinoButton(
        onPressed: handlerFn,
        color: Theme.of(context).primaryColor,
        child: Text(buttonText),
        padding: EdgeInsets.all(5),
      ),
    );
  }
}
