import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/chatRoomMsgList.dart';
import '../Widget/textInputBar.dart';
import '../Widget/noteBottomSheet.dart';
import '../Provider/chatRoom_info.dart';
import '../Provider/user-info.dart';
import '../Pages/PatientInfoPage.dart';
import '../Pages/caseMangementPage.dart';

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
    final userInfo = Provider.of<UserInfo>(context);
    final chatProvider = Provider.of<ChatRoomProvider>(context);

    final String opName = _getOpUserName(chatProvider.opUserId);

    Widget _popUpMenu() {
      return PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text(
              'Patient Info',
            ),
            value: 1,
          ),
          PopupMenuItem(
            child: Text(
              'Case Management',
            ),
            value: 2,
          ),
        ],
        onSelected: (value) {
          if (value == 1) {
            Navigator.of(context).pushNamed(
              PatientInfoPage.routeName,
              arguments: chatProvider.opUserId,
            );
          } else {
            Navigator.of(context).pushNamed(
              CaseManagementPage.routeName,
              arguments: {
                'tpId': chatProvider.opUserId,
                'name': opName,
              },
            );
          }
        },
        child: Icon(
          Icons.more_vert_rounded,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    _noteBottomSheet() {
      return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return NoteBottomSheet();
        },
      );
    }

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
      actions: 
        (userInfo.role == Role.Doctor)
        ? [Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: InkWell(
            onTap: _noteBottomSheet,
            child: Icon(
              Icons.sticky_note_2_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _popUpMenu(),
        ),
      ]
      : [],
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
