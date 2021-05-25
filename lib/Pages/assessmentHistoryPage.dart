import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './predictionResultPage.dart';
import './suggestionPage.dart';
import './detailAssessHist.dart';
import '../Provider/user-info.dart';
import '../Provider/assessmentHistory.dart';
import '../Models/model.dart';

class AssessmentHistoryPage extends StatefulWidget {
  static const routeName = '/assessment history';
  // [
  //     {
  //       'tpId': 'tp001',
  //       'symptom': 'Headache',
  //       'date': DateTime.now(),
  //       'status': TreatmentStatus.InProgress,
  //     },
  //     {
  //       'tpId': 'tp002',
  //       'symptom': 'Forearm pain',
  //       'date': DateTime(2020, 12, 10),
  //       'status': TreatmentStatus.Api,
  //     },
  //     {
  //       'tpId': 'tp003',
  //       'symptom': 'Dizziness',
  //       'date': DateTime(2020, 11, 28),
  //       'status': TreatmentStatus.Cured,
  //     },
  //     {
  //       'tpId': 'tp004',
  //       'symptom': 'Break',
  //       'date': DateTime(2020, 11, 28),
  //       'status': TreatmentStatus.Hospital,
  //     },
  //     {
  //       'tpId': 'tp005',
  //       'symptom': 'Silence',
  //       'date': DateTime(2020, 11, 28),
  //       'status': TreatmentStatus.Hospital,
  //     },
  //   ];

  @override
  _AssessmentHistoryPageState createState() => _AssessmentHistoryPageState();
}

class _AssessmentHistoryPageState extends State<AssessmentHistoryPage> {
  var _loadedData = false;
  AssessmentHistoryProvider assessmentHistoryProvider;
  UserInfo userInfo;

  @override
  void didChangeDependencies() async {
    if (!_loadedData) {
      userInfo = Provider.of<UserInfo>(context);
      assessmentHistoryProvider =
          Provider.of<AssessmentHistoryProvider>(context);
      assessmentHistoryProvider.loading = true;
      await assessmentHistoryProvider.updateAssessmentHistory(userInfo.role);
      _loadedData = true;
    }
    super.didChangeDependencies();
  }

  List<Map<String, dynamic>> items = [];

  String _statusInfo(
    BuildContext context,
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
          width: 1,
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
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 3),
      alignment: Alignment.center,
      decoration: decoration,
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final userInfo = Provider.of<UserInfo>(context);
    // final assessmentHistory = Provider.of<AssessmentHistoryProvider>(context);
    // assessmentHistory.updateAssessmentHistory(userInfo.role);
    // items = _loadData();
    items = assessmentHistoryProvider.assessmentHistoryData;
    // for (Map<String, dynamic> item in items) {
    //   print('===> ITEMS <===');
    //   print('tpid:     ${item['tpid']}');
    //   print('tpStatus: ${item['tpStatus']}');
    //   print('date:     ${item['date']}');
    //   print('apStatus: ${item['apStatus']}');
    //   print('symptom:  ${item['symptom']}');
    //   // print('apts: ${item['apts']}');
    // } 
    // print('===> items ${items[1][]}');
    // print('===> ${items.length}');
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pop()),
        title: Container(
          alignment: Alignment.center,
          child: Text('Assessment history'),
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
      body: (assessmentHistoryProvider.loading)
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
          : (items.isNotEmpty)
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  // color: Colors.teal[200],
                  alignment: Alignment.center,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      // print('index: $index');
                      return Container(
                        margin: (index == 0)
                            ? EdgeInsets.only(
                                top: 10,
                                bottom: 3,
                              )
                            : (index == items.length - 1)
                                ? EdgeInsets.only(
                                    top: 3,
                                    bottom: 10,
                                  )
                                : EdgeInsets.symmetric(
                                    vertical: 3,
                                  ),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (items[index]['symptom'] != null)
                                      ? items[index]['symptom'].isNotEmpty
                                          ? items[index]['symptom'][0]
                                          : 'No symptom'
                                      : 'No symptom',
                                  // [
                                  //   {
                                  //     tpid: 60a6204dd3dec9001f59863a,
                                  //     status: TreatmentStatus.Api,
                                  //     date: 2021-05-20 08:39:41.958Z,
                                  //     symptom: [Back pain],
                                  //     apts: [
                                  //       {
                                  //         apid: 60a6204dd3dec9001f59863b, date: 2021-05-20T08:39:41.958Z, pat_symptom: [Back pain], pat_condition: {c_981: Back strain, c_577: Degenerative disc disease of the thoracic spine, c_37: Kidney stones, c_533: Bone infection, c_149: Ankylosing spondylitis}
                                  //       }
                                  //     ]
                                  //   }, {tpid: 60a62c11c8854a001fc4f457, status: TreatmentStatus.Api, date: 2021-05-27 00:00:00.000Z, symptom: null, apts: [{apid: 60a62ca4c8854a001fc4f45d, date: 2021-05-27T00:00:00.000Z, pat_symptom: null, pat_condition: null}, {apid: 60a62c11c8854a001fc4f458, date: 2021-05-20T09:29:53.820Z, pat_symptom: [backsalch], pat_condition: {c_981: Back strain, c_577: Degenerative disc disease of the thoracic spine}}]}, {tpid: 60a63885c8854a001fc4f45f, status: TreatmentStatus.Api, date: 2021-05-20 10:23:01.853Z, symptom: [foot rash], apts: [{apid: 60a63885c8854a001fc4f460, date: 2021-05-20T10:23:01.853Z, pat_symptom: [foot rash], pat
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                Text(
                                  '${DateFormat.yMMMd().format(items[index]['date'])}   ${DateFormat.jm().format(items[index]['date'])}',
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                _buildStatusBox(
                                    context,
                                    _statusInfo(
                                        context, items[index]['tpStatus'])),
                              ],
                            ),
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    DetailAssessmentHistory.routeName,
                                    arguments: items[index]);
                                // if (items[index]['status'] == TreatmentStatus.Api) {
                                //   Navigator.of(context).pushNamed(
                                //       PredictionResultPage.routeName,
                                //       arguments: {
                                //         'isHistory': true,
                                //         // 'isMeetDoctor': false
                                //       });
                                // } else if ((items[index]['status'] ==
                                //         TreatmentStatus.Hospital) &&
                                //     (items[index]['tpid'] == 'tp005')) {
                                //   // check is doctor id is null
                                //   // if doctor id is null mean this case never talk to doctor then no suggstion to show
                                //   // show api result instead of doctor suggestion
                                //   Navigator.of(context).pushNamed(
                                //       PredictionResultPage.routeName,
                                //       arguments: {
                                //         'isHistory': true,
                                //         'isMeetDoctor': false
                                //       });
                                // } else {
                                //   Navigator.of(context).pushNamed(
                                //     SuggestionPage.routeName,
                                //     arguments: items[index]['status'],
                                //   );
                                // }
                              },
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Theme.of(context).primaryColor,
                                size: 42,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: items.length,
                  ),
                )
              : Center(
                  child: Text(
                  'No assessment history',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                )),
    );
  }
}
