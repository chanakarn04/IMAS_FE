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
    return Container(
      height: (height + 0.03),
      width: width,
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: FlatButton(
          child: Container(
            height: height,
            child: FittedBox(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          onPressed: handlerFn),
    );
  }
}
