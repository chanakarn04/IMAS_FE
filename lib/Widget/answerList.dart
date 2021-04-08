import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/symptomAssessment.dart';
import '../Pages/answerQuestionPages.dart';
import '../Pages/homePages.dart';
import '../Pages/predictionResultPage.dart';

class AnswerList extends StatelessWidget {
  final Map<String, dynamic> choices_items;
  final bool last_word;

  AnswerList(this.choices_items, this.last_word);

  @override
  Widget build(BuildContext context) {
    final symptomAssessment = Provider.of<SymptomAssessmentProvider>(context, listen: false);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, index) {
        return Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(7),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: TextButton(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.03,
                child: FittedBox(
                  child: Text(
                    // answerList[index],
                    choices_items['choices'][index]['label'],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                // print('Select ${answerList[index]}');
                symptomAssessment.addEvidence({
                  'id': choices_items['id'],
                  'choice_id': choices_items['choices'][index]['id'],
                  // 'source': ,
                });
                print('<<<<<<<<<< >>>>>>>>>>');
                for (Map<String, dynamic> map in symptomAssessment.evidence) {
                  print('${map['id']}: ${map['choice_id']}');
                }
                if (!last_word) {
                  Navigator.of(context).pushReplacementNamed(AnswerQuestionPages.routeName);
                  // Navigator.of(context).popAndPushNamed(AnswerQuestionPages.routeName);
                  // Navigator.pop(
                  //   context,
                  //   PageRouteBuilder(
                  //     pageBuilder: (_, __, ___) => Screen2(),
                  //     transitionDuration: Duration(seconds: 0),
                  //   ),
                  // );
                } else {
                  Navigator.of(context).popUntil(ModalRoute.withName(HomePage.routeName));
                  Navigator.of(context).pushNamed(PredictionResultPage.routeName);
                }
              },
            ),
          ),
        );
      },
      itemCount: choices_items['choices'].length,
    );
  }
}
