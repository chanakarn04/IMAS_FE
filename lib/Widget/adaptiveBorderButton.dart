import 'package:flutter/material.dart';

class AdaptiveBorderButton extends StatelessWidget {
  final String buttonText;
  final Function handlerFn;
  final double pctHeight;
  final double pctWidth;

  AdaptiveBorderButton(
      this.buttonText, this.pctHeight, this.pctWidth, this.handlerFn);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * (pctHeight + 0.03),
      width: MediaQuery.of(context).size.width * pctWidth,
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: FlatButton(
          child: Container(
            height: MediaQuery.of(context).size.height * pctHeight,
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
