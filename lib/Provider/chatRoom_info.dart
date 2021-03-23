import 'package:flutter/foundation.dart';
// import 'package:socket_io_client/socket_io_client.dart';

// import '../Models/model.dart';
import './user-info.dart';

class ChatMessage {
  final String message;
  // final String userID;
  final Role role;

  ChatMessage({
    // @required this.userID,
    @required this.message,
    @required this.role,
  });
}

class ChatRoomProvider with ChangeNotifier {
  String chatRoomId = '';
  List<ChatMessage> messages = [];
  String opUserId = '';

  void chatRequest() {
    // in patient send userId to request
    // ...

    // in doctor trigger status to online to request
    // ...

    // if chat Room was create will get notification
    // NOTIFICATION??
    // get chatRoomId
    chatRoomId = 'x000yx000y';
    // get opposite User id
    opUserId = 'x0001';
    // notifyListeners();
  }

  void chatRegistor() {
    // ... ???
  }

  void sendMessage(
    String userId,
    String messageText,
    Role role,
  ) {
    ChatMessage message = ChatMessage(
      // userID: userId,
      message: messageText,
      role: role,
    );
    // add message to list
    messages.add(message);
    // upload to server
    // ...
    notifyListeners();
  }

  void recieveMessage() {
    // recieve message
    // ... how?

    // expected data
    Map data = {
      'chatRoomId': 'x000yx000y',
      'message': 'hello',
      'role': Role.Doctor
    };
    ChatMessage message =
        ChatMessage(message: data['message'], role: data['role']);
    messages.add(message);
    notifyListeners();
  }
}
