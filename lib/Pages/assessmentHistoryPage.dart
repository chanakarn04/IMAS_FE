import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './detailAssessHist.dart';
import '../Provider/user-info.dart';
import '../Provider/assessmentHistory.dart';
import '../Models/model.dart';

class AssessmentHistoryPage extends StatefulWidget {
  static const routeName = '/assessment history';

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
    items = assessmentHistoryProvider.assessmentHistoryData;
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
                  alignment: Alignment.center,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        margin: (index == 0)
                            ? EdgeInsets.only(top: 10, bottom: 3)
                            : (index == items.length - 1)
                                ? EdgeInsets.only(top: 3, bottom: 10)
                                : EdgeInsets.symmetric(vertical: 3),
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
                                  style: TextStyle(fontSize: 24),
                                ),
                                Text(
                                  '${DateFormat.yMMMd().format(items[index]['date'])}   ${DateFormat.jm().format(items[index]['date'])}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 30),
                                _buildStatusBox(
                                    context,
                                    _statusInfo(context, items[index]['tpStatus'])),
                              ],
                            ),
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    DetailAssessmentHistory.routeName,
                                    arguments: items[index]);
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
