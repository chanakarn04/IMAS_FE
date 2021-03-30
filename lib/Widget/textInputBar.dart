import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/user-info.dart';
import '../Provider/chatRoom_info.dart';

class TextInputBar extends StatefulWidget {
  @override
  _TextInputBarState createState() => _TextInputBarState();
}

class _TextInputBarState extends State<TextInputBar> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    final chatProvider = Provider.of<ChatRoomProvider>(context);

    _sendConversation() {
      if (_textController.text.isEmpty) {
        return;
      } else {
        chatProvider.sendMessage(
          userInfo.userId,
          _textController.text,
          userInfo.role,
        );
        _textController.clear();
        FocusScope.of(context).unfocus();
      }
    }
    return Container(
      alignment: Alignment.bottomCenter,
      height: 50,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // IconButton(
          //   icon: Icon(
          //     Icons.image_outlined,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     print('Select image');
          //   },
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.only(
                  left: 10,
                  top: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                // width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Aa',
                  ),
                  controller: _textController,
                  onSubmitted: _sendConversation(),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              _sendConversation();
            },
          )
        ],
      ),
    );
  }
}