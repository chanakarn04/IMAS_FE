import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Pages/PatientInfoPage.dart';
import '../Pages/chatRoom.dart';

class PatientBox extends StatelessWidget {
  final String pName;
  final String pid;
  final String imageAsset;
  final DateTime aptDt;
  final String tpId;

  PatientBox({
    @required this.pName,
    @required this.pid,
    @required this.imageAsset,
    @required this.aptDt,
    @required this.tpId,
  });

  final boxShadows = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      spreadRadius: 3,
      blurRadius: 5,
      offset: Offset(0, 3), // changes position of shadow
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var todayApt;
    Color boxColor;
    Color mainTextColor;
    Color subTextColor;
    if (aptDt.difference(DateTime.now()).inMinutes >= 0 &&
        aptDt.difference(DateTime.now()).inMinutes <= 30) {
      boxColor = Color.fromARGB(255, 195, 81, 81);
      mainTextColor = Colors.white;
      subTextColor = Colors.white;
      todayApt = true;
    } else {
      boxColor = Colors.white;
      mainTextColor = Colors.black;
      subTextColor = Colors.grey;
      todayApt = false;
    }
    // (element['apDt'].difference(DateTime.now()).inMinutes >= 0 && element['apDt'].difference(DateTime.now()).inMinutes <=30)
    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadows,
        borderRadius: BorderRadius.circular(15),
        color: boxColor,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 17,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 2.5,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pName,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 20,
                    color: mainTextColor,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  (todayApt)
                      ? 'In chat'
                      : DateFormat.yMMMMd().add_jm().format(aptDt),
                  style: TextStyle(
                    fontSize: 16,
                    color: subTextColor,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
          InkWell(
              child: Icon(
                (todayApt)
                    ? Icons.chat_bubble_outline_rounded
                    : Icons.arrow_forward_ios_rounded,
                color: (todayApt) ? mainTextColor : Colors.grey,
                size: 28,
              ),
              onTap: () {
                (todayApt)
                    ? Navigator.of(context).pushNamed(ChatRoom.routeName)
                    : Navigator.of(context)
                        .pushNamed(PatientInfoPage.routeName, arguments: {
                          'tpid': tpId,
                          'pid': pid,
                          'pName': pName,
                        });
              }),
        ],
      ),
    );
  }
}
