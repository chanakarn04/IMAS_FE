import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../Provider/assessmentHistory.dart';
import '../Models/model.dart';

class DetailAssessmentHistory extends StatelessWidget {
  static const routeName = 'detailAssessmentHistory';

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
    print(item['apts']);
    return Scaffold(
      appBar: AppBar(
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
      ),
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
                        item['symptom'][0],
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
                  _buildStatusBox(context, _statusInfo(item['status'])),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 30,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Diseases',
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        height:
                            (28.0 * item['apts'][0]['pat_condition'].length) +
                                15,
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 10,
                          bottom: 5,
                        ),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final _diseaseList = item['apts'][0]
                                    ['pat_condition']
                                .values
                                .toList();
                            return Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.symmetric(vertical: 1.5),
                              // color: Colors.teal[100],
                              child: Text(
                                '${_diseaseList[index]}',
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          },
                          itemCount: item['apts'][0]['pat_condition'].length,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Symptoms',
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        height:
                            (28.0 * item['apts'][0]['pat_symptom'].length) + 15,
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 10,
                          bottom: 5,
                        ),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 1.5),
                              alignment: Alignment.centerLeft,
                              // color: Colors.teal[100],
                              child: Text(
                                '${item['apts'][0]['pat_symptom'][index]}',
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          },
                          itemCount: item['apts'][0]['pat_symptom'].length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
