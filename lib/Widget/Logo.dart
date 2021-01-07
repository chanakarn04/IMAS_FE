import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo();

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        color: Colors.black,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(0.1, 0.1),
            blurRadius: 2,
            color: Color.fromARGB(63, 0, 0, 0),
          ),
          Shadow(
            offset: Offset(0.1, 0.1),
            blurRadius: 3,
            color: Color.fromARGB(31, 0, 0, 0),
          ),
          Shadow(
            offset: Offset(0.1, 0.1),
            blurRadius: 4,
            color: Color.fromARGB(1, 0, 0, 0),
          )
        ],
        fontWeight: FontWeight.bold);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      // textDirection: TextDirection.ltr,
      children: [
        Text(
          'Intelligent',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(0.1, 0.1),
                  blurRadius: 2,
                  color: Color.fromARGB(63, 0, 0, 0),
                ),
                Shadow(
                  offset: Offset(0.1, 0.1),
                  blurRadius: 3,
                  color: Color.fromARGB(31, 0, 0, 0),
                ),
                Shadow(
                  offset: Offset(0.1, 0.1),
                  blurRadius: 4,
                  color: Color.fromARGB(1, 0, 0, 0),
                )
              ],
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        Text(
          'Medical',
          style: textStyle,
          textAlign: TextAlign.right,
        ),
        Text(
          'Assistant',
          style: textStyle,
          textAlign: TextAlign.right,
        ),
        Text(
          'System',
          style: textStyle,
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
