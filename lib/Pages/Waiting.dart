import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './chatRoom.dart';
import '../Provider/user-info.dart';
import '../Provider/chatRoom_info.dart';

class WaitingPage extends StatelessWidget {
  static const routeName = '/wait';

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatRoomProvider>(context);
    print(chatProvider.chatRoomId);
    // chatProvider.chatRequest(Role.Patient);
    // chatProvider.chatRequest();
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
          child: Text('IMAS'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.transparent,
            ),
            onPressed: () {
              // test
              // chatProvider.chatRequest(Role.Patient);
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 81, 195, 169),
              Color.fromARGB(255, 76, 159, 205),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Expanded(child: Container()),
              Icon(
                Icons.access_time_rounded,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * 0.5,
              ),
              Text(
                'Please wait',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'We have sent request to the doctor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              Expanded(child: Container()),
              if (chatProvider.chatRoomId != '') InkWell(
                  onTap: () {
                    // ...
                    Navigator.of(context).pushReplacementNamed(ChatRoom.routeName);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Text(
                      'Meet Doctor',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}