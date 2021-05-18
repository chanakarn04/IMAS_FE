import 'package:flutter/material.dart';

class AdaptiveRaisedButton extends StatelessWidget {
  final String buttonText;
  final Function handlerFn;
  final double height;
  final double width;

  AdaptiveRaisedButton(
      {this.buttonText, this.height, this.width, this.handlerFn});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handlerFn,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        primary: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(7),
        height: height,
        width: width,
        alignment: Alignment.center,
        child: Text(
          buttonText,
          // style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
