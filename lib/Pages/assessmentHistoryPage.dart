import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './predictionResultPage.dart';

class AssessmentHistoryPage extends StatefulWidget {
  static const routeName = '/assessment history';
  final String pId = 'p001';

  @override
  _AssessmentHistoryPageState createState() => _AssessmentHistoryPageState();
}

class _AssessmentHistoryPageState extends State<AssessmentHistoryPage> {
  List<Map<String, Object>> items = [
    {
      'symptom': 'Headache',
      'date': DateTime.now(),
    },
    {
      'symptom': 'Forearm pain',
      'date': DateTime(2020, 12, 10),
    },
    {
      'symptom': 'Dizziness',
      'date': DateTime(2020, 11, 28),
    },
  ];
  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: Text(
                  items[index]['symptom'],
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  '${DateFormat.yMMMd().format(items[index]['date'])}   ${DateFormat.jm().format(items[index]['date'])}',
                ),
                trailing: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(PredictionResultPage.routeName);
                  },
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 36,
                  ),
                ),
              ),
            );
          },
          itemCount: items.length,
        ),
      ),
    );
  }
}
