import 'package:flutter/material.dart';

import '../Models/disease.dart';
import '../Widget/diseaseDetailCard.dart';

class DiseaseDetailPages extends StatelessWidget {
  static const routeName = '/disease-detail';
  // final Disease disease;

  // DiseaseDetailPages({
  //   this.disease,
  // });

  @override
  Widget build(BuildContext context) {
    final disease = ModalRoute.of(context).settings.arguments as Disease;
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
            description: disease.description,
            cause: disease.cause,
            treatment: disease.treatment,
          ),
        ),
      ),
    );
  }
}
