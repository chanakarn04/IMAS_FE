import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../Widget/sideDrawer.dart';
import './patientInfo/basicInfoTab.dart';
import './patientInfo/disease_symptomTab.dart';
import './patientInfo/vitalSignTab.dart';
import './patientInfo/suggestionTab.dart';

class PatientInfoPage extends StatefulWidget {
  static const routeName = '/patient-info';
  final pInfo = dummy_Paitent;

  @override
  _PatientInfoPageState createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ],
              stops: [
                0.3,
                1.0,
              ]),
        ),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop()),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.menu_rounded,
          ),
          onPressed: () {
            _scaffoldState.currentState.openEndDrawer();
          },
        ),
      ],
      bottom: PreferredSize(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/patient.jpg'),
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 25,
                child: FittedBox(
                  child: Text(
                    '${this.widget.pInfo.pName} ${this.widget.pInfo.pSurname}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 15,
                child: FittedBox(
                  child: Text(
                    'Next Appointment : 18 December 2020',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              TabBar(
                indicatorWeight: 4.0,
                indicatorColor: Theme.of(context).primaryColorLight,
                // labelColor: Theme.of(context).primaryColorLight,
                labelColor: Colors.white,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelColor:
                    // Theme.of(context).primaryColorLight.withAlpha(100),
                    Colors.white54,
                tabs: <Widget>[
                  Tab(
                    text: 'Basic info',
                  ),
                  Tab(
                    text: 'Disease/Symptom',
                  ),
                  Tab(
                    text: 'Vital sign',
                  ),
                  Tab(
                    text: 'Suggestion',
                  ),
                ],
              ),
            ],
          ),
        ),
        preferredSize: Size(0.0, 160.0),
      ),
    );

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldState,
        endDrawer: SideDrawer(),
        appBar: appBar,
        body: TabBarView(
          children: <Widget>[
            BasicInfoTab(),
            DiseaseSymptomTab(),
            VitalSignTab(),
            SuggestionTab(),
          ],
        ),
      ),
    );
  }
}
