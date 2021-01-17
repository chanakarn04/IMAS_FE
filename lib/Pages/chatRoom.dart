import 'package:flutter/material.dart';

import '../Widget/textBoxItem.dart';
import '../Models/conversation.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final _textController = TextEditingController();
  final listScrollController = new ScrollController();

  ScrollController _scrollController = ScrollController();

  final List<Conversation> conversationList = [
    Conversation(1, 'Hi, How can i help you'),
    Conversation(0, 'Mr.Harold, I dont feel so well'),
    Conversation(0, 'I dont like sand'),
  ];

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void initState() {
    super.initState();
  }

  _sendConversation() {
    if (_textController.text.isEmpty) {
      return;
    } else {
      setState(() {
        conversationList.add(Conversation(0, _textController.text));
      });
      _textController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

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
              backgroundImage: AssetImage('assets/images/doctor.png'),
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
          Text('Doctor Harold')
        ],
      ),
    );

    final textInputBar = Container(
      alignment: Alignment.bottomCenter,
      height: 50,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.image_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              print('Select image');
            },
          ),
          Padding(
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
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Aa',
                ),
                controller: _textController,
                onSubmitted: _sendConversation(),
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

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).viewInsets.bottom -
                  50),
              child: ListView.builder(
                controller: _scrollController,
                // reverse: true,
                itemCount: conversationList.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    alignment: conversationList[index].role == 0
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: TextBoxItem(conversationList[index].role,
                        conversationList[index].msg),
                  );
                },
              ),
            ),
            textInputBar,
          ],
        ),
      ),
    );
  }
}
