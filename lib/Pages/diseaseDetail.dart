import 'package:flutter/material.dart';

import '../Widget/diseaseDetailCard.dart';

class DiseaseDetailPages extends StatelessWidget {
  static const routeName = '/disease-detail';
  // final Disease disease;

  // DiseaseDetailPages({
  //   this.disease,
  // });

  Map _loadData(
    String cid,
  ) {
    //...

    final data = {
      'cid': 'c0001',
      'dName': 'Tension Headache',
      'description':
          'Pain associated with muscle used and working. pain seem to be aggravated over the day and can relieved by rest.',
      'treatment': ['Medication', 'Rest'],
      'cause':
          'Tension headaches are caused by muscle contractions in the head and neck regions. These types of contractions can be caused by a variety of foods, activities and stressors. Some people develop tension headaches after staring at a computer screen for a long time or after driving for long periods. Cold temperatures may also trigger a tension headache.',
    };

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final cid = ModalRoute.of(context).settings.arguments as String;
    final condition = _loadData(cid);
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
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor
            ])),
        child: Center(
          child: DiseaseDetailCard(
            name: condition['dName'],
            description: condition['description'],
            cause: condition['cause'],
            treatment: condition['treatment'],
          ),
        ),
      ),
    );
  }
}
