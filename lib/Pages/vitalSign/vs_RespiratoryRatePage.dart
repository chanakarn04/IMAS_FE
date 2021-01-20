import 'package:flutter/material.dart';

import '../../Widget/numberTextInput.dart';
import '../../Widget/adaptiveRaisedButton.dart';
import '../../Widget/progress4Dot.dart';
import './vs_BloodPressurePage.dart';

class VSRespiratoryRatePage extends StatelessWidget {
  static const routeName = '/vitalSign-breath';
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
          children: [
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
                  _headerBuilder(context, 'Respiratory rate'),
                  SizedBox(
                    height: 20,
                  ),
                  _descriptionBuilder(
                      context, 'Count how many time you breath in 60 seconds'),
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
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ProgressDot4(3),
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
                                  routeArgument['breath'] =
                                      double.parse(textController.text);
                                  Navigator.of(context).pushNamed(
                                      VSBloodPressurePage.routeName,
                                      arguments: routeArgument);
                                })
                              : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Center(
      //   // color: Colors.white,
      //   child: Column(
      //     children: [
      //       Text('Respiratory'),

      //     ],
      //   ),
      // ),
    );
  }
}
