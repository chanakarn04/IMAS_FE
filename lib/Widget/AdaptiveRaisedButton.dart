import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveRaisedButton extends StatefulWidget {
  final String buttonText;
  final Function handlerFn;
  final double height;
  final double width;

  AdaptiveRaisedButton(
      {this.buttonText, this.height, this.width, this.handlerFn});

  @override
  _AdaptiveRaisedButtonState createState() => _AdaptiveRaisedButtonState();
}

class _AdaptiveRaisedButtonState extends State<AdaptiveRaisedButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: widget.handlerFn,
      color: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(7),
        height: widget.height,
        width: widget.width,
        child: FittedBox(child: Text(widget.buttonText)),
      ),
      padding: EdgeInsets.all(5),
    );
  }
}
