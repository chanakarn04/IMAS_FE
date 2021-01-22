import 'package:flutter/material.dart';

import '../Widget/adaptiveBorderButton.dart';
import '../Models/disease.dart';
import '../Pages/diseaseDetail.dart';

class DiseaseCard extends StatelessWidget {
  // final String name;
  // final String description;
  final Disease disease;
  final String servere;

  DiseaseCard({
    // @required this.name,
    // @required this.description,
    @required this.disease,
    @required this.servere,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 180,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              disease.name,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                '\t\t\t\t' + disease.description,
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
                  Text(
                    'Servere: ${servere}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 25,
                    ),
                  ),
                  AdaptiveBorderButton(
                    buttonText: 'Detail',
                    height: 25,
                    width: 120,
                    handlerFn: () {
                      Navigator.of(context).pushNamed(
                          DiseaseDetailPages.routeName,
                          arguments: disease);
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
