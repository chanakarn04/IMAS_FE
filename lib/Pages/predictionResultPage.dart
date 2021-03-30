import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../Models/disease.dart';
// import '../Models/diseaseAPI.dart';
// import '../Models/symptom.dart';
import '../Widget/predResDisease.dart';
import '../Widget/predResSymptom.dart';
import '../Widget/AdaptiveRaisedButton.dart';
import '../Widget/adaptiveBorderButton.dart';
import '../Provider/symptomAssessment.dart';

class PredictionResultPage extends StatefulWidget {
  static const routeName = '/prediction-result';

  @override
  _PredictionResultPageState createState() => _PredictionResultPageState();
}

class _PredictionResultPageState extends State<PredictionResultPage> {
  bool isHistory = false;
  String triage_level;
  // bool isMeetDoctor = false;
  List<Map<String, dynamic>> symptoms;
  List<Map<String, dynamic>> conditions;
  var _loadedData = false;
  SymptomAssessmentProvider symptomAssessment;

  void _loadData() {
    // ...

    Map<String, dynamic> _loadedData = {
      'symptom': [
        // 'Head drop',
        // 'Head tilt in order to avoid diplopia',
        // 'Head tremors',
        // 'Headache',
        {
          "id": "s_1193",
          "name": "Headache, severe",
          "common_name": "Severe headache",
          "is_emergency": false
        },
        {
          "id": "s_418",
          "name": "Stiff neck",
          "common_name": "Stiff neck",
          "is_emergency": false
        }
      ],
      'condition': [
        {
          'cid': 'c0001',
          'name': 'Tension Headache',
          'description':
              'Pain associated with muscle used and working. pain seem to be aggravated over the day and can relieved by rest.'
        },
        {
          'cid': 'c0002',
          'name': 'Tension Headache 2',
          'description':
              'Pain associated with muscle used and working. pain seem to be aggravated over the day and can relieved by rest.'
        },
      ],
    };

    symptoms = _loadedData['symptom'];
    conditions = _loadedData['condition'];
  }

  void decodeTriage(
    List<Map<String, dynamic>> triageConditions,
    Map<String, dynamic> triage,
  ) {
    conditions = triageConditions;
    triage_level = triage['triage_level'];
    symptoms = triage['serious'];
  }

  @override
  void didChangeDependencies() {
    // print(phrase);
    if (!_loadedData) {
      final routeArgument =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
      symptomAssessment = Provider.of<SymptomAssessmentProvider>(context, listen: false);
      isHistory = routeArgument['isHistory'];
      // isMeetDoctor = routeArgument['isMeetDoctor'];
      if (!isHistory) {
        // if it prediction result / not history
        // query from api
        symptomAssessment.sendTriage();
        decodeTriage(symptomAssessment.conditions, symptomAssessment.triage);
      } else {
        // if it history
        // query from database
        _loadData();
      }
      _loadedData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              PredResSymptom(symptoms),
              PredResDisease(conditions),
              SizedBox(
                height: 15,
              ),
              !isHistory
                  ? (triage_level == 'emergency' || triage_level == 'emergency_ambulance')
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AdaptiveRaisedButton(
                          buttonText: 'Home',
                          handlerFn: () {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName('/home'));
                          },
                          height: 35,
                          width: 160,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        AdaptiveRaisedButton(
                          buttonText: 'Emergency',
                          handlerFn: () {
                            print('alertDialog');
                            // Navigator.of(context)
                            //     .popUntil(ModalRoute.withName('/home'));
                          },
                          height: 35,
                          width: 160,
                        )
                      ],
                    )
                    : (triage_level == 'consultation_24' || triage_level == 'consultation')
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AdaptiveRaisedButton(
                            buttonText: 'Home',
                            handlerFn: () {
                              Navigator.of(context)
                                  .popUntil(ModalRoute.withName('/home'));
                            },
                            height: 35,
                            width: 160,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          AdaptiveRaisedButton(
                            buttonText: 'Meet Doctor',
                            handlerFn: () {
                              print('Meet Doctor');
                              // Navigator.of(context)
                              //     .popUntil(ModalRoute.withName('/home'));
                            },
                            height: 35,
                            width: 160,
                          )
                        ],
                      )
                      // ? Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       AdaptiveRaisedButton(
                      //         buttonText: 'Meet Doctor',
                      //         handlerFn: () {
                      //           print('Go to wait doctor');
                      //         },
                      //         height: 35,
                      //         width: 170,
                      //       ),
                      //       SizedBox(
                      //         height: 10,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           AdaptiveBorderButton(
                      //             buttonText: 'Home',
                      //             handlerFn: () {
                      //               // print('Home');
                      //               Navigator.of(context)
                      //                   .popUntil(ModalRoute.withName('/home'));
                      //             },
                      //             height: 45,
                      //             width: 180,
                      //           ),
                      //           SizedBox(
                      //             width: 15,
                      //           ),
                      //           AdaptiveBorderButton(
                      //             buttonText: 'Nearby Hospital',
                      //             handlerFn: () {
                      //               print('Go to nearby Hospital');
                      //             },
                      //             height: 45,
                      //             width: 180,
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   )
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
