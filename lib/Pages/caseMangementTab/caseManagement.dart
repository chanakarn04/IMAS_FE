import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../closeCasePage.dart';
import '../../Widget/caseManagementCreateAppointment.dart';
import '../../Provider/caseManagement_Info.dart';
import '../../Provider/chatRoom_info.dart';
import '../../Provider/user-info.dart';

class CaseManagementTab extends StatefulWidget {
  @override
  _CaseManagementTabState createState() => _CaseManagementTabState();
}

class _CaseManagementTabState extends State<CaseManagementTab> {
  var _loadedData = false;
  int selectIndex;

  // init case management index
  @override
  void didChangeDependencies() {
    if (!_loadedData) {
      selectIndex = 0;
    }
    super.didChangeDependencies();
  }

  Widget _buildBox({
    String title,
    String description,
    int selfIndex,
    int selectingIndex,
  }) {
    return InkWell(
      onTap: () {
        if (selectIndex == selfIndex) {
          setState(() {
            selectIndex = 0;
          });
        } else {
          setState(() {
            selectIndex = selfIndex;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: (selectingIndex == selfIndex)
              ? Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                )
              : Border.all(
                  color: Colors.grey[400],
                  width: 2,
                ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 30,
              width: 30,
              decoration: (selectingIndex == selfIndex)
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    )
                  : BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cmInfo = Provider.of<CMinfoProvider>(context, listen: false);
    final chatroom = Provider.of<ChatRoomProvider>(context);
    final userInfo = Provider.of<UserInfo>(context);
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 15,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: InkWell(
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Conclude',
              style: TextStyle(
                fontSize: 32,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Select one of the options below to end the consultation',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: _buildBox(
              title: 'Critical',
              description:
                  'Patient get more serious illness, should to be treated ugmently',
              selectingIndex: selectIndex,
              selfIndex: 1,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: _buildBox(
              title: 'Recovered',
              description:
                  'Patient has no longer illness or can be cured by him/herself',
              selectingIndex: selectIndex,
              selfIndex: 2,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: _buildBox(
              title: 'Continue follow up',
              description: 'Create an appointment to follow up symtoms',
              selectingIndex: selectIndex,
              selfIndex: 3,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            alignment: Alignment.centerRight,
            child: (selectIndex != 0)
                ? InkWell(
                    onTap: () async {
                      // close case as critical
                      if (selectIndex == 1) {
                        Navigator.of(context).popAndPushNamed(
                          CloseCasePage.routneName,
                          arguments: {
                            'name': cmInfo.pName,
                            'closeCase': true,
                          },
                        );
                        await chatroom.deleteChatroom();
                        await cmInfo.upload(chatroom.apid, chatroom.note, 0);
                        await userInfo.updatePlan(chatroom.tpid, 2);
                        chatroom.closeChat();
                        cmInfo.cleanDispose();
                      // close case as cured
                      } else if (selectIndex == 2) {
                        Navigator.of(context).popAndPushNamed(
                          CloseCasePage.routneName,
                          arguments: {
                            'name': cmInfo.pName,
                            'closeCase': true,
                          },
                        );
                        await chatroom.deleteChatroom();
                        await cmInfo.upload(chatroom.apid, chatroom.note, 0);
                        await userInfo.updatePlan(chatroom.tpid, 1);
                        chatroom.closeChat();
                        cmInfo.cleanDispose();
                      } else {
                        // close this appointment and create next appointment
                        showModalBottomSheet(
                          context: context,
                          isDismissible: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return CaseManagementCreateAppointment([]);
                          },
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
