import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SuggestionCardContent extends StatelessWidget {
  final List data;
  final int index;

  SuggestionCardContent({
    @required this.data,
    @required this.index,
  });

  Widget _buildSeperator(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Container(
            height: 1,
            color: Theme.of(context).primaryColor,
          )),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Appointment ${data.length - index}',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${DateFormat.yMMMEd().format(data[index]['apDt'])}',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView(
            children: [
              Text(
                'Symptom',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                height: 20.0 * data[index]['symptoms'].length + 10,
                // color: Colors.teal[100],
                // child: Text('symptom content'),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, lvIndex) {
                    return Text(
                      ' ${data[index]['symptoms'][lvIndex]}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    );
                  },
                  itemCount: data[index]['symptoms'].length,
                ),
              ),
              _buildSeperator(context),
              Text(
                'Disease',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                height: 20.0 * data[index]['diseases'].length + 10,
                // color: Colors.teal[100],
                // child: Text('disease content'),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, lvIndex) {
                    return Text(
                      ' ${data[index]['diseases'][lvIndex]}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    );
                  },
                  itemCount: data[index]['diseases'].length,
                ),
              ),
              _buildSeperator(context),
              Text(
                'Prescription',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                height: 20.0 * data[index]['drugs'].length + 10,
                // color: Colors.teal[100],
                // child: Text('disease content'),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, lvIndex) {
                    return Text(
                      ' ${data[index]['drugs'][lvIndex]}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    );
                  },
                  itemCount: data[index]['drugs'].length,
                ),
              ),
              _buildSeperator(context),
              Text(
                'Treatment',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                // height: 100,
                // color: Colors.teal[100],
                child: Text(
                  '    ${data[index]['advise']}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
