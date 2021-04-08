import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/answerList.dart';
import '../Provider/symptomAssessment.dart';
import '../Pages/homePages.dart';
import '../Pages/predictionResultPage.dart';

// import '../Widget/adaptiveBorderButton.dart';

class AnswerQuestionPages extends StatelessWidget {
  static const routeName = '/QuestionSymptom';
  // String symptom;
  // String question;
  // final List<String> answerList = [
  //   'Stabbing',
  //   'Squeezing',
  //   'Throbbing',
  //   'Mixed',
  // ];

  // @override
  // void didChangeDependencies() {
  //   print(phrase);
  //   if (!_loadedData) {
  //     phrase = ModalRoute.of(context).settings.arguments as String;
  //     _symptomController.text = phrase;
  //     _loadedData = true;
  //   }
  //   super.didChangeDependencies();
  // }

  // AnswerQuestionPages({
  //   @required this.symptom,
  //   @required this.question,
  //   @required this.answerList,
  // })

  @override
  Widget build(BuildContext context) {
    final symptomAssessment = Provider.of<SymptomAssessmentProvider>(context, listen: false);
    // final routeArgument =
    //     ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final Map<String, dynamic> diagnosisData = symptomAssessment.sendDiagnostic();
    final String question = diagnosisData['question']['text'];
    final List<Map<String, dynamic>> choices_items = diagnosisData['question']['items'];
    final bool last_word = diagnosisData['should_stop'];
    // print(diagnosisData['conditions']);
    final appBar = AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop()),
      title: Container(
        alignment: Alignment.center,
        child: Text('IMAS'),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.menu_rounded,
            color: Colors.transparent,
          ),
          onPressed: () {
            // for test
            // DONT FORGET TO DELETE
            symptomAssessment.conditions = [
              {
                "id": "c_255",
                "name": "Tetanus",
                "common_name": "Tetanus",
                "probability": 0.3118,
                "condition_details": {
                  "icd10_code": "A35",
                  "category": {
                    "id": "cc_16",
                    "name": "Infectiology"
                  },
                  "prevalence": "very_rare",
                  "severity": "severe",
                  "acuteness": "acute",
                  "triage_level": "emergency_ambulance",
                  "hint": "You may need urgent medical attention! Call an ambulance."
                }
              },
            ];
            Navigator.of(context).popUntil(ModalRoute.withName(HomePage.routeName));
            Navigator.of(context).pushNamed(PredictionResultPage.routeName, arguments: {
              'isHistory': false,
            });
          },
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
          // color: Colors.pink,
          padding: EdgeInsets.only(
            bottom: 30,
            top: 10,
            left: 15,
            right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // color: Colors.purple,
            // alignment: Alignment.,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Container(
                    //   height: MediaQuery.of(context).size.height * 0.06,
                    //   child: FittedBox(
                    //     child: Text(
                    //       symptom,
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.035,
                      // height: 60,
                      // color: Colors.amber,
                      // width: ,
                      child: Text(
                        // question,
                        question,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        // overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Align(
                  alignment: Alignment.centerRight,
                  // child: AnswerList(answerList),
                  child: AnswerList(choices_items[0], last_word),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          )
          // AdaptiveBorderButton('Squeezing', 0.025, () {
          //   print('Squeeze');
          // }),
          // AdaptiveBorderButton('Throbbing', 0.025, () {
          //   print('Throb');
          // }),
          // AdaptiveBorderButton('Mixed', 0.025, () {
          //   print('Mix');
          // }),

          ),
    );
  }
}
