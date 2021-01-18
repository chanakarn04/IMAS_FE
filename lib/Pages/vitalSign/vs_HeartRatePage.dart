import 'package:flutter/material.dart';

import '../../Widget/progress4Dot.dart';
import '../../Widget/AdaptiveRaisedButton.dart';

class VSHeartRatePage extends StatelessWidget {
  final textController = TextEditingController();

  _headerBuilder(
    BuildContext context,
    String header,
  ) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
      child: Text(header,
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.clip),
    );
  }

  _descriptionBuilder(
    BuildContext context,
    String description,
  ) {
    return Align(
      alignment: Alignment.centerRight,
      // color: Colors.deepPurple,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.95),
        child: Text(
          description,
          style: TextStyle(
            color: Color.fromARGB(255, 75, 75, 75),
            fontSize: 18,
          ),
          textAlign: TextAlign.end,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }

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
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.teal,
          height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top),
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _headerBuilder(context, 'Heart rate'),
              SizedBox(
                height: 20,
              ),
              _descriptionBuilder(context,
                  'Place your pointer and middle fingers on the inside of your opposite wrist just below the thumb. Once you can feel your pulse, count how many beats you feel in 60 second'),
              SizedBox(
                height: 120,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 120,
                    child: TextField(
                      controller: textController,
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Type here',
                        contentPadding: EdgeInsets.only(right: 15),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ProgressDot4(2),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: AdaptiveRaisedButton(
                  buttonText: 'Next',
                  height: 35,
                  width: MediaQuery.of(context).size.width * 0.35,
                  handlerFn: (() {
                    print('to Respiratory');
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
