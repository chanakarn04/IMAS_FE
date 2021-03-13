import 'package:flutter/material.dart';
import 'package:homepage_proto/dummy_data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './predictionResultPage.dart';
import './suggestionPage.dart';
import '../Provider/user-info.dart';

class AssessmentHistoryPage extends StatelessWidget {
  static const routeName = '/assessment history';
  List<Map<String, Object>> items = [];

  // load pInfo
  List<Map<String, Object>> _loadData() {
    // ...

    return [
      {
        'tpId': 'tp001',
        'symptom': 'Headache',
        'date': DateTime.now(),
        'status': TreatmentStatus.InProgress,
      },
      {
        'tpId': 'tp002',
        'symptom': 'Forearm pain',
        'date': DateTime(2020, 12, 10),
        'status': TreatmentStatus.Api,
      },
      {
        'tpId': 'tp003',
        'symptom': 'Dizziness',
        'date': DateTime(2020, 11, 28),
        'status': TreatmentStatus.Cured,
      },
      {
        'tpId': 'tp004',
        'symptom': 'Break',
        'date': DateTime(2020, 11, 28),
        'status': TreatmentStatus.Hospital,
      },
      {
        'tpId': 'tp005',
        'symptom': 'Silence',
        'date': DateTime(2020, 11, 28),
        'status': TreatmentStatus.Hospital,
      },
    ];
  }

  String _statusInfo(
    BuildContext context,
    TreatmentStatus status,
  ) {
    switch (status) {
      case TreatmentStatus.Api:
        return 'Mild';
        break;
      case TreatmentStatus.Cured:
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
    final userInfo = Provider.of<UserInfo>(context);
    items = _loadData();
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        // color: Colors.teal[200],
        alignment: Alignment.center,
        child: ListView.builder(
          itemBuilder: (context, index) {
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
                        items[index]['symptom'],
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
                      _buildStatusBox(context,
                          _statusInfo(context, items[index]['status'])),
                    ],
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      if (items[index]['status'] == TreatmentStatus.Api) {
                        Navigator.of(context).pushNamed(
                            PredictionResultPage.routeName,
                            arguments: {
                              'isHistory': true,
                              'isMeetDoctor': false
                            });
                      } else if ((items[index]['status'] ==
                              TreatmentStatus.Hospital) &&
                          (items[index]['tpId'] == 'tp005')) {
                        // check is doctor id is null
                        // if doctor id is null mean this case never talk to doctor then no suggstion to show
                        // show api result instead of doctor suggestion
                        Navigator.of(context).pushNamed(
                            PredictionResultPage.routeName,
                            arguments: {
                              'isHistory': true,
                              'isMeetDoctor': false
                            });
                      } else {
                        Navigator.of(context).pushNamed(
                          SuggestionPage.routeName,
                          arguments: items[index]['status'],
                        );
                      }
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
      ),
    );
  }
}
