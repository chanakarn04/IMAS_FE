import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/utils.dart';

import '../Provider/assessmentHistory.dart';
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
    final assessmentHistoryProvider =
        Provider.of<AssessmentHistoryProvider>(context);
    Map<String, dynamic> item = ModalRoute.of(context).settings.arguments;
    if (item['apts'][0]['pat_symptom'] != null) {
      item['apts'][0]['pat_symptom'] =
          item['apts'][0]['pat_symptom'].toSet().toList();
    }
    print('====>>> item: $item');
    // print('${item['apts'][0]['pat_condition']}');

    // test
    // final test_item = [
    //   {
    //     'symp': ['symptom1'],
    //     'cond': ['disease1'],
    //   },
    //   {
    //     'symp': ['symptom2'],
    //     'cond': ['disease2'],
    //   },
    // ];

    final appBar = AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
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
          style: TextStyle(
            color: Colors.white,
          ),
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
      body: Container(
        // color: Colors.teal[100],
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
                      SizedBox(
                        height: 5,
                      ),
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
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      // color: Colors.amber,
                      // alignment: Alignment.bottomCenter,
                      child: CarouselSlider.builder(
                        itemCount: item['apts'].length,
                        // itemCount: test_item.length,
                        itemBuilder: (context, index, _) {
                          // print('length: ${item['apts'].length}');
                          List diseaseList;
                          List symptomList;
                          List prescriptionList;
                          if (item['apts'][index]['pat_condition'] != null) {
                            diseaseList = item['apts'][index]['pat_condition']
                                .values
                                .toList();
                          } else {
                            diseaseList = [];
                          }
                          if (item['apts'][index]['pat_symptom'] != null) {
                            symptomList = item['apts'][index]['pat_symptom'];
                          } else {
                            symptomList = [];
                          }
                          if (item['apts'][index]['prescription'] != null) {
                            prescriptionList =
                                item['apts'][index]['prescription'];
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: (item['tpStatus'] == TreatmentStatus.Api)
                                  ? SuggestionCardContent(
                                      conditions:
                                          List<String>.from(diseaseList),
                                      symptoms: List<String>.from(symptomList),
                                      // conditions: test_item[index]['cond'],
                                      // symptoms: test_item[index]['symp'],
                                    )
                                  : SuggestionCardContent(
                                      appointmentIndex:
                                          item['apts'].length - index,
                                      apdt: item['date'],
                                      tpStatus: item['tpStatus'],
                                      conditions:
                                          List<String>.from(diseaseList),
                                      symptoms: List<String>.from(symptomList),
                                      prescriptions:
                                          List<String>.from(prescriptionList),
                                      suggestion: item['apts'][index]['advice'],
                                    ));
                        },
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top -
                              130,
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
                      // top: 0,
                      bottom: 30,
                      right: 0,
                      left: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: CarouselDotIndicator(
                          length: item['apts'].length,
                          // length: test_item.length,
                          ctrlIndex: carouselIndex,
                          selectedColor: Theme.of(context).primaryColor,
                          unSelectedColor: Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Expanded(
            // child: Container(
            //   decoration: BoxDecoration(
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.5),
            //         spreadRadius: 5,
            //         blurRadius: 7,
            //         offset: Offset(0, 3), // changes position of shadow
            //       ),
            //     ],
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(30),
            //       topRight: Radius.circular(30),
            //     ),
            //     color: Colors.white,
            //   ),
            //   child: Container(
            //     padding: EdgeInsets.symmetric(
            //       vertical: 25,
            //       horizontal: 30,
            //     ),
            //     child: Column(
            //       children: [
            //         Align(
            //           alignment: Alignment.centerLeft,
            //           child: Text(
            //             'Diseases',
            //             style: TextStyle(
            //               fontSize: 24,
            //               color: Theme.of(context).primaryColor,
            //             ),
            //           ),
            //         ),
            //         Container(
            //           height:
            //               (28.0 * item['apts'][0]['pat_condition'].length) +
            //                   15,
            //           padding: EdgeInsets.only(
            //             left: 20,
            //             top: 10,
            //             bottom: 5,
            //           ),
            //           child: ListView.builder(
            //             itemBuilder: (context, index) {
            //               final _diseaseList = item['apts'][0]
            //                       ['pat_condition']
            //                   .values
            //                   .toList();
            //               return Container(
            //                 alignment: Alignment.centerLeft,
            //                 margin: EdgeInsets.symmetric(vertical: 1.5),
            //                 // color: Colors.teal[100],
            //                 child: Text(
            //                   '${_diseaseList[index]}',
            //                   maxLines: 1,
            //                   overflow: TextOverflow.fade,
            //                   softWrap: false,
            //                   style: TextStyle(fontSize: 18),
            //                 ),
            //               );
            //             },
            //             itemCount: item['apts'][0]['pat_condition'].length,
            //           ),
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Container(
            //           height: 1,
            //           color: Colors.grey,
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Align(
            //           alignment: Alignment.centerLeft,
            //           child: Text(
            //             'Symptoms',
            //             style: TextStyle(
            //               fontSize: 24,
            //               color: Theme.of(context).primaryColor,
            //             ),
            //           ),
            //         ),
            //         Container(
            //           height:
            //               (28.0 * item['apts'][0]['pat_symptom'].length) + 15,
            //           padding: EdgeInsets.only(
            //             left: 20,
            //             top: 10,
            //             bottom: 5,
            //           ),
            //           child: ListView.builder(
            //             itemBuilder: (context, index) {
            //               return Container(
            //                 margin: EdgeInsets.symmetric(vertical: 1.5),
            //                 alignment: Alignment.centerLeft,
            //                 // color: Colors.teal[100],
            //                 child: Text(
            //                   '${item['apts'][0]['pat_symptom'][index]}',
            //                   style: TextStyle(fontSize: 18),
            //                 ),
            //               );
            //             },
            //             itemCount: item['apts'][0]['pat_symptom'].length,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}
