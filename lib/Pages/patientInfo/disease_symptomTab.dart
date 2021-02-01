import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Models/symptom.dart';
import '../../Models/diseaseAPI.dart';
import '../../dummy_data.dart';

class AptStpDisCardWidget extends StatefulWidget {
  final Appointment appointment;
  final int index;

  AptStpDisCardWidget(
    this.appointment,
    this.index,
  );

  @override
  _AptStpDisCardWidgetState createState() => _AptStpDisCardWidgetState();
}

class _AptStpDisCardWidgetState extends State<AptStpDisCardWidget> {
  var _loadedInitData = false;

  final List<Symptom> symptoms = dummy_symptoms;
  final List<DiseaseAPI> diseases = dummy_diseaseAPIs;
  List<DetectedSymptom> dtdSymptom;
  List<DiagnosedDisease> diagDisease;

  @override
  void initState() {
    // ...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      dtdSymptom = dummy_dtdSymptoms
          .where((symptom) => symptom.apId == widget.appointment.apId)
          .toList();
      diagDisease = dummy_diagDiseases
          .where((disease) => disease.apId == widget.appointment.apId)
          .toList();
      // _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  Color painScoreColor(int painScore) {
    if (painScore < 2) {
      return Color.fromARGB(255, 81, 195, 169);
    } else if (painScore < 5) {
      return Color.fromARGB(255, 80, 200, 233);
    } else if (painScore < 8) {
      return Color.fromARGB(255, 241, 215, 78);
    } else {
      return Color.fromARGB(255, 205, 16, 16);
    }
  }

  Widget buildListCard(
    String title,
    Widget child,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Theme.of(context).accentColor,
                  Theme.of(context).primaryColor,
                ],
              ),
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              title,
              // textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24),
            ),
          ),
          Container(
            height: 100,
            child: child,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        margin: EdgeInsets.all(3),
        // height: 200,
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              'Appointment ${this.widget.index}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              DateFormat.yMMMEd().format(this.widget.appointment.apDt),
              style: TextStyle(color: Color.fromARGB(255, 100, 100, 100)),
            ),
            buildListCard(
              'Disease',
              ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '\t\t\t${diseases.firstWhere((disease) => disease.id == diagDisease[index].dId).commonName}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 75, 75, 75),
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
                itemCount: diagDisease.length,
              ),
            ),
            buildListCard(
              'Symptom',
              ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        // height: 36,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(4),
                        child: Row(
                          children: [
                            Text(
                              '\t\t\t${symptoms.firstWhere((symptom) => symptom.id == dtdSymptom[index].stId).name}',
                              style: TextStyle(
                                fontSize: 22,
                                color: Color.fromARGB(255, 75, 75, 75),
                              ),
                            ),
                            Expanded(child: Container()),
                            CircleAvatar(
                              child: Text(
                                '${dtdSymptom[index].painScore}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              backgroundColor:
                                  painScoreColor(dtdSymptom[index].painScore),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
                itemCount: dtdSymptom.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiseaseSymptomTab extends StatefulWidget {
  final String tpId = 'tp001';
  final double appBarSize;

  DiseaseSymptomTab(this.appBarSize);

  @override
  _DiseaseSymptomTabState createState() => _DiseaseSymptomTabState();
}

class _DiseaseSymptomTabState extends State<DiseaseSymptomTab> {
  List<Appointment> appointments;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      appointments = dummy_appointment
          .where((apt) =>
              (apt.tpId == widget.tpId) && (apt.status == AptStatus.Edited))
          .toList()
          .reversed
          .toList();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              this.widget.appBarSize),
          child: ListView.builder(
            itemBuilder: (context, index) => AptStpDisCardWidget(
                appointments[index], (appointments.length - index)),
            itemCount: appointments.length,
          ),
        ),
      ),
    );
  }
}
