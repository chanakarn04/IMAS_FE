import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../dummy_data.dart';

class AptSuggestCard extends StatefulWidget {
  final Appointment appointment;
  final int index;

  AptSuggestCard(
    this.appointment,
    this.index,
  );

  @override
  _AptSuggestCardState createState() => _AptSuggestCardState();
}

class _AptSuggestCardState extends State<AptSuggestCard> {
  var _loadedInitData = false;

  final List<Drug> drugs = dummy_drug;
  final List<Prescription> prescriptions = dummy_prescriptions;
  Prescription prescription;
  List<Drug> aptDrugs;
  // Drug drug;
  String suggestion;

  @override
  void initState() {
    // ...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      prescription = prescriptions
          .firstWhere((prescript) => prescript.apId == widget.appointment.apId);
      aptDrugs = drugs.where((drug) => drug.psId == prescription.psId).toList();
      // drug = drugs.where((drug) => drug.psId == prescription.psId);
      suggestion = widget.appointment.advises;
    }
    super.didChangeDependencies();
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
              'Prescription',
              ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          '\t\t\t${aptDrugs[index].drugDetail}',
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
                itemCount: aptDrugs.length,
              ),
            ),
            buildListCard(
              'Treatment',
              ListView(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '\t\t\t$suggestion',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 75, 75, 75),
                      ),
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

class SuggestionTab extends StatefulWidget {
  final String tpId = 'tp001';

  @override
  _SuggestionTabState createState() => _SuggestionTabState();
}

class _SuggestionTabState extends State<SuggestionTab> {
  List<Appointment> appointments;
  var _loadInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadInitData) {
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
      child: Container(
        height: (MediaQuery.of(context).size.height
            // MediaQuery.of(context).padding.top -
            // MediaQuery.of(context).padding.bottom -
            // this.widget.appBarSize
            ),
        child: ListView.builder(
          itemBuilder: (context, index) => AptSuggestCard(
              appointments[index], (appointments.length - index)),
          itemCount: appointments.length,
        ),
      ),
    );
  }
}
