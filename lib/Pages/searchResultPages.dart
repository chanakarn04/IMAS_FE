import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './answerQuestionPages.dart';
import '../Widget/symptomCard.dart';
import '../Widget/sideDrawer.dart';
import '../Provider/user-info.dart';
import '../Provider/symptomAssessment.dart';

class SearchResultPages extends StatefulWidget {
  static const routeName = '/SymptomSearch';
  // final String _searchText;

  // SearchResultPages(this._searchText);

  @override
  _SearchResultPagesState createState() => _SearchResultPagesState();
}

class _SearchResultPagesState extends State<SearchResultPages> {
  final _symptomController = TextEditingController();
  // String _searchText;
  var _loadedData = false;
  String phrase = 'test';
  List<Map<String, dynamic>> symptomList = [];
  // Color tempColor = Colors.red;
  // String searchText;

  @override
  void didChangeDependencies() async {
    // print(phrase);
    if (!_loadedData) {
      phrase = ModalRoute.of(context).settings.arguments as String;
      final symptomAssessment =
          Provider.of<SymptomAssessmentProvider>(context, listen: false);
      await symptomAssessment.searchSymptom(phrase);
      _symptomController.text = phrase;
      _loadedData = true;
    }
    super.didChangeDependencies();
  }

  // final List<Symptom> symptomList = dummy_symptoms;

  // List<Symptom> searchedSymptom(String _searchText) {
  //   return symptomList.where((element) {
  //     String elm = element.name.toLowerCase();
  //     return elm.contains(_searchText.toLowerCase());
  //   }).toList();
  // }

  // void setSearchState(SymptomAssessmentProvider sap) {
  //   setState(() {
  //     // symptomList = sap.searchSymptom(_symptomController.text);
  //     symptomList = [
  //       {
  //         'id': 's_13',
  //         'label': 'Broken heart boy',
  //       },
  //       {
  //         'id': 's_169',
  //         'label': 'Burn but fine',
  //       },
  //     ];
  //   });
  // }

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context, listen: false);
    final symptomAssessment =
        Provider.of<SymptomAssessmentProvider>(context);
    // String searchText = ModalRoute.of(context).settings.arguments as String;
    // _symptomController.text = searchText;
    // phrase = searchText;

    // symptomAssessment.init(userInfo.userId);
    // setState(() {
    //   _symptomController.text = phrase;
    //   symptomList = symptomAssessment.searchSymptom(phrase);
    // });

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
            color: Colors.transparent,
          ),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      // key: _scaffoldState,
      // endDrawer: SideDrawer(),
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
                onSubmitted: (_) {
                  setState(() {
                    symptomAssessment.symptomSearchList = [];
                    symptomAssessment.searchSymptom(phrase);
                    phrase = _symptomController.text;
                  });
                },
              ),
            ),
            // Text('this is search result'),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.9,
              child: (symptomAssessment.symptomSearching)
                  ? Center(
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator(
                          strokeWidth: 6.0,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      ),
                    )
                  : SymptomCard(symptomAssessment.symptomSearchList),
            )
          ],
        ),
      ),
    );
  }
}
