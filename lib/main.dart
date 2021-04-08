import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './route.dart';
import './Provider/user-info.dart';
import './Provider/caseManagement_Info.dart';
import './Provider/vitalSign_Info.dart';
import './Provider/chatRoom_info.dart';
import './Provider/symptomAssessment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserInfo(),
        ),
        ChangeNotifierProvider(
          create: (context) => CMinfoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VitalSignProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatRoomProvider(),
        ),
          ChangeNotifierProvider(create: (context) => SymptomAssessmentProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'IMAS',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 81, 195, 169),
          primaryColorDark: Color.fromARGB(255, 38, 117, 99),
          primaryColorLight: Color.fromARGB(255, 133, 255, 226),
          accentColor: Color.fromARGB(255, 77, 159, 206),
        ),
        // home: HomePage(),
        color: Color.fromARGB(255, 255, 255, 255),
        initialRoute: Routes.initPageRoute(),
        routes: Routes.routes(),
      ),
    );
  }
}
