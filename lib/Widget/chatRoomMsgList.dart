import 'package:flutter/material.dart';

import '../Provider/user-info.dart';
import '../Provider/chatRoom_info.dart';
import '../Widget/textBoxItem.dart';

class ChatRoomMsgList extends StatelessWidget {
  final List<ChatMessage> messageList;
  final Role userRole;

  ChatRoomMsgList({this.messageList, this.userRole});

  final ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return ListView.builder(
      controller: _scrollController,
      itemCount: messageList.length,
      itemBuilder: (ctx, index) {
        return Container(
          alignment: messageList[index].role == userRole
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: TextBoxItem(
            userRole,
            messageList[index].role,
            messageList[index].message,
          ),
        );
      },
    );
  }
}