import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

import './homePages.dart';
import './chatRoom.dart';
import '../Provider/vitalSign_Info.dart';
// import '../Provider/user-info.dart';

class AppointmentPatientPage extends StatelessWidget {
  static const routeName = '/appointment-Patient';

  // Map data = {};

  Map _loadData(
      // String userId,
      ) {
    // load data from server
    // get apDt of last ap and dr Name

    Map data = {
      // 'apDt': DateTime(2021, 9, 20, 14, 30),
      'apDt': DateTime.now(),
      'drName': 'dName dSurname',
      'namePrefix': 'Dr.',
    };
    return data;
  }

  Widget _buildNoapt(BuildContext context) {
    final vitalSign = Provider.of<VitalSignProvider>(context);
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
    // final userInfo = Provider.of<UserInfo>(context);
    final Map data = _loadData(
        // userInfo.userId
        );
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
                                '${DateFormat.yMMMMd().format(data['apDt'])}',
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
                                    child: Text(
                                      '${data['namePrefix']} ${data['drName']}',
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 18,
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
                      child:
                          ((DateTime.now().difference(data['apDt']).inMinutes >=
                                      0) &&
                                  (DateTime.now()
                                          .difference(data['apDt'])
                                          .inMinutes <=
                                      30))
                              ? InkWell(
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
                                )
                              : Text(
                                  'It not the appointment time yet.',
                                  style: TextStyle(
                                    color: Colors.white,
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
