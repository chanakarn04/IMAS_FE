import 'package:flutter/material.dart';
import 'package:homepage_proto/Widget/predResDisease.dart';

import '../Models/disease.dart';
import '../Models/diseaseAPI.dart';
import '../Models/symptom.dart';
import '../Widget/sideDrawer.dart';
import '../Widget/predResSymptom.dart';
import '../Widget/AdaptiveRaisedButton.dart';

class PredictionResultPage extends StatefulWidget {
  static const routeName = '/prediction-result';

  @override
  _PredictionResultPageState createState() => _PredictionResultPageState();
}

class _PredictionResultPageState extends State<PredictionResultPage> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  bool isHistory = false;
  bool isMeetDoctor = true;

  final List<Symptom> symptomList = [
    Symptom('s001', 'Headache'),
    Symptom('s002', 'Hedgehog'),
    Symptom('s003', 'Headlight'),
    Symptom('s004', 'HeadQuarter'),
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
    // final routeArgument =
    //     ModalRoute.of(context).settings.arguments as Map<String, Object>;
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
            ),
            onPressed: () {
              _scaffoldState.currentState.openEndDrawer();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              PredResSymptom(symptomList),
              PredResDisease(detectedDisease, detectedDiseaseAPI),
              !isHistory
                  ? isMeetDoctor
                      ? AdaptiveRaisedButton(
                          buttonText: 'Meet Doctor',
                          handlerFn: () {
                            print('Go to wait doctor');
                          },
                          height: 35,
                          width: 160,
                        )
                      : AdaptiveRaisedButton(
                          buttonText: '    Home   ',
                          handlerFn: () {
                            print('Go to wait doctor');
                          },
                          height: 35,
                          width: 160,
                        )
                  : AdaptiveRaisedButton(
                      buttonText: 'Back',
                      handlerFn: () {
                        Navigator.of(context).pop();
                      },
                      height: 35,
                      width: 160,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
