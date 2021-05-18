import 'package:flutter/material.dart';

class PredResPatientInfo extends StatelessWidget {
  final String gender;
  final int age;
  // final List<Disease> detectedDisease;
  // final List<DiseaseAPI> detectedDiseaseAPI;

  PredResPatientInfo(
    this.gender,
    this.age,
    // this.detectedDisease,
    // this.detectedDiseaseAPI,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            'Patient Infomation',
            style: TextStyle(
              fontSize: 20,
              // fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Container(
          // color: Colors.teal,
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          // color: Colors.teal[100],
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      'Age',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      'Gender',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      '$age',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      gender,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}