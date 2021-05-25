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

  // item['apts'][index]['pat_condition']
  // item['apts'][index]['pat_symptom']

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
                    // final _diseaseList = item['apts'][0]
                    //         ['pat_condition']
                    //     .values
                    //     .toList();
                    return Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 1.5),
                      // color: Colors.teal[100],
                      child: Text(
                        '${listContent[index]}',
                        // '${_diseaseList[index]}',
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
      SizedBox(
        height: 10,
      ),
    ];
  }

  Widget _seperater() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      height: 1,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(tpStatus);
    return SingleChildScrollView(
      child: Column(
        children: [
          // tpStatus != TreatmentStatus.Api || 
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
                            // height: (28.0 * listContent.length) + 15,
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

// final List data;
// final int index;

// SuggestionCardContent({
//   @required this.data,
//   @required this.index,
// });

// Widget _buildSeperator(BuildContext context) {
//   return Padding(
//     padding: EdgeInsets.symmetric(vertical: 15),
//     child: Row(
//       children: [
//         SizedBox(
//           width: 10,
//         ),
//         Expanded(
//             child: Container(
//           height: 1,
//           color: Theme.of(context).primaryColor,
//         )),
//         SizedBox(
//           width: 10,
//         ),
//       ],
//     ),
//   );
// }

// @override
// Widget build(BuildContext context) {
//   return Column(
//     children: [
//       Text(
//         'Appointment ${data.length - index}',
//         style: TextStyle(
//           fontSize: 32,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       Text(
//         '${DateFormat.yMMMEd().format(data[index]['apDt'])}',
//         style: TextStyle(
//           color: Colors.grey[600],
//           fontSize: 16,
//         ),
//       ),
//       SizedBox(
//         height: 15,
//       ),
//       Expanded(
//         child: ListView(
//           children: [
//             Text(
//               'Symptom',
//               style: TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(
//                 top: 10,
//                 left: 10,
//               ),
//               height: 20.0 * data[index]['symptoms'].length + 10,
//               // color: Colors.teal[100],
//               // child: Text('symptom content'),
//               child: ListView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, lvIndex) {
//                   return Text(
//                     ' ${data[index]['symptoms'][lvIndex]}',
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   );
//                 },
//                 itemCount: data[index]['symptoms'].length,
//               ),
//             ),
//             _buildSeperator(context),
//             Text(
//               'Disease',
//               style: TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(
//                 top: 10,
//                 left: 10,
//               ),
//               height: 20.0 * data[index]['diseases'].length + 10,
//               // color: Colors.teal[100],
//               // child: Text('disease content'),
//               child: ListView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, lvIndex) {
//                   return Text(
//                     ' ${data[index]['diseases'][lvIndex]}',
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   );
//                 },
//                 itemCount: data[index]['diseases'].length,
//               ),
//             ),
//             _buildSeperator(context),
//             Text(
//               'Prescription',
//               style: TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(
//                 top: 10,
//                 left: 10,
//               ),
//               height: 20.0 * data[index]['drugs'].length + 10,
//               // color: Colors.teal[100],
//               // child: Text('disease content'),
//               child: ListView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, lvIndex) {
//                   return Text(
//                     ' ${data[index]['drugs'][lvIndex]}',
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   );
//                 },
//                 itemCount: data[index]['drugs'].length,
//               ),
//             ),
//             _buildSeperator(context),
//             Text(
//               'Treatment',
//               style: TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(
//                 top: 10,
//                 left: 10,
//               ),
//               // height: 100,
//               // color: Colors.teal[100],
//               child: Text(
//                 '    ${data[index]['advise']}',
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }