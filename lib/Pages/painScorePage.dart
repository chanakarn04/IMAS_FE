import 'package:flutter/material.dart';

import '../Widget/AdaptiveRaisedButton.dart';
// import '../Widget/PainScoreSlider.dart';
import '../Widget/customSliderThumbCircle.dart';

class PainScorePage extends StatefulWidget {
  static const routeName = '/painScore';
  // final double value;

  @override
  _PainScorePageState createState() => _PainScorePageState();
}

class _PainScorePageState extends State<PainScorePage> {
  double value = 0;

  void _uploadData(
    Map<String, int> painScore,
    // ... use something more
  ) {
    // upload painScore

    // temp
    painScore.forEach((key, value) {
      print('$key : $value');
    });
  }

  Widget _headerBuilder(
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

  Widget _descriptionBuilder(
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
    final routeArg =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    int index = routeArg['index'];
    List<String> symptoms = routeArg['symptom'];
    Map<String, int> painScore = routeArg['painScore'];
    // print(routeArg['symptom']);
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
                  _headerBuilder(context, symptoms[index]),
                  SizedBox(
                    height: 20,
                  ),
                  _descriptionBuilder(context,
                      'Determine your pain score from 0 to 10 (No effect to Can\'t stand)'),
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
                  // PainScoreSlider(
                  //   value: this.widget.value,
                  // ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.lightBlue[200],
                          Colors.teal[300],
                          Colors.green[400],
                          Colors.yellow,
                          Colors.amber,
                          Colors.orange,
                          Colors.red[700],
                        ],
                        stops: [0.05, 0.2, 0.3, 0.55, 0.7, 0.80, 0.95],
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          0.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50 * .4,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Colors.white,
                              tickMarkShape: RoundSliderTickMarkShape(),
                              activeTickMarkColor: Colors.white,
                              inactiveTickMarkColor:
                                  Colors.white.withAlpha(100),
                              thumbColor: Theme.of(context).primaryColor,
                              showValueIndicator: ShowValueIndicator.never,
                              trackShape: RoundedRectSliderTrackShape(),
                              trackHeight: 50 / 6,
                              thumbShape: CustomSliderThumbCircle(
                                  thumbRadius: 50 / 2.5, max: 10, min: 0),
                            ),
                            child: Slider(
                              min: 0.toDouble(),
                              max: 10.toDouble(),
                              divisions: 10,
                              value: value,
                              label: value.round().toString(),
                              onChanged: (sldvalue) {
                                setState(() {
                                  value = sldvalue;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          10.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50 * .4,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AdaptiveRaisedButton(
                        buttonText:
                            (index < (symptoms.length - 1)) ? 'Next' : 'Submit',
                        height: 35,
                        width: MediaQuery.of(context).size.width * 0.35,
                        handlerFn: () {
                          if (index < (symptoms.length - 1)) {
                            painScore[symptoms[index]] = value.toInt();
                            Navigator.of(context)
                                .pushNamed(PainScorePage.routeName, arguments: {
                              'index': index + 1,
                              'symptom': symptoms,
                              'painScore': painScore,
                            });
                          } else {
                            painScore[symptoms[index]] = value.toInt();
                            // ... uploadData to server
                            _uploadData(painScore);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  title: Text('Submit Data successfully'),
                                  actions: [
                                    FlatButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).popUntil(
                                            ModalRoute.withName('/home'));
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          // print('blank');
                          // print(PainScoreSlider.value)
                          // print(value.toString());
                        }),
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
