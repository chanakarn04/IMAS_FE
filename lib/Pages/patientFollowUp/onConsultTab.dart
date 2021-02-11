import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OnConsultTab extends StatefulWidget {
  // final List<Patient>
  final List<Map<String, Object>> infomation;

  OnConsultTab(this.infomation);

  @override
  _OnConsultTabState createState() => _OnConsultTabState();
}

class _OnConsultTabState extends State<OnConsultTab> {
  // final String name = 'f-name';
  // final String surname = 's-name';
  // final String imageAsset = '';
  // final DateTime aptDt;
  // String last_message = 'test last message';
  // DateTime last_messageDt = DateTime.now();

  openModalBottomSheet(String tpId) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            // color: Colors.pink[200],
          ),
          height: 150,
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Column(
            children: [
              FlatButton(
                onPressed: () {
                  print('to patient info with $tpId');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Case Management',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  print('to patient info with $tpId');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Patient Infomation',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPatientBox(String fname, String sname, String imageAsset,
      String lastMessage, DateTime lastMessageDt, String tpId) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            topLeft: Radius.circular(15),
          )),
      child: ListTile(
        onTap: () {
          print('to chat page');
        },
        onLongPress: () {
          openModalBottomSheet(tpId);
        },
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(imageAsset),
            ),
            shape: BoxShape.circle,
            border: Border.all(
              width: 1.5,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          '$fname $sname',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          '$lastMessage \u2022 ${DateFormat.jm().format(lastMessageDt)}',
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final routeArgument =
    //     ModalRoute.of(context).settings.arguments as Map<String, Object>;
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              top: 5,
              // bottom: 5,
              left: 20,
            ),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return buildPatientBox(
                  this.widget.infomation[index]['fname'],
                  this.widget.infomation[index]['sname'],
                  'assets/images/default_photo.png',
                  'test last message',
                  DateTime.now(),
                  this.widget.infomation[index]['tpId'],
                );
              },
              itemCount: this.widget.infomation.length,
            ),
          ),
        ),
        Container(
          height: 2,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}