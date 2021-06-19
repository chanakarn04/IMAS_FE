import 'package:flutter/material.dart';
import 'package:homepage_proto/Provider/chatRoom_info.dart';
import 'package:provider/provider.dart';

import './sideDrawer_patient.dart';
import './sideDrawer_doctor.dart';
import '../Provider/user-info.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  Color drOnlineColor = Colors.red;
  String onlineText = 'Offline';

  ChatRoomProvider chatRoomProvider;

  @override
  void didChangeDependencies() {
    chatRoomProvider = Provider.of<ChatRoomProvider>(context);
    if (chatRoomProvider.online) {
      drOnlineColor = Theme.of(context).primaryColor;
      onlineText = 'Online';
    } else {
      drOnlineColor = Colors.red;
      onlineText = 'Offline';
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    return Drawer(child: LayoutBuilder(builder: (ctx, constraints) {
      Widget menuDrawerFlatButton(
        IconData icon,
        String text,
        Function handler,
      ) {
        return TextButton(
          onPressed: handler,
          style: TextButton.styleFrom(primary: Colors.grey[900]),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: constraints.maxHeight * 0.04,
              ),
              SizedBox(width: 10),
              Container(
                height: constraints.maxHeight * 0.03,
                child: FittedBox(child: Text(text)),
              ),
            ],
          ),
        );
      }

      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (userInfo.role == Role.Patient)
              ...buildSideDrawerPatient(context, menuDrawerFlatButton),
            if (userInfo.role == Role.Doctor) ...[
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: drOnlineColor,
                        shape: BoxShape.circle,
                      ),
                      height: constraints.maxHeight * 0.04,
                      width: constraints.maxHeight * 0.04,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: constraints.maxHeight * 0.03,
                      child: FittedBox(
                        child: Text(onlineText),
                      ),
                    ),
                    Expanded(child: Container()),
                    Consumer<ChatRoomProvider>(
                        builder: (context, chatRoomProvider, child) {
                          return Switch(
                            value: chatRoomProvider.online,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (bool newValue) async {
                              if (chatRoomProvider.online) {
                                await chatRoomProvider.triggerDoctorOnline();
                                chatRoomProvider.onReqChatRoom(start: false, userid: userInfo.userId);
                                setState(() {
                                  drOnlineColor = Colors.red;
                                  onlineText = 'Offline';
                                });
                              } else {
                                await chatRoomProvider.triggerDoctorOnline();
                                chatRoomProvider.onReqChatRoom(start: true, userid: userInfo.userId);
                                setState(() {
                                  drOnlineColor = Theme.of(context).primaryColor;
                                  onlineText = 'Online';
                                });
                              }
                            },
                      );
                    }),
                  ],
                ),
              ),
              ...buildSideDrawerDoctor(
                context,
                menuDrawerFlatButton,
                chatRoomProvider.chatRoomRegis,
              ),
            ],
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  size: constraints.maxHeight * 0.05,
                  color: Colors.grey,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          ]);
    }));
  }
}
