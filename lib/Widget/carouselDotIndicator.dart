import 'package:flutter/material.dart';

class CarouselDotIndicator extends StatelessWidget {
  final int length;
  final int ctrlIndex;

  CarouselDotIndicator({
    @required this.length,
    @required this.ctrlIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber[200],
      height: 16,
      width: length * 20.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: 16,
            width: 16,
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (ctrlIndex == index)
                  ? Theme.of(context).primaryColorLight
                  : Colors.white54,
            ),
          );
        },
        itemCount: length,
      ),
    );
  }
}
