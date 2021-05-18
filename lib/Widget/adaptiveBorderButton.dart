import 'package:flutter/material.dart';

class AdaptiveBorderButton extends StatelessWidget {
  final String buttonText;
  final Function handlerFn;
  final double height;
  final double width;

  AdaptiveBorderButton(
      {this.buttonText, this.height, this.width, this.handlerFn});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handlerFn,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(7),
        height: height,
        width: width,
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
