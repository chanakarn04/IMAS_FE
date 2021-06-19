import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/caseManagement_Info.dart';
import '../../Widget/caseMangementListitemBox.dart';
import '../../Widget/caseMangementListConditionBox.dart';

class CMDiseaseSymptomTab extends StatefulWidget {
  @override
  _CMDiseaseSymptomTabState createState() => _CMDiseaseSymptomTabState();
}

class _CMDiseaseSymptomTabState extends State<CMDiseaseSymptomTab> {
  @override
  Widget build(BuildContext context) {
    final cmInfo = Provider.of<CMinfoProvider>(context);

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 15,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: InkWell(
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: CaseManagementListConditionBox(
                title: 'Disease',
                description: 'Detected diseases',
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: CaseManagementListItemBox(
                caseIndex: 'symptom',
                title: 'Symptom',
                description: 'Detected symptoms',
                items: cmInfo.symptoms,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
