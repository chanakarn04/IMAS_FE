import 'package:flutter/material.dart';
import 'package:homepage_proto/Widget/answerList.dart';

// import '../Widget/adaptiveBorderButton.dart';

class AnswerQuestionPages extends StatelessWidget {
  final String symptom = 'Headache';
  final String question = 'What is your pain charateristic?';
  final List<String> answerList = [
    'Stabbing',
    'Squeezing',
    'Throbbing',
    'Mixed',
  ];

  // AnswerQuestionPages({
  //   @required this.symptom,
  //   @required this.question,
  //   @required this.answerList,
  // })

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
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: FittedBox(
                        child: Text(
                          symptom,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.035,
                      child: FittedBox(
                        child: Text(
                          question,
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
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AnswerList(answerList),
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
