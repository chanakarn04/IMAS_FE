import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/diseaseDetailCard.dart';
import '../Provider/symptomAssessment.dart';
// import '../Script/socketioScript.dart';

class DiseaseDetailPages extends StatelessWidget {
  static const routeName = '/disease-detail';
  // final Disease disease;

  // DiseaseDetailPages({
  //   this.disease,
  // });

  @override
  Widget build(BuildContext context) {
    final cid = ModalRoute.of(context).settings.arguments as String;
    final symptomAssessment = Provider.of<SymptomAssessmentProvider>(context);
    symptomAssessment.getMoreConditionDetail(cid);
    // final condition = _loadData(cid);
    final appBar = AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop()),
      title: Container(
        alignment: Alignment.center,
        child: Text('IMAS'),
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
      body: (symptomAssessment.conditionDetailLoading)
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
          : Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor
                  ])),
              child: Center(
                // child: DiseaseDetailCard(
                //   name: condition['dName'],
                //   description: condition['description'],
                //   cause: condition['cause'],
                //   treatment: condition['treatment'],
                // ),
              ),
            ),
    );
  }
}
