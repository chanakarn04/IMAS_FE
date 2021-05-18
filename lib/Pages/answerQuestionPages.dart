import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/answerList.dart';
import '../Provider/symptomAssessment.dart';
import '../Pages/homePages.dart';
import '../Pages/predictionResultPage.dart';

// import '../Widget/adaptiveBorderButton.dart';

class AnswerQuestionPages extends StatefulWidget {
  static const routeName = '/QuestionSymptom';

  @override
  _AnswerQuestionPagesState createState() => _AnswerQuestionPagesState();
}

class _AnswerQuestionPagesState extends State<AnswerQuestionPages> {
  var _loadedData = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final symptomAssessment = Provider.of<SymptomAssessmentProvider>(context);
    if (!_loadedData) {
      print('_loadedData: $_loadedData');
      symptomAssessment.sendDiagnostic();
      _loadedData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final symptomAssessment = Provider.of<SymptomAssessmentProvider>(context);

    // final routeArgument =
    //     ModalRoute.of(context).settings.arguments as Map<String, Object>;
    // final Map<dynamic, dynamic> diagnosisData =
    //     symptomAssessment.diagnosticData;
    // final String question = diagnosisData['question']['text'];
    // final List<dynamic> choices_items = diagnosisData['question']['items'];
    // final bool last_word = diagnosisData['should_stop'];
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
            // symptomAssessment.conditions = [
            //   {
            //     "id": "c_255",
            //     "name": "Tetanus",
            //     "common_name": "Tetanus",
            //     "probability": 0.3118,
            //     "condition_details": {
            //       "icd10_code": "A35",
            //       "category": {"id": "cc_16", "name": "Infectiology"},
            //       "prevalence": "very_rare",
            //       "severity": "severe",
            //       "acuteness": "acute",
            //       "triage_level": "emergency_ambulance",
            //       "hint":
            //           "You may need urgent medical attention! Call an ambulance."
            //     }
            //   },
            // ];
            Navigator.of(context)
                .popUntil(ModalRoute.withName(HomePage.routeName));
            Navigator.of(context)
                .pushNamed(PredictionResultPage.routeName, arguments: {
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
          child: (symptomAssessment.diagnosticLoading)
          // child: (false)
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                )
              : Column(
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
                          Container(
                            child: Text(
                              // 'question',
                              symptomAssessment.diagnosticData['question']
                                  ['text'],
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
                        child: AnswerList(
                          symptomAssessment.diagnosticData['question']['items']
                              [0],
                          symptomAssessment.diagnosticData['should_stop'],
                        ),
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
