import 'package:flutter/material.dart';

class PredResSymptom extends StatelessWidget {
  final List<dynamic> symptomList;

  PredResSymptom(this.symptomList);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            'Detected symptom',
            style: TextStyle(
              fontSize: 20,
              // fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        // Text(
        //   '\u2022 ${symptomList[0]}',
        // ),
        Container(
          padding: EdgeInsets.only(
            left: 15,
          ),
          // color: Colors.teal[100],
          alignment: Alignment.center,
          height: (symptomList.length * 27).toDouble(),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(0),
            itemBuilder: (ctx, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  '${symptomList[index]}',
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              );
            },
            itemCount: symptomList.length,
          ),
        ),
      ],
    );
  }
}
