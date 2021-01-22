import 'package:flutter/material.dart';

import '../Models/symptom.dart';

class PredResSymptom extends StatelessWidget {
  final List<Symptom> symptomList;

  PredResSymptom(this.symptomList);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Text(
                'Symptom',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  color: Colors.black,
                  height: 2,
                ),
              ),
            ],
          ),
        ),
        // Text(
        //   '\u2022 ${symptomList[0]}',
        // ),
        Container(
          padding: EdgeInsets.only(
            left: 40,
          ),
          // color: Colors.teal[100],
          height: (symptomList.length * 22).toDouble(),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return Text(
                '\u2022 ${symptomList[index].name}',
                style: const TextStyle(
                  fontSize: 18,
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
