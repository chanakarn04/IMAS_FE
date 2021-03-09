import 'package:flutter/material.dart';
import 'package:homepage_proto/Widget/predResDisease.dart';

import '../Models/disease.dart';
import '../Models/diseaseAPI.dart';
import '../Models/symptom.dart';
import '../Widget/sideDrawer.dart';
import '../Widget/predResSymptom.dart';
import '../Widget/AdaptiveRaisedButton.dart';
import '../Widget/adaptiveBorderButton.dart';

class PredictionResultPage extends StatefulWidget {
  static const routeName = '/prediction-result';

  @override
  _PredictionResultPageState createState() => _PredictionResultPageState();
}

class _PredictionResultPageState extends State<PredictionResultPage> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  bool isHistory = false;
  bool isMeetDoctor = false;

  final List<Symptom> detectedSymtomList = [
    Symptom('s001', 'Head drop'),
    Symptom('s002', 'Head tilt in order to avoid diplopia'),
    Symptom('s003', 'Head tremors'),
    Symptom('s004', 'Headache'),
  ];

  final List<Disease> detectedDisease = [
    Disease(
      id: 'D001',
      name: 'Tension Headache',
      description:
          'Pain associated with muscle used and working. pain seem to be aggravated over the day and can relieved by rest.',
      treatment: ['Medication', 'Rest'],
      cause:
          'Tension headaches are caused by muscle contractions in the head and neck regions. These types of contractions can be caused by a variety of foods, activities and stressors. Some people develop tension headaches after staring at a computer screen for a long time or after driving for long periods. Cold temperatures may also trigger a tension headache.',
    ),
    Disease(
      id: 'D001',
      name: 'Tension Headache',
      description:
          'Pain associated with muscle used and working. pain seem to be aggravated over the day and can relieved by rest.',
      treatment: ['Medication', 'Rest'],
      cause:
          'Tension headaches are caused by muscle contractions in the head and neck regions. These types of contractions can be caused by a variety of foods, activities and stressors. Some people develop tension headaches after staring at a computer screen for a long time or after driving for long periods. Cold temperatures may also trigger a tension headache.',
    )
  ];
  final List<DiseaseAPI> detectedDiseaseAPI = [
    DiseaseAPI(
        id: 'D001',
        name: 'Some Science Tension Headache',
        commonName: 'Tension Headache',
        sexFilter: 'both',
        categories: ['HeadoThology'],
        prevalence: 'common',
        acuteness: 'acute',
        severity: 'mild',
        extras: {}),
    DiseaseAPI(
        id: 'D001',
        name: 'Some Science Tension Headache',
        commonName: 'Tension Headache',
        sexFilter: 'both',
        categories: ['HeadoThology'],
        prevalence: 'common',
        acuteness: 'acute',
        severity: 'mild',
        extras: {}),
  ];

  @override
  Widget build(BuildContext context) {
    final routeArgument =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    isHistory = routeArgument['isHistory'];
    isMeetDoctor = routeArgument['isMeetDoctor'];
    return Scaffold(
      key: _scaffoldState,
      endDrawer: SideDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pop()),
        title: Container(
          alignment: Alignment.center,
          child: Text('Prediction'),
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
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              PredResSymptom(detectedSymtomList),
              PredResDisease(detectedDisease, detectedDiseaseAPI),
              !isHistory
                  ? isMeetDoctor
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AdaptiveRaisedButton(
                              buttonText: 'Meet Doctor',
                              handlerFn: () {
                                print('Go to wait doctor');
                              },
                              height: 35,
                              width: 170,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AdaptiveBorderButton(
                                  buttonText: 'Home',
                                  handlerFn: () {
                                    // print('Home');
                                    Navigator.of(context)
                                        .popUntil(ModalRoute.withName('/home'));
                                  },
                                  height: 45,
                                  width: 180,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                AdaptiveBorderButton(
                                  buttonText: 'Nearby Hospital',
                                  handlerFn: () {
                                    print('Go to nearby Hospital');
                                  },
                                  height: 45,
                                  width: 180,
                                ),
                              ],
                            ),
                          ],
                        )
                      : AdaptiveRaisedButton(
                          buttonText: 'Home',
                          handlerFn: () {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName('/home'));
                          },
                          height: 35,
                          width: 160,
                        )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
