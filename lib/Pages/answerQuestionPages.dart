import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/answerList.dart';
import '../Provider/symptomAssessment.dart';
import '../Pages/homePages.dart';
import '../Pages/predictionResultPage.dart';

class AnswerQuestionPages extends StatefulWidget {
  static const routeName = '/QuestionSymptom';

  @override
  _AnswerQuestionPagesState createState() => _AnswerQuestionPagesState();
}

class _AnswerQuestionPagesState extends State<AnswerQuestionPages> {
  var _loadedData = false;

  @override
  void didChangeDependencies() {
    final symptomAssessment = Provider.of<SymptomAssessmentProvider>(context);
    if (!_loadedData) {
      symptomAssessment.sendDiagnostic();
      _loadedData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final symptomAssessment = Provider.of<SymptomAssessmentProvider>(context);

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
          padding: EdgeInsets.only(
            bottom: 30,
            top: 10,
            left: 15,
            right: 10,
          ),
          child: (symptomAssessment.diagnosticLoading)
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              symptomAssessment.diagnosticData['question']
                                  ['text'],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AnswerList(
                          symptomAssessment.diagnosticData['question']['items'][0],
                          symptomAssessment.diagnosticData['should_stop'],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ],
                )
          ),
    );
  }
}
