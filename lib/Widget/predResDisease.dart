import 'package:flutter/material.dart';
import '../Pages/diseaseDetail.dart';

class PredResDisease extends StatelessWidget {
  final List<dynamic> conditions;
  // final List<Disease> detectedDisease;
  // final List<DiseaseAPI> detectedDiseaseAPI;

  PredResDisease(this.conditions
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
            'Detected diseases',
            style: TextStyle(
              fontSize: 20,
              // fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          // color: Colors.teal[100],
          height: (conditions.length * 25).toDouble(),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(0),
            itemBuilder: (ctx, index) {
              return Container(
                // color: Colors.red[50],
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          '${conditions[index]['common_name']}',
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                    ),
                    // Container(
                    //   // color: Colors.pink[200],
                    //   width: MediaQuery.of(context).size.width * 0.5,
                    //   child: 
                    // ),
                    // Expanded(child: Container()),
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
