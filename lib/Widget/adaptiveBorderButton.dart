import 'package:flutter/material.dart';

class AdaptiveBorderButton extends StatelessWidget {
  final String buttonText;
  final Function handlerFn;
  final double pctHeight;

  AdaptiveBorderButton(this.buttonText, this.pctHeight, this.handlerFn);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: MediaQuery.of(context).size.height * (pctHeight + 0.03),
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
      ),
    );
  }
}
