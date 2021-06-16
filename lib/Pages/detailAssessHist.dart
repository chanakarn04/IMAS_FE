import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/model.dart';
import '../Widget/SuggestionCardContent.dart';
import '../Widget/carouselDotIndicator.dart';

class DetailAssessmentHistory extends StatefulWidget {
  static const routeName = 'detailAssessmentHistory';

  @override
  _DetailAssessmentHistoryState createState() =>
      _DetailAssessmentHistoryState();
}

class _DetailAssessmentHistoryState extends State<DetailAssessmentHistory> {
  int carouselIndex = 0;
  Widget _buildStatusBox(
    BuildContext context,
    String status,
  ) {
    BoxDecoration decoration;
    Color textColor;
    if (status == 'Mild') {
      textColor = Theme.of(context).primaryColor;
      decoration = BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(15),
      );
    } else if (status == 'In progress') {
      textColor = Colors.white;
      decoration = BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(15),
      );
    } else if (status == 'Hospital') {
      textColor = Colors.white;
      decoration = BoxDecoration(
        color: Color.fromARGB(255, 205, 16, 16),
        borderRadius: BorderRadius.circular(15),
      );
    } else {
      textColor = Colors.white;
      decoration = BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
      );
    }
    return Container(
      width: 150,
      padding: EdgeInsets.symmetric(vertical: 3),
      alignment: Alignment.center,
      decoration: decoration,
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _statusInfo(
    TreatmentStatus status,
  ) {
    switch (status) {
      case TreatmentStatus.Api:
        return 'Mild';
        break;
      case TreatmentStatus.Healed:
        return 'Cured';
        break;
      case TreatmentStatus.InProgress:
        return 'In progress';
        break;
      case TreatmentStatus.Hospital:
        return 'Hospital';
        break;
      default:
        return '';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> item = ModalRoute.of(context).settings.arguments;
    if (item['apts'][0]['pat_symptom'] != null) {
      item['apts'][0]['pat_symptom'] = item['apts'][0]['pat_symptom'].toSet().toList();
    }
    List<Map<String, dynamic>> temp_apts = List<Map<String, dynamic>>.from(item['apts']);
    temp_apts.removeWhere((element) => (element['date'].difference(DateTime.now()).inDays > 0));
    item['apts'] = temp_apts;

    final appBar = AppBar(
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      backgroundColor: Theme.of(context).primaryColor,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop()),
      title: Container(
        child: Text(
          'Assessment history',
          style: TextStyle(color: Colors.white),
        ),
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
    );
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.only(
          top: 15,
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (item['symptom'] != null)
                            ? (item['symptom'].isNotEmpty)
                                ? item['symptom'][0]
                                : 'No Symptom'
                            : 'No Symptom',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        DateFormat.yMMMd().add_jm().format(item['date']),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  _buildStatusBox(context, _statusInfo(item['tpStatus'])),
                ],
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      child: CarouselSlider.builder(
                        itemCount: item['apts'].length,
                        itemBuilder: (context, index, _) {
                          List diseaseList;
                          List symptomList;
                          List prescriptionList;
                          if (item['apts'][index]['pat_condition'] != null) {
                            diseaseList = item['apts'][index]['pat_condition'].values.toList();
                          } else {
                            diseaseList = [];
                          }
                          if (item['apts'][index]['pat_symptom'] != null) {
                            symptomList = item['apts'][index]['pat_symptom'];
                          } else {
                            symptomList = [];
                          }
                          if (item['apts'][index]['prescription'] != null) {
                            prescriptionList = item['apts'][index]['prescription'];
                          } else {
                            prescriptionList = [];
                          }
                          return Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 25,
                                horizontal: 30,
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: (item['tpStatus'] == TreatmentStatus.Api)
                                  ? SuggestionCardContent(
                                      conditions: List<String>.from(diseaseList),
                                      symptoms: List<String>.from(symptomList),
                                    )
                                  : SuggestionCardContent(
                                      appointmentIndex: item['apts'].length - index,
                                      apdt: item['date'],
                                      tpStatus: item['tpStatus'],
                                      conditions: List<String>.from(diseaseList),
                                      symptoms: List<String>.from(symptomList),
                                      prescriptions: List<String>.from(prescriptionList),
                                      suggestion: item['apts'][index]['advice'],
                                    ));
                        },
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top - 130,
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
                  if (item['apts'].length > 1)
                    Positioned(
                      bottom: 30,
                      right: 0,
                      left: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: CarouselDotIndicator(
                          length: item['apts'].length,
                          ctrlIndex: carouselIndex,
                          selectedColor: Theme.of(context).primaryColor,
                          unSelectedColor: Colors.grey,
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
