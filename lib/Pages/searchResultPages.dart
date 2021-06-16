import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/symptomCard.dart';
import '../Provider/user-info.dart';
import '../Provider/symptomAssessment.dart';

class SearchResultPages extends StatefulWidget {
  static const routeName = '/SymptomSearch';

  @override
  _SearchResultPagesState createState() => _SearchResultPagesState();
}

class _SearchResultPagesState extends State<SearchResultPages> {
  final _symptomController = TextEditingController();
  var _loadedData = false;
  String phrase = 'test';
  List<Map<String, dynamic>> symptomList = [];

  @override
  void didChangeDependencies() async {
    if (!_loadedData) {
      phrase = ModalRoute.of(context).settings.arguments as String;
      final symptomAssessment = Provider.of<SymptomAssessmentProvider>(context, listen: false);
      await symptomAssessment.searchSymptom(phrase);
      _symptomController.text = phrase;
      _loadedData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final symptomAssessment = Provider.of<SymptomAssessmentProvider>(context);
    final appBar = AppBar(
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
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
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) * 0.1,
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
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) * 0.9,
              child: (symptomAssessment.symptomSearching)
                  ? Center(
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator(
                          strokeWidth: 6.0,
                          valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
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
