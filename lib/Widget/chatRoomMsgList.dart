import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    // final userInfo = Provider.of<UserInfo>(context);
    // final chatProvider = Provider.of<ChatRoomProvider>(context);

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

// class ChatRoomMsgList extends StatefulWidget {
//   // final double appBarSize;

//   // ChatRoomMsgList(this.appBarSize);
//   @override
//   _ChatRoomMsgListState createState() => _ChatRoomMsgListState();
// }

// class _ChatRoomMsgListState extends State<ChatRoomMsgList> {
//   ScrollController _scrollController = ScrollController();

//   _scrollToBottom() {
//     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userInfo = Provider.of<UserInfo>(context);
//     final chatProvider = Provider.of<ChatRoomProvider>(context);

//     WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

//     return ListView.builder(
//       controller: _scrollController,
//       itemCount: chatProvider.messages.length,
//       itemBuilder: (ctx, index) {
//         return Container(
//           alignment:
//               chatProvider.messages[index].role == userInfo.role
//                   ? Alignment.centerRight
//                   : Alignment.centerLeft,
//           child: TextBoxItem(
//             userInfo.role,
//             chatProvider.messages[index].role,
//             chatProvider.messages[index].message,
//           ),
//         );
//       },
//     );
//   }
// }