import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/vitalSign_Info.dart';
import '../../Widget/numberTextInput.dart';
import '../../Widget/progressDot.dart';
import '../../Widget/AdaptiveRaisedButton.dart';
import './vs_RespiratoryRatePage.dart';

class VSHeartRatePage extends StatefulWidget {
  static const routeName = '/vitalSign-pulse';

  @override
  _VSHeartRatePageState createState() => _VSHeartRatePageState();
}

class _VSHeartRatePageState extends State<VSHeartRatePage> {
  final textController = TextEditingController();
  var _loadedData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedData) {
      final _vitalSign = Provider.of<VitalSignProvider>(context);
      if (_vitalSign.pulse != null) {
        textController.text = _vitalSign.pulse.toString();
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
    final vitalSign = Provider.of<VitalSignProvider>(context);

    if (vitalSign.pulse != null) {
      textController.text = vitalSign.pulse.toString();
    }

    final appBar = AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
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
                        MediaQuery.of(context).padding.top) * 0.6,
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
                    _headerBuilder(context, 'Heart rate'),
                    SizedBox(height: 20),
                    _descriptionBuilder(context, 'Place your pointer and middle fingers on the inside of your opposite wrist just below the thumb. Once you can feel your pulse, count how many beats you feel in 60 second'),
                  ],
                ),
              ),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) * 0.4,
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
                        SizedBox(height: 3),
                        Column(
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
                              '(Beat Per Minute)',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 9),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.center,
                      child: ProgressDot(
                        length: 4,
                        markedIndex: 2,
                      ),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.center,
                      child: AdaptiveRaisedButton(
                        buttonText: 'Next',
                        height: 35,
                        width: 125,
                        handlerFn:
                            (double.tryParse(textController.text) != null) && (textController.text.isNotEmpty)
                                ? (() {
                                    vitalSign.pulse = double.parse(textController.text);
                                    Navigator.of(context).pushNamed(VSRespiratoryRatePage.routeName);
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
      ),
    );
  }
}
