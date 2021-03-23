import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VsCardWidget extends StatelessWidget {
  final Map vitalSign;
  // final int index;

  VsCardWidget(
    this.vitalSign,
    // this.index,
  );

  Widget buildListCard(
    BuildContext context,
    String title,
    Widget child,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Theme.of(context).accentColor,
                  Theme.of(context).primaryColor,
                ],
              ),
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              title,
              // textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24),
            ),
          ),
          Container(
            height: 100,
            child: child,
          ),
        ],
      ),
    );
  }

  Widget buildInfoList({
    String title,
    String unit,
    var value,
  }) {
    String valueText;
    // (value == null) ? valueText = 'No data' : valueText = '$value $unit';
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 3,
      ),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          Expanded(child: Container()),
          (value == null)
              ? Container(
                  width: 80,
                  child: Text(
                    'No data',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$value',
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 10,
                      color: Colors.amber,
                    ),
                    Container(
                      width: 45,
                      child: Text(
                        '$unit',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        margin: EdgeInsets.all(3),
        // height: 200,
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              DateFormat.yMMMEd().format(vitalSign['vsDt']),
              style: TextStyle(
                color: Color.fromARGB(255, 100, 100, 100),
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildInfoList(
                title: 'Body Temperature',
                unit: '°C',
                value: vitalSign['bodyTemp']),
            Divider(
              color: Colors.grey[700],
            ),
            buildInfoList(
                title: 'Heart Rate', unit: 'BPM', value: vitalSign['pulse']),
            Divider(
              color: Colors.grey[700],
            ),
            buildInfoList(
                title: 'Respiratory Rate',
                unit: 'BPM',
                value: vitalSign['respiratRate']),
            Divider(
              color: Colors.grey[700],
            ),
            buildInfoList(
                title: 'Bloodpressure',
                unit: 'mmHg',
                value: vitalSign['bloodPress']),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
