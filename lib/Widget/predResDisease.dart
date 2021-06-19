import 'package:flutter/material.dart';

class PredResDisease extends StatelessWidget {
  final List<dynamic> conditions;

  PredResDisease(this.conditions);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            'Detected diseases',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: (conditions.length * 25).toDouble(),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(0),
            itemBuilder: (ctx, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          '${conditions[index]['common_name']}',
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: const TextStyle(fontSize: 18),
                        ),
                    ),
                  ],
                ),
              );
            },
            itemCount: conditions.length,
          ),
        )
      ],
    );
  }
}
