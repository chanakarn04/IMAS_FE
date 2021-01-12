import 'package:flutter/material.dart';

import './answerQuestionPages.dart';
import '../Models/symptom.dart';
import '../Widget/symptomCard.dart';
import '../Widget/sideDrawer.dart';

class SearchResultPages extends StatefulWidget {
  final String _searchText;

  SearchResultPages(this._searchText);

  @override
  _SearchResultPagesState createState() => _SearchResultPagesState(_searchText);
}

class _SearchResultPagesState extends State<SearchResultPages> {
  final _symptomController = TextEditingController();
  String _searchText;

  final List<Symptom> symptomList = [
    Symptom('001', 'Headache'),
    Symptom('002', 'Headband'),
    Symptom('003', 'Armache'),
    Symptom('004', 'Headhoge'),
    Symptom('005', 'Headache 2'),
    Symptom('006', 'Headache 3'),
    Symptom('007', 'Headache 4'),
    Symptom('008', 'Headache 5'),
    Symptom('009', 'Headache 6'),
    Symptom('010', 'Headache 7'),
  ];

  _SearchResultPagesState(this._searchText);

  List<Symptom> searchedSymptom(String _searchText) {
    return symptomList.where((element) {
      String elm = element.name.toLowerCase();
      return elm.contains(_searchText.toLowerCase());
    }).toList();
  }

  void setSearchState(_) {
    setState(() {
      _searchText = _symptomController.text;
    });
  }

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
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
    );
    return Scaffold(
      key: _scaffoldState,
      endDrawer: SideDrawer(),
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.1,
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _symptomController,
                decoration: InputDecoration(
                  hintText: widget._searchText,
                ),
                onSubmitted: (_) {
                  setSearchState(_);
                },
              ),
            ),
            // Text('this is search result'),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.9,
              child: SymptomCard(searchedSymptom(_searchText), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AnswerQuestionPages()),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
