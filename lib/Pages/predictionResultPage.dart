import 'package:flutter/material.dart';
import '../Models/model.dart';
import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../Models/disease.dart';
// import '../Models/diseaseAPI.dart';
// import '../Models/symptom.dart';
import './homePages.dart';
import './WaitingDoctor.dart';
import './vitalSignStartPages.dart';
import '../Widget/predResDisease.dart';
import '../Widget/predResSymptom.dart';
import '../Widget/predResPatientInfo.dart';
import '../Widget/AdaptiveRaisedButton.dart';
import '../Provider/chatRoom_info.dart';
import '../Provider/symptomAssessment.dart';
import '../Provider/user-info.dart';
import '../Provider/vitalSign_Info.dart';

class PredictionResultPage extends StatefulWidget {
  static const routeName = '/prediction-result';

  @override
  _PredictionResultPageState createState() => _PredictionResultPageState();
}

class _PredictionResultPageState extends State<PredictionResultPage> {
  bool isHistory = false;
  // String triage_level;
  // bool isMeetDoctor = false;
  List<dynamic> symptoms = [];
  List<dynamic> conditions = [];

  var _loadedData = false;
  SymptomAssessmentProvider symptomAssessment;
  UserInfo userInfo;

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
          'common_name': 'Tension Headache',
          'description':
              'Pain associated with muscle used and working. pain seem to be aggravated over the day and can relieved by rest.'
        },
        {
          'cid': 'c0002',
          'common_name': 'Tension Headache 2',
          'description':
              'Pain associated with muscle used and working. pain seem to be aggravated over the day and can relieved by rest.'
        },
      ],
    };

    symptoms = _loadedData['symptom'];
    conditions = _loadedData['condition'];
  }

  void decodeTriage(
    List<dynamic> triageConditions,
    Map<String, dynamic> triage,
  ) {
    conditions = triageConditions;
    // triage_level = triage['triage_level'];
    // symptoms = triage['serious'];
  }

  @override
  void didChangeDependencies() async {
    // print(phrase);
    if (!_loadedData) {
      final routeArgument =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      symptomAssessment = Provider.of<SymptomAssessmentProvider>(context);
      userInfo = Provider.of<UserInfo>(context, listen: false);
      isHistory = routeArgument['isHistory'];

      // isMeetDoctor = routeArgument['isMeetDoctor'];
      if (!isHistory) {
        _loadedData = true;
        // if it prediction result / not history
        // query from api
        // // save-from-API
        symptoms = symptomAssessment.selectedSymptom;
        conditions = symptomAssessment.conditions;
        await symptomAssessment.sendTriage();
        // triage_level = symptomAssessment.triage['triage_level'];
        await symptomAssessment.saveResult(userInfo.userData['userName']);
      } else {
        // if it history
        // query from database
        _loadData();
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatRoomProvider>(context);
    final vitalSignProvider =
        Provider.of<VitalSignProvider>(context, listen: false);
    print(symptomAssessment.triage_level);
    return Scaffold(
      body: (!symptomAssessment.sendingTriage)
          ? Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                child: CircularProgressIndicator(
                  strokeWidth: 5.0,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      child: Icon(
                        Icons.home_rounded,
                        color: Colors.white,
                      ),
                      onTap: () {
                        symptomAssessment.clear();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Result',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 27),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Detected symptoms and diseases',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 20,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            child: ListView(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              children: <Widget>[
                                PredResPatientInfo(
                                  genderTextGenerater(
                                      userInfo.userData['gender']),
                                  ageCalculate(userInfo.userData['dob'])
                                      .toInt(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 15,
                                  ),
                                  child: Container(
                                    height: 0.5,
                                    color: Colors.grey,
                                  ),
                                ),
                                PredResSymptom(symptoms),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 15,
                                  ),
                                  child: Container(
                                    height: 0.5,
                                    color: Colors.grey,
                                  ),
                                ),
                                PredResDisease(conditions),
                                SizedBox(
                                  height: 50,
                                ),
                                !isHistory
                                    ? (symptomAssessment.triage_level ==
                                                'emergency' ||
                                            symptomAssessment.triage_level ==
                                                'emergency_ambulance')
                                        ? Container(
                                            child: Center(
                                              child: AdaptiveRaisedButton(
                                                buttonText: 'Emergency',
                                                handlerFn: () {
                                                  print('alertDialog');
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Emergency Call 1669'),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10.0),
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                'Call',
                                                                style:
                                                                    TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                  // Navigator.of(context)
                                                  //     .popUntil(ModalRoute.withName('/home'));
                                                },
                                                height: 40,
                                                width: 160,
                                              ),
                                            ),
                                          )
                                        : (symptomAssessment.triage_level ==
                                                    'consultation_24' ||
                                                symptomAssessment
                                                        .triage_level ==
                                                    'consultation')
                                            ? Center(
                                                child: AdaptiveRaisedButton(
                                                  buttonText: 'Meet Doctor',
                                                  handlerFn: () {
                                                    if (chatProvider
                                                        .isConsult) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'You are now consulting'),
                                                              content: Text(
                                                                  'You cannot have another consult.'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    symptomAssessment
                                                                        .clear();
                                                                    Navigator.of(
                                                                            context)
                                                                        .popUntil(
                                                                            ModalRoute.withName(HomePage.routeName));
                                                                  },
                                                                  child: Text(
                                                                    'Home',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    } else {
                                                      vitalSignProvider.tpId =
                                                          symptomAssessment
                                                              .tpid;
                                                      vitalSignProvider.apId =
                                                          symptomAssessment
                                                              .apid;
                                                      chatProvider
                                                          .patientReqChat(
                                                        userInfo.userData[
                                                            'userName'],
                                                        userInfo.role,
                                                        symptomAssessment.tpid,
                                                        symptomAssessment.apid,
                                                      );
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                              VitalSignStartPage
                                                                  .routeName);
                                                      symptomAssessment.clear();
                                                    }
                                                    // Navigator.of(context).pushReplacementNamed(
                                                    //     WaitingPage.routeName);
                                                    // chatProvider.chatRequest(Role.Patient);
                                                    // Navigator.of(context)
                                                    //     .popUntil(ModalRoute.withName('/home'));
                                                  },
                                                  height: 40,
                                                  width: 160,
                                                ),
                                              )
                                            : Center(
                                                child: AdaptiveRaisedButton(
                                                  buttonText: 'Home',
                                                  handlerFn: () {
                                                    symptomAssessment.clear();
                                                    Navigator.of(context)
                                                        .popUntil(ModalRoute
                                                            .withName(HomePage
                                                                .routeName));
                                                  },
                                                  height: 40,
                                                  width: 160,
                                                ),
                                              )
                                    : Container(),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
