import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/model.dart';

class SuggestionCardContent extends StatelessWidget {
  final List<String> conditions;
  final List<String> symptoms;
  final List<String> prescriptions;
  final String suggestion;
  final int appointmentIndex;
  final DateTime apdt;
  final TreatmentStatus tpStatus;

  SuggestionCardContent({
    @required this.conditions,
    @required this.symptoms,
    this.prescriptions,
    this.suggestion,
    this.appointmentIndex,
    this.apdt,
    this.tpStatus,
  });

  Widget _listBuilder(
    BuildContext context,
    String headerText,
    List<String> listContent,
  ) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            headerText,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        (listContent.length != 0)
            ? Container(
                height: (26.0 * listContent.length) + 15,
                padding: EdgeInsets.only(
                  left: 20,
                  top: 10,
                  bottom: 5,
                ),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 1.5),
                      child: Text(
                        '${listContent[index]}',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                  itemCount: listContent.length,
                ))
            : Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'No $headerText',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
      ],
    );
  }

  List<Widget> _header(
    int index,
    DateTime apdt,
  ) {
    return [
      Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appointment $index',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${DateFormat.yMMMMd().add_jm().format(apdt)}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 10),
    ];
  }

  Widget _seperater() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 1,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (tpStatus != null) ..._header(appointmentIndex, apdt),
          _listBuilder(context, 'Diseases', conditions),
          _seperater(),
          _listBuilder(context, 'Symptoms', symptoms),
          (tpStatus != null) ? _seperater() : Container(),
          (tpStatus != null)
              ? _listBuilder(context, 'Prescriptions', prescriptions)
              : Container(),
          (tpStatus != null) ? _seperater() : Container(),
          (tpStatus != null)
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sugesstion',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    (suggestion != null)
                        ? Container(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: 10,
                              bottom: 5,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              suggestion,
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              'No suggestion',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
