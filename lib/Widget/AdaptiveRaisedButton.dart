import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveRaisedButton extends StatelessWidget {
  final String buttonText;
  final Function handlerFn;
  final double pctHeight;
  final double pctWidth;

  AdaptiveRaisedButton(
      this.buttonText, this.pctHeight, this.pctWidth, this.handlerFn);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: handlerFn,
      color: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(7),
        height: MediaQuery.of(context).size.height * pctHeight,
        width: MediaQuery.of(context).size.width * pctWidth,
        child: FittedBox(child: Text(buttonText)),
      ),
      padding: EdgeInsets.all(5),
    );
  }
}
