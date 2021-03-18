import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/caseManagement_Info.dart';
import '../../Widget/caseMangementListitemBox.dart';

class CMDiseaseSymptomTab extends StatefulWidget {
  @override
  _CMDiseaseSymptomTabState createState() => _CMDiseaseSymptomTabState();
}

class _CMDiseaseSymptomTabState extends State<CMDiseaseSymptomTab> {
  @override
  Widget build(BuildContext context) {
    final cmInfo = Provider.of<CMinfoProvider>(context);

    return Container(
      padding: EdgeInsets.only(
        top: 15,
        // left: 20,
        // bottom: 20,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: CaseManagementListItemBox(
                caseIndex: 'disease',
                title: 'Disease',
                items: cmInfo.condition,
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
                items: cmInfo.symptoms,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 2,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
