import 'package:flutter/material.dart';

import './assessmentPages.dart';
import './answerQuestionPages.dart';
import '../Widget/adaptiveBorderButton.dart';
import '../Widget/AdaptiveRaisedButton.dart';

class AddMoreSymptom extends StatelessWidget {
  static const routeName = '/assessment-addMore';

  @override
  Widget build(BuildContext context) {
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
          onPressed: null,
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.035,
                      child: FittedBox(
                        child: Text(
                          'Add another symptom?',
                        ),
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
                // color: Colors.amber[200],
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      AdaptiveRaisedButton(
                        buttonText: 'Yes',
                        height: 30,
                        width: 170,
                        handlerFn: () {
                          Navigator.of(context).popUntil(ModalRoute.withName(AssessmentPages.routeName));
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      AdaptiveBorderButton(
                        buttonText: 'No',
                        height: 40,
                        width: 180,
                        handlerFn: () {
                          Navigator.of(context).pushNamed(AnswerQuestionPages.routeName);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
      ),
    );
  }
}