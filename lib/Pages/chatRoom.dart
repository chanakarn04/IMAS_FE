import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/chatRoomMsgList.dart';
import '../Widget/textInputBar.dart';
import '../Provider/chatRoom_info.dart';

class ChatRoom extends StatelessWidget {
  static const routeName = '/CharRoom';

  String _getOpUserName(
    String opUserId,
  ) {
    // request for opposite user name
    final String opUserName = 'Name Surname';
    return opUserName;
  }

  @override
  Widget build(BuildContext context) {
    // final userInfo = Provider.of<UserInfo>(context);
    final chatProvider = Provider.of<ChatRoomProvider>(context);

    final String opName = _getOpUserName(chatProvider.opUserId);

    final appBar = AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop()),
      title: Row(
        children: <Widget>[
          Container(
            height: 58,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/default_photo.png'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.5,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(opName),
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: SizedBox(
          height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              Expanded(child: ChatRoomMsgList()),
              TextInputBar(),
            ],
          ),
        ),
      ),
    );
  }
}
