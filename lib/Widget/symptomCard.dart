import 'package:flutter/material.dart';

import './adaptiveBorderButton.dart';
import '../Models/symptom.dart';

class SymptomCard extends StatelessWidget {
  final List<Symptom> symptomList;
  final Function selectSymptomHandler;

  SymptomCard(this.symptomList, this.selectSymptomHandler);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color.fromARGB(125, 75, 75, 75),
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      // padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: FittedBox(
                          // fit: BoxFit.fitHeight,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            symptomList[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AdaptiveBorderButton(
                        'Select symptom', 0.02, selectSymptomHandler)
                  ],
                ),
              )),
        );
      },
      itemCount: symptomList.length,
    );
  }
}