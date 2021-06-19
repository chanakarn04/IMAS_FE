import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/vitalSign_Info.dart';
import '../Provider/chatRoom_info.dart';
import '../Widget/adaptiveRaisedButton.dart';
import '../Widget/customSliderThumbCircle.dart';
import './homePages.dart';
import './WaitingDoctor.dart';

class PainScorePage extends StatefulWidget {
  static const routeName = '/painScore';

  @override
  _PainScorePageState createState() => _PainScorePageState();
}

class _PainScorePageState extends State<PainScorePage> {
  double value = 0;

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
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
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
    final routeArg = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final vitalSign = Provider.of<VitalSignProvider>(context, listen: false);
    final chatroomProvider = Provider.of<ChatRoomProvider>(context, listen: false);
    int index = routeArg['index'];
    List<dynamic> symptoms = vitalSign.symptoms;
    Map<String, int> painScore = routeArg['painScore'];
    final appBar = AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.transparent,
        ),
        onPressed: () {},
      ),
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
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
                    _headerBuilder(context, (symptoms.isNotEmpty) ? symptoms[index] : ''),
                    SizedBox(height: 20),
                    _descriptionBuilder(context, 'Determine your pain score from 0 to 10 (No effect to Can\'t stand)'),
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
                          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Colors.white,
                                tickMarkShape: RoundSliderTickMarkShape(),
                                activeTickMarkColor: Colors.white,
                                inactiveTickMarkColor: Colors.white.withAlpha(100),
                                thumbColor: Theme.of(context).primaryColor,
                                showValueIndicator: ShowValueIndicator.never,
                                trackShape: RoundedRectSliderTrackShape(),
                                trackHeight: 50 / 6,
                                thumbShape: CustomSliderThumbCircle(thumbRadius: 50 / 2.5, max: 10, min: 0),
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
                          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
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
                    SizedBox(height: 45),
                    Align(
                      alignment: Alignment.center,
                      child: AdaptiveRaisedButton(
                          buttonText: (index < (symptoms.length - 1))
                              ? 'Next'
                              : 'Submit',
                          height: 35,
                          width: MediaQuery.of(context).size.width * 0.35,
                          handlerFn: () async {
                            if (index < (symptoms.length - 1)) {
                              vitalSign.painScore[symptoms[index]] = value;
                              Navigator.of(context).pushNamed(
                                  PainScorePage.routeName,
                                  arguments: {
                                    'index': index + 1,
                                    'symptom': symptoms,
                                    'painScore': painScore,
                                  });
                            } else {
                              vitalSign.painScore['${symptoms[index]}'] = value.round();
                              await vitalSign.saveVsPs();
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    title: Text('Submit Data successfully'),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () async {
                                          Future.delayed(Duration.zero, () {
                                            Navigator.of(context).popUntil(ModalRoute.withName(HomePage.routeName));
                                            if (chatroomProvider.online) {
                                              Navigator.of(context).pushNamed(WaitingPage.routeName);
                                            }
                                          });
                                          vitalSign.clear();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }),
                    )
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
