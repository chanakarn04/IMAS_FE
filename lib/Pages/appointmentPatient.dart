import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './homePages.dart';
import './chatRoom.dart';

class AppointmentPatientPage extends StatelessWidget {
  static const routeName = '/appointment-Patient';

  // get apDt of last ap and dr Name
  Map data = {
    'apDt': DateTime(2021, 9, 20, 14, 30),
    // 'apDt': DateTime.now().subtract(
    //   Duration(minutes: 5),
    // ),
    'drName': 'Samitanan Techabunyawatthankul',
    'namePrefix': 'Dr.',
  };

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
          onTap: () {
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
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
              'Home',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 20,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: (data.isNotEmpty)
              ? Column(
                  children: [
                    Expanded(
                      child: Container(
                        // color: Colors.white54,
                        padding: const EdgeInsets.all(20.0),
                        // width: double.infinity,
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
                                // '${DateFormat.EEEE().format(data['apDt'])},\n${DateFormat.yMMMMd().format(data['apDt'])}',
                                '${DateFormat.yMMMMd().format(data['apDt'])}',
                                // textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
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
                                  '${DateFormat.jm().format(data['apDt'])}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Container(
                                    // height: 30,
                                    // color: Colors.white54,
                                    child: Text(
                                      '${data['namePrefix']} ${data['drName']}',
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          'assets/images/default_photo.png'),
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // DateTime.now().is
                      child: (DateTime.now().isBefore(data['apDt']))
                          ? Text(
                              'It not the appointment time yet.',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .popAndPushNamed(ChatRoom.routeName);
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
                            ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                )
              : _buildNoapt(context),
        ),
      ),
    );
  }
}
