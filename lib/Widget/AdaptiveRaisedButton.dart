import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveRaisedButton extends StatelessWidget {
  final String buttonText;
  final Function handlerFn;
  final double height;
  final double width;

  AdaptiveRaisedButton(
      {this.buttonText, this.height, this.width, this.handlerFn});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: handlerFn,
      color: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(7),
        height: height,
        width: width,
        child: FittedBox(child: Text(buttonText)),
      ),
      padding: EdgeInsets.all(5),
    );
  }
}
