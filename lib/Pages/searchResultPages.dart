import 'package:flutter/material.dart';

import '../Models/symptom.dart';
import '../Widget/symptomCard.dart';

class SearchResultPages extends StatelessWidget {
  final String searchText;

  final List<Symptom> symptomList = [
    Symptom('001', 'Headache'),
    Symptom('002', 'Headband'),
    Symptom('003', 'Armache'),
  ];

  SearchResultPages(this.searchText);

  List<Symptom> searchedSymptom(String searchText) {
    return symptomList.where((element) {
      String elm = element.name.toLowerCase();
      return elm.contains(searchText.toLowerCase());
    }).toList();
  }

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
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
          child: Text('IMAS'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu_rounded,
            ),
            onPressed: () {
              _scaffoldState.currentState.openEndDrawer();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: searchText,
              ),
            ),
          ),
          // Text('this is search result'),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: SymptomCard(searchedSymptom(searchText), () {
              print('To answering Question');
            }),
          )
        ],
      ),
    );
  }
}
