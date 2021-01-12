import 'package:flutter/material.dart';

class AnswerQuestionPages extends StatelessWidget {
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
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                child: FittedBox(
                  child: Text(
                    'Headache',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Text('What is your pain charateristic?'),
            ],
          )
        ],
      ),
    );
  }
}
