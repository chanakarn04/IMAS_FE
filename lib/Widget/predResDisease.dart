import 'package:flutter/material.dart';

import '../Models/disease.dart';
import '../Models/diseaseAPI.dart';
import '../Widget/diseaseCard.dart';

class PredResDisease extends StatelessWidget {
  final List<Disease> detectedDisease;
  final List<DiseaseAPI> detectedDiseaseAPI;

  PredResDisease(
    this.detectedDisease,
    this.detectedDiseaseAPI,
  );

  @override
  Widget build(BuildContext context) {
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
          height: (detectedDisease.length * 200).toDouble(),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return DiseaseCard(
                name: detectedDisease[index].name,
                description: detectedDisease[index].description,
                servere: detectedDiseaseAPI[index].severity,
              );
            },
            itemCount: detectedDisease.length,
          ),
        )
      ],
    );
  }
}
