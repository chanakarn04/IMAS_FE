import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AptSymptomDiseaseCard extends StatelessWidget {
  final Map<String, dynamic> appointment;
  final int indexing;

  AptSymptomDiseaseCard(
    this.appointment,
    this.indexing,
  );

  Color painScoreColor(int painScore) {
    if (painScore < 2) {
      return Color.fromARGB(255, 81, 195, 169);
    } else if (painScore < 5) {
      return Color.fromARGB(255, 80, 200, 233);
    } else if (painScore < 8) {
      return Color.fromARGB(255, 241, 215, 78);
    } else {
      return Color.fromARGB(255, 205, 16, 16);
    }
  }

  Widget _buildSeperator(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Appointment $indexing',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              DateFormat.yMMMEd().format(appointment['apDt']),
              style: TextStyle(color: Color.fromARGB(255, 100, 100, 100)),
            ),
            Expanded(
              child: ListView(
                children: [
                  Text(
                    'Disease',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  (appointment['condition'] != null)
                      ? Container(
                          height: appointment['condition'].length * 25.0 + 20,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final _conditions = appointment['condition'].values.toList();
                              return Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(vertical: 2.5),
                                child: Text(
                                  '\t\t\t${_conditions[index]}',
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 75, 75, 75),
                                  ),
                                ),
                              );
                            },
                            itemCount: appointment['condition'].length,
                          ),
                        )
                      : Container(
                          height: 45,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'No disease',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 75, 75, 75),
                            ),
                          ),
                        ),
                  _buildSeperator(context),
                  Text(
                    'Symptom',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  (appointment['symptoms'] != null)
                      ? Container(
                          height: appointment['symptoms'].length * 45.0 + 20,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.5),
                                child: Row(
                                  children: [
                                    Text(
                                      '\t\t\t${appointment['symptoms'][index]}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 75, 75, 75),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                  ],
                                ),
                              );
                            },
                            itemCount: appointment['symptoms'].length,
                          ),
                        )
                      : Container(
                          height: 65,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'No disease',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 75, 75, 75),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
