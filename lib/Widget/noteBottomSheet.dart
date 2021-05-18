import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/chatRoom_info.dart';
import '../Widget/AdaptiveRaisedButton.dart';
import '../Widget/adaptiveBorderButton.dart';

class NoteBottomSheet extends StatefulWidget {
  @override
  _NoteBottomSheetState createState() => _NoteBottomSheetState();
}

class _NoteBottomSheetState extends State<NoteBottomSheet> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatRoomProvider = Provider.of<ChatRoomProvider>(context, listen: false);
    _textController.text = chatRoomProvider.note;
    _textController.selection = TextSelection.fromPosition(TextPosition(offset: _textController.text.length));
    return Container(
      // height: 250 + MediaQuery.of(context).viewInsets.bottom,
      height: 300,
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
        top: 20,
        bottom: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Note',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            TextField(
              minLines: 1,
              maxLines: 6,
              keyboardType: TextInputType.multiline,
              controller: _textController,
              onSubmitted: (_) {
                chatRoomProvider.updateNote(_textController.text);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdaptiveBorderButton(
                  buttonText: 'Cancle',
                  height: 42,
                  width: 90,
                  handlerFn: () => Navigator.of(context).pop(),
                ),
                SizedBox(
                  width: 20,
                ),
                AdaptiveRaisedButton(
                  buttonText: 'Save',
                  height: 32,
                  width: 90,
                  handlerFn: () {
                    chatRoomProvider.updateNote(_textController.text);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
