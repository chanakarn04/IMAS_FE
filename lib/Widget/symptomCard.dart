import 'package:flutter/material.dart';

import '../Models/symptom.dart';

class SymptomCard extends StatelessWidget {
  final List<Symptom> symptomList;

  SymptomCard(this.symptomList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 2,
          ),
          // height: MediaQuery.of(context).size.height * 0.12,
          child: Card(
              elevation: 8,
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: FlatButton(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.02,
                            child: FittedBox(
                              child: Text(
                                'Select symptom',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            print('Hiya!');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
      itemCount: symptomList.length,
    );
  }
}
