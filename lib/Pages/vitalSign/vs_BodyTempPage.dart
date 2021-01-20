import 'package:flutter/material.dart';

import '../../Widget/numberTextInput.dart';
import '../../Widget/progress4Dot.dart';
import '../../Widget/AdaptiveRaisedButton.dart';
import './vs_HeartRatePage.dart';

class VSBodyTempPage extends StatelessWidget {
  static const routeName = '/vitalSign-bodyTemp';
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
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
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
    final routeArgument =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
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
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.6,
              padding: EdgeInsets.only(
                top: 120,
                left: 15,
                right: 15,
                bottom: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _headerBuilder(context, 'Body Temperature'),
                  SizedBox(
                    height: 20,
                  ),
                  _descriptionBuilder(context,
                      'Use thermometer to measure yourself and select your temperature'),
                ],
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.4,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 120,
                        child: NumberTextField(
                          textController: textController,
                        ),
                      ),
                      Text(
                        '°C',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ProgressDot4(1),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AdaptiveRaisedButton(
                      buttonText: 'Next',
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.35,
                      handlerFn:
                          (double.tryParse(textController.text) != null) &&
                                  (textController.text.isNotEmpty)
                              ? (() {
                                  routeArgument['temp'] =
                                      double.parse(textController.text);
                                  Navigator.of(context).pushNamed(
                                      VSHeartRatePage.routeName,
                                      arguments: routeArgument);
                                })
                              : null,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
