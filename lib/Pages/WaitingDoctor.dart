import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chatRoom.dart';
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
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).padding.top + 10,
          horizontal: 5,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              child: InkWell(
                child: Icon(
                  Icons.home_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Expanded(child: Container()),
            Container(
              height: MediaQuery.of(context).size.width - 100,
              width: MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/images/queuing.png',
                  ),
                ),
              ),
            ),
            Text(
              !(chatProvider.chatRoomId != '')
                  ? 'You\'re in queue'
                  : 'Found doctor for you',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              !(chatProvider.chatRoomId != '')
                  ? 'We have sent your request to the doctor'
                  : '',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(child: Container()),
            (chatProvider.chatRoomId != '')
                ? InkWell(
                    onTap: () {
                      // ...
                      Navigator.of(context)
                          .pushReplacementNamed(ChatRoom.routeName);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Text(
                        'Meet Doctor',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      // ...
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Are you sure to cancel queue?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                 TextButton(
                                  onPressed: () {
                                    chatProvider.patientDeleteQueue();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
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
    );
  }
}
