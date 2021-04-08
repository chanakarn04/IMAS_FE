import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './adaptiveBorderButton.dart';
import '../Provider/symptomAssessment.dart';
import '../Pages/as_addMoreSymptom.dart';
// import '../Models/symptom.dart';

class SymptomCard extends StatelessWidget {
  final List<Map<String, dynamic>> symptomList;
  // final Function selectSymptomHandler;

  SymptomCard(this.symptomList);

  @override
  Widget build(BuildContext context) {
    final symptomAssessment = Provider.of<SymptomAssessmentProvider>(context, listen: false);
    return symptomList.isEmpty
        ? Center(
            child: FittedBox(
              child: Text('No result'),
            ),
          )
        : ListView.builder(
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
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: FittedBox(
                                // fit: BoxFit.fitHeight,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  symptomList[index]['label'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: AdaptiveBorderButton(
                              buttonText: 'Select symptom',
                              height: 40,
                              width: 150,
                              handlerFn: () {
                                symptomAssessment.addEvidence(
                                  {
                                    'id': symptomList[index]['id'],
                                    'choice_id': 'present',
                                    'source': 'initial',
                                  }
                                );
                                Navigator.of(context).pushNamed(AddMoreSymptom.routeName);                 
                              },
                            ),
                          )
                        ],
                      ),
                    )),
              );
            },
            itemCount: symptomList.length,
          );
  }
}
