import 'package:flutter/material.dart';

import '../Widget/sideDrawer.dart';

class PatientInfoPage extends StatefulWidget {
  static const routeName = '/patient-info';

  @override
  _PatientInfoPageState createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      toolbarHeight: 150,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal[800],
              Colors.blue[400],
            ],
          ),
        ),
      ),
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
      endDrawer: SideDrawer(),
      appBar: appBar,
      body: Center(
        child: Text('Patient Info'),
      ),
    );
  }
}
