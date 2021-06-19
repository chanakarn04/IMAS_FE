import 'package:flutter/material.dart';

class WaitChatroomCreating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Expanded(child: Container()),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Creating chatroom',
              style: TextStyle(color: Colors.grey),
            ),
            Expanded(child: Container()),
          ],
        ),
      );
  }
}
