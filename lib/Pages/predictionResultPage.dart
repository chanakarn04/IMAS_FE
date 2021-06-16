import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './homePages.dart';
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
  List<dynamic> symptoms = [];
  List<dynamic> conditions = [];

  var _loadedData = false;
  SymptomAssessmentProvider symptomAssessment;
  UserInfo userInfo;

  @override
  void didChangeDependencies() async {
    if (!_loadedData) {
      symptomAssessment = Provider.of<SymptomAssessmentProvider>(context);
      userInfo = Provider.of<UserInfo>(context, listen: false);
      _loadedData = true;
      symptoms = symptomAssessment.selectedSymptom;
      conditions = symptomAssessment.conditions;
      await symptomAssessment.sendTriage();
      await symptomAssessment.saveResult(userInfo.userData['userName']);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatRoomProvider>(context);
    final vitalSignProvider =
        Provider.of<VitalSignProvider>(context, listen: false);
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
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
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
                  SizedBox(height: 5),
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
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
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
                              padding: EdgeInsets.symmetric(vertical: 10),
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
                                (symptomAssessment.triage_level == 'emergency' ||
                                symptomAssessment.triage_level == 'emergency_ambulance')
                                  ? Center(
                                    child: AdaptiveRaisedButton(
                                      buttonText: 'Emergency',
                                      handlerFn: () =>
                                        showDialog(
                                          context: context,
                                          builder: (_) =>
                                            AlertDialog(
                                              title: Text('Emergency Call 1669'),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>Navigator.of(context).pop(),
                                                  child: Text(
                                                    'Call',
                                                    style: TextStyle(color: Theme.of(context).primaryColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ),
                                      height: 40,
                                      width: 160,
                                    ),
                                  )
                                  : (symptomAssessment.triage_level == 'consultation_24' ||
                                    symptomAssessment.triage_level == 'consultation')
                                      ? Center(
                                          child: AdaptiveRaisedButton(
                                            buttonText: 'Meet Doctor',
                                            handlerFn: () {
                                              if (chatProvider.isConsult) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                    AlertDialog(
                                                      title: Text('You are now consulting'),
                                                      content: Text('You cannot have another consult.'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            symptomAssessment.clear();
                                                            Navigator.of(context).popUntil(ModalRoute.withName(HomePage.routeName));
                                                          },
                                                          child: Text(
                                                            'Home',
                                                            style: TextStyle(color: Theme.of(context).primaryColor),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                );
                                              } else {
                                                vitalSignProvider.tpId = symptomAssessment.tpid;
                                                vitalSignProvider.apId = symptomAssessment.apid;
                                                chatProvider.patientReqChat(
                                                  userInfo.userData['userName'],
                                                  userInfo.role,
                                                  symptomAssessment.tpid,
                                                  symptomAssessment.apid,
                                                );
                                                Navigator.of(context).pushReplacementNamed(VitalSignStartPage.routeName);
                                                symptomAssessment.clear();
                                              }
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
                                              Navigator.of(context).popUntil(ModalRoute.withName(HomePage.routeName));
                                            },
                                            height: 40,
                                            width: 160,
                                          ),
                                        ),
                                SizedBox(height: 15),
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
