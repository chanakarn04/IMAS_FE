import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../dummy_data.dart';
import '../../Widget/carouselDotIndicator.dart';

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
            Expanded(
              child: ListView(
                children: [
                  Text(
                    'Prescription',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    height: aptDrugs.length * 25.0 + 20,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(vertical: 2.5),
                              child: Text(
                                '\t\t\t${aptDrugs[index].drugDetail}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 75, 75, 75),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: aptDrugs.length,
                    ),
                  ),
                  _buildSeperator(context),
                  Text(
                    'Prescription',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    // height: aptDrugs.length * 25.0 + 20,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 2.5),
                      child: Text(
                        '    $suggestion',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 75, 75, 75),
                        ),
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
  int carouselIndex = 0;

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
      child: Column(
        children: [
          Expanded(
            child: Container(
              // height: (MediaQuery.of(context).size.height
              // MediaQuery.of(context).padding.top -
              // MediaQuery.of(context).padding.bottom -
              // this.widget.appBarSize
              child: CarouselSlider.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index, _) => AptSuggestCard(
                    appointments[index], (appointments.length - index)),
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
