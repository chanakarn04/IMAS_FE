import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/chatRoom_info.dart';

class WaitChatroomCreating extends StatelessWidget {
  // static const routeName = 'waitingChatroomCreating';
  @override
  Widget build(BuildContext context) {
    // final chatProvider = Provider.of<ChatRoomProvider>(context);
    // return Scaffold(
    //   body: Center(
    //     child: Column(
    //       children: [
    //         Expanded(child: Container()),
    //         SizedBox(
    //           height: MediaQuery.of(context).size.width * 0.4,
    //           width: MediaQuery.of(context).size.width * 0.4,
    //           child: CircularProgressIndicator(
    //             strokeWidth: 4.0,
    //             valueColor: new AlwaysStoppedAnimation<Color>(
    //                 Theme.of(context).primaryColor),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Text(
    //           'Creating chatroom',
    //           style: TextStyle(color: Colors.grey),
    //         ),
    //         Expanded(child: Container()),
    //       ],
    //     ),
    //   ),
    // );
    return Center(
        child: Column(
          children: [
            Expanded(child: Container()),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
