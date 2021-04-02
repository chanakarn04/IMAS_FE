import 'package:flutter/material.dart';

import '../Widget/diseaseCard.dart';

class PredResDisease extends StatelessWidget {
  final List<Map<String, dynamic>> conditions;
  // final List<Disease> detectedDisease;
  // final List<DiseaseAPI> detectedDiseaseAPI;

  PredResDisease(this.conditions
      // this.detectedDisease,
      // this.detectedDiseaseAPI,
      );

  @override
  Widget build(BuildContext context) {
    print(conditions.length);
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Text(
                'Disease',
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
          // color: Colors.teal,
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          // color: Colors.teal[100],
          height: (conditions.length * 200).toDouble(),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return DiseaseCard(
                conditionID: conditions[index]['id'],
                name: conditions[index]['common_name'],
                description: conditions[index]['description'],
              );
            },
            itemCount: conditions.length,
          ),
        )
      ],
    );
  }
}
