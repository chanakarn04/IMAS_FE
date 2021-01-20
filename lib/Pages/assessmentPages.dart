import 'package:flutter/material.dart';

import './searchResultPages.dart';
import '../Widget/sideDrawer.dart';

class AssessmentPages extends StatefulWidget {
  static const routeName = '/assessment';
  @override
  _AssessmentPagesState createState() => _AssessmentPagesState();
}

class _AssessmentPagesState extends State<AssessmentPages> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  final _symptomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldState,
      endDrawer: SideDrawer(),
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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // alignment: Alignment.centerRight,
                height: size.height * 0.04,
                child: FittedBox(
                  child: Text(
                    'First, what is your main symptom',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                  height: size.height * 0.03,
                  child: FittedBox(
                      child: Text(
                    'touch the body to choose symptom',
                    style: TextStyle(color: Colors.grey),
                  ))),
              Container(
                  height: size.height * 0.6,
                  child:
                      Image.asset('assets/images/body.png', fit: BoxFit.cover)),
              TextField(
                  decoration:
                      InputDecoration(hintText: 'type your symptom here'),
                  controller: _symptomController,
                  onSubmitted: (_) {
                    // print(_symptomController.text);
                    Navigator.of(context).pushNamed(SearchResultPages.routeName,
                        arguments: {'search': _symptomController.text});
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
