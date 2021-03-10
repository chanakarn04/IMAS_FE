import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './route.dart';
import 'Provider/user-info.dart';

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
