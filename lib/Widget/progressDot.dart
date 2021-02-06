import 'package:flutter/material.dart';

class ProgressDot extends StatelessWidget {
  final int length;
  final int markedIndex;

  ProgressDot({
    this.length,
    this.markedIndex,
  });

  List<Widget> buildDot(
    BuildContext context,
    int index,
    int markedIndex,
  ) {
    return [
      Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (markedIndex == index)
              ? Theme.of(context).primaryColor
              : Color.fromARGB(100, 75, 75, 75),
        ),
      ),
      SizedBox(
        width: 7,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 19 * length.toDouble(),
      height: 12,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            children: <Widget>[
              ...buildDot(context, index, markedIndex - 1),
            ],
          );
        },
        itemCount: length,
      ),
    );
  }
}
