import 'package:flutter/material.dart';

import '../Widget/adaptiveBorderButton.dart';
import '../Models/disease.dart';
import '../Pages/diseaseDetail.dart';

class DiseaseCard extends StatelessWidget {
  final String conditionID;
  final String name;
  final String description;
  // final Disease disease;
  // final String servere;

  DiseaseCard({
    @required this.conditionID,
    @required this.name,
    @required this.description,
    // @required this.disease,
    // @required this.servere,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Theme.of(context).primaryColor,
        //       Theme.of(context).accentColor,
        //     ],
        //   ),
        // ),
        height: 180,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                // color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                '\t\t\t\t' + description,
                style: TextStyle(
                  color: Color.fromARGB(255, 75, 75, 75),
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(child: Container()),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 25,
                    ),
                  ),
                  // FlatButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pushNamed(
                  //         DiseaseDetailPages.routeName,
                  //         arguments: disease);
                  //   },
                  //   child: Text(
                  //     'Detail',
                  //     style: TextStyle(
                  //       color: Theme.of(context).primaryColor,
                  //       color: Colors.white,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  // )
                  AdaptiveBorderButton(
                    buttonText: 'Detail',
                    height: 25,
                    width: 120,
                    handlerFn: () {
                      Navigator.of(context).pushNamed(
                          DiseaseDetailPages.routeName,
                          arguments: conditionID);
                      // print('to disease detail');
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
