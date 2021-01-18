import 'package:flutter/material.dart';

class ProgressDot4 extends StatelessWidget {
  final int current;

  ProgressDot4(this.current);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (current == 1)
                ? Theme.of(context).primaryColor
                : Color.fromARGB(100, 75, 75, 75),
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (current == 2)
                ? Theme.of(context).primaryColor
                : Color.fromARGB(100, 75, 75, 75),
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (current == 3)
                ? Theme.of(context).primaryColor
                : Color.fromARGB(100, 75, 75, 75),
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (current == 4)
                ? Theme.of(context).primaryColor
                : Color.fromARGB(100, 75, 75, 75),
          ),
        ),
      ],
    );
  }
}
