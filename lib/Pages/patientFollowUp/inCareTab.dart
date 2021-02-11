import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InCareTab extends StatefulWidget {
  // final List<Patient>
  final List<Map<String, Object>> infomation;

  InCareTab(this.infomation);

  @override
  _InCareTabState createState() => _InCareTabState();
}

class _InCareTabState extends State<InCareTab> {
  // final String name = 'f-name';
  // final String surname = 's-name';
  // final String imageAsset = '';
  // final DateTime aptDt;
  // String last_message = 'test last message';
  // DateTime last_messageDt = DateTime.now();

  Widget buildPatientBox(
    String fname,
    String sname,
    String imageAsset,
    DateTime aptDt,
  ) {
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
          // '${DateFormat.jm().format(aptDt)} ${DateFormat.yMMMEd().format(aptDt)}',
          '${DateFormat.yMMMEd().format(aptDt)}',
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
                    this.widget.infomation[index]['aptDt'],
                  );
                },
                itemCount: this.widget.infomation.length,
              )),
        ),
        Container(
          height: 2,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
