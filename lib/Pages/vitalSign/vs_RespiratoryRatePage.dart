import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/vitalSign_Info.dart';
import '../../Widget/numberTextInput.dart';
import '../../Widget/adaptiveRaisedButton.dart';
import '../../Widget/adaptiveBorderButton.dart';
import '../../Widget/progressDot.dart';
import './vs_BloodPressurePage.dart';

class VSRespiratoryRatePage extends StatefulWidget {
  static const routeName = '/vitalSign-breath';

  @override
  _VSRespiratoryRatePageState createState() => _VSRespiratoryRatePageState();
}

class _VSRespiratoryRatePageState extends State<VSRespiratoryRatePage> {
  final textController = TextEditingController();
  var _loadedData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedData) {
      final _vitalSign = Provider.of<VitalSignProvider>(context);
      if (_vitalSign.breath != null) {
        textController.text = _vitalSign.breath.toString();
      }
      _loadedData = true;
    }
    super.didChangeDependencies();
  }

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
    // final routeArgument =
    //     ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final vitalSign = Provider.of<VitalSignProvider>(context);
    final appBar = AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      // leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios_rounded),
      //     onPressed: () => Navigator.of(context).pop()),
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                        SizedBox(
                          width: 3,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'BPM',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '(Breath Per Minute)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 9,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ProgressDot(
                        length: 4,
                        markedIndex: 3,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AdaptiveBorderButton(
                          buttonText: 'Skip',
                          height: 45,
                          width: 125,
                          handlerFn: () {
                            vitalSign.breath = null;
                            Navigator.of(context).pushNamed(
                              VSBloodPressurePage.routeName,
                            );
                            // routeArgument['breath'] = null;
                            // Navigator.of(context).pushNamed(
                            //     VSBloodPressurePage.routeName,
                            //     arguments: routeArgument);
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        AdaptiveRaisedButton(
                          buttonText: 'Next',
                          height: 35,
                          width: 125,
                          handlerFn:
                              (double.tryParse(textController.text) != null) &&
                                      (textController.text.isNotEmpty)
                                  ? (() {
                                      vitalSign.breath =
                                          double.parse(textController.text);
                                      Navigator.of(context).pushNamed(
                                        VSBloodPressurePage.routeName,
                                      );
                                    })
                                  : null,
                        ),
                      ],
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
      ),
    );
  }
}
