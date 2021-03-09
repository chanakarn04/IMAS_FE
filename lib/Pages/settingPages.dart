import 'package:flutter/material.dart';

import './loginPage.dart';

class SettingPages extends StatelessWidget {
  static const routeName = '/setting';

  _showMyDialog() {}

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
          child: Text('Setting'),
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
        padding: EdgeInsets.only(
          bottom: 25,
          left: 15,
          right: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlatButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Logout?',
                      ),
                      content: Text(
                        'Confirm to logout?',
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName('/'));
                            Navigator.of(context)
                                .pushNamed(LogInPage.routeName);
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).primaryColor,
                  size: 40,
                ),
                title: Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
