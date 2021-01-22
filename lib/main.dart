import 'package:flutter/material.dart';

import './Pages/homePages.dart';
import './Pages/assessmentPages.dart';
import './Pages/searchResultPages.dart';
import './Pages/answerQuestionPages.dart';
import './Pages/profilePages.dart';
import './Pages/chatRoom.dart';
import './Pages/nearbyHospitalPages.dart';
import './Pages/settingPages.dart';
import './Pages/vitalSignStartPages.dart';
import './Pages/vitalSign/vs_BodyTempPage.dart';
import './Pages/vitalSign/vs_HeartRatePage.dart';
import './Pages/vitalSign/vs_RespiratoryRatePage.dart';
import './Pages/vitalSign/vs_BloodPressurePage.dart';
import './Pages/painScoreStartPage.dart';
import './Pages/painScorePage.dart';
import './Pages/assessmentHistoryPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMAS',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 81, 195, 169),
        primaryColorDark: Color.fromARGB(255, 38, 117, 99),
        primaryColorLight: Color.fromARGB(255, 133, 255, 226),
        accentColor: Color.fromARGB(255, 77, 159, 206),
      ),
      // home: HomePage(),
      color: Color.fromARGB(255, 255, 255, 255),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (ctx) => HomePage(),
        AssessmentPages.routeName: (ctx) => AssessmentPages(),
        AssessmentHistoryPage.routeName: (ctx) => AssessmentHistoryPage(),
        SearchResultPages.routeName: (ctx) => SearchResultPages(),
        AnswerQuestionPages.routeName: (ctx) => AnswerQuestionPages(),
        ProfilePages.routeName: (ctx) => ProfilePages(),
        ChatRoom.routeName: (ctx) => ChatRoom(),
        NearbyHospitalPages.routeName: (ctx) => NearbyHospitalPages(),
        SettingPages.routeName: (ctx) => SettingPages(),
        VitalSignStartPage.routeName: (ctx) => VitalSignStartPage(),
        VSBodyTempPage.routeName: (ctx) => VSBodyTempPage(),
        VSHeartRatePage.routeName: (ctx) => VSHeartRatePage(),
        VSRespiratoryRatePage.routeName: (ctx) => VSRespiratoryRatePage(),
        VSBloodPressurePage.routeName: (ctx) => VSBloodPressurePage(),
        PainScoreStartPage.routeName: (ctx) => PainScoreStartPage(),
        PainScorePage.routeName: (ctx) => PainScorePage(),
      },
    );
  }
}
