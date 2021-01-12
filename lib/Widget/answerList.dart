import 'package:flutter/material.dart';

class AnswerList extends StatelessWidget {
  final List<String> answerList;

  AnswerList(this.answerList);

  @override
  Widget build(BuildContext context) {
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
            child: FlatButton(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.03,
                child: FittedBox(
                  child: Text(
                    answerList[index],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                print('Select ${answerList[index]}');
              },
            ),
          ),
        );
      },
      itemCount: answerList.length,
    );
  }
}
