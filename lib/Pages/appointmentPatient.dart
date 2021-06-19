import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './homePages.dart';
import './chatRoom.dart';
import '../Provider/user-info.dart';
import '../Provider/chatRoom_info.dart';

class AppointmentPatientPage extends StatefulWidget {
  static const routeName = '/appointment-Patient';

  @override
  _AppointmentPatientPageState createState() => _AppointmentPatientPageState();
}

class _AppointmentPatientPageState extends State<AppointmentPatientPage> {
  var _loadedData = false;
  Map<String, dynamic> apt;

  @override
  void didChangeDependencies() {
    if (!_loadedData) {
      final userInfo = Provider.of<UserInfo>(context);
      userInfo.updatePatientLastApt();
      _loadedData = true;
    }
    super.didChangeDependencies();
  }

  Widget _buildNoapt(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              'You have no appointment yet.',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => Navigator.of(context).pushReplacementNamed(HomePage.routeName),
          child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            alignment: Alignment.center,
            child: Text(
              'Home',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 20,
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    final chatroom = Provider.of<ChatRoomProvider>(context);
    apt = userInfo.lastApt;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pop()),
        title: Container(
          alignment: Alignment.center,
          child: Text('Medical consult'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.transparent,
            ),
            onPressed: null,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: (apt.isNotEmpty)
              ? Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'You have appointment on',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${DateFormat.yMMMMd().format(apt['aptDate'])}',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'at  ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  '${DateFormat.jm().format(apt['aptDate'])}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: ((DateTime.parse(apt['aptDate'].toString()).difference(DateTime.now()).inMinutes - 390 >= 0) &&
                              (DateTime.parse(apt['aptDate'].toString()).difference(DateTime.now()).inMinutes - 390 <= 30))
                          ? (chatroom.chatRoomRegis)
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context).popAndPushNamed(ChatRoom.routeName);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Chatroom',
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  'Doctor has not open chat yet.',
                                  style: TextStyle(color: Colors.white),
                                )
                          : Text(
                              'It not the appointment time yet.',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                    SizedBox(height: 15),
                  ],
                )
              : _buildNoapt(context),
        ),
      ),
    );
  }
}
