import 'package:flutter/material.dart';

import './answerQuestionPages.dart';
import '../Models/symptom.dart';
import '../Widget/symptomCard.dart';
import '../Widget/sideDrawer.dart';

class SearchResultPages extends StatefulWidget {
  static const routeName = '/SymptomSearch';
  // final String _searchText;

  // SearchResultPages(this._searchText);

  @override
  _SearchResultPagesState createState() => _SearchResultPagesState();
}

class _SearchResultPagesState extends State<SearchResultPages> {
  final _symptomController = TextEditingController();
  String _searchText;

  final List<Symptom> symptomList = [
    Symptom('001', 'Head drop'),
    Symptom('002', 'Head tilt in order to avoid diplopia'),
    Symptom('003', 'Head tremors'),
    Symptom('004', 'Headache'),
    Symptom('005', 'Forearm pain'),
    Symptom('006', 'Sensory loss in both arms'),
    Symptom('007', 'Paralysis'),
    Symptom('008', 'Chest pain'),
    Symptom('009', 'Back pain'),
    Symptom('010', 'Dizziness'),
    Symptom('011', 'Dry eyes'),
    Symptom('012', 'Dry skin'),
    Symptom('013', 'Rash'),
  ];

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
    final routeArgument =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    _searchText = routeArgument['search'];
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
                  hintText: _searchText,
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
