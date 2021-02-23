import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../Models/symptom.dart';
import '../../Models/diseaseAPI.dart';
import '../../Widget/carouselDotIndicator.dart';
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

  Widget _buildSeperator(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Container(
            height: 1,
            color: Theme.of(context).primaryColor,
          )),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
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
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        // height: 200,
        // width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Expanded(
              child: ListView(
                children: [
                  Text(
                    'Disease',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    height: diagDisease.length * 25.0 + 20,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(vertical: 2.5),
                          child: Text(
                            '\t\t\t${diseases.firstWhere((disease) => disease.id == diagDisease[index].dId).commonName}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 75, 75, 75),
                            ),
                          ),
                        );
                      },
                      itemCount: diagDisease.length,
                    ),
                  ),
                  _buildSeperator(context),
                  Text(
                    'Symptom',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    height: dtdSymptom.length * 45.0 + 20,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.5),
                          child: Row(
                            children: [
                              Text(
                                '\t\t\t${symptoms.firstWhere((symptom) => symptom.id == dtdSymptom[index].stId).name}',
                                style: TextStyle(
                                  fontSize: 16,
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
                        );
                      },
                      itemCount: dtdSymptom.length,
                    ),
                  ),
                ],
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

  @override
  _DiseaseSymptomTabState createState() => _DiseaseSymptomTabState();
}

class _DiseaseSymptomTabState extends State<DiseaseSymptomTab> {
  List<Appointment> appointments;
  var _loadedInitData = false;
  int carouselIndex = 0;

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
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              // color: Colors.purple[300],
              // height: (MediaQuery.of(context).size.height),
              child: CarouselSlider.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index, _) {
                  return AptStpDisCardWidget(
                      appointments[index], (appointments.length - index));
                },
                options: CarouselOptions(
                  height: 500,
                  enlargeCenterPage: true,
                  initialPage: carouselIndex,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, _) {
                    setState(() {
                      carouselIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          CarouselDotIndicator(
            length: appointments.length,
            ctrlIndex: carouselIndex,
            selectedColor: Theme.of(context).primaryColor,
            unSelectedColor: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
