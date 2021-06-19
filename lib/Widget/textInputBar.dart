import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/user-info.dart';
import '../Provider/chatRoom_info.dart';

class TextInputBar extends StatefulWidget {
  final Role role;
  final String userName;
  TextInputBar({
    this.role,
    this.userName,
  });
  @override
  _TextInputBarState createState() => _TextInputBarState();
}

class _TextInputBarState extends State<TextInputBar> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatRoomProvider>(context);
    return Container(
      alignment: Alignment.bottomCenter,
      height: 60,
      padding: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.only(left: 10, top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Aa',
                  ),
                  controller: _textController,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send_rounded,
              color: Colors.white,
            ),
            onPressed: () async {
              if (_textController.text.isNotEmpty) {
                final tempMessage = _textController.text;
                await chatProvider.sendMessage(
                  message: tempMessage,
                  role: this.widget.role,
                  userId: this.widget.userName,
                );
                _textController.clear();
                FocusScope.of(context).unfocus();
              }
            },
          )
        ],
      ),
    );
  }
}
