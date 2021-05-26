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
        // height: 200,
        // width: MediaQuery.of(context).size.width * 0.85,
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
                              final _conditions =
                                  appointment['condition'].values.toList();
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.5),
                                child: Row(
                                  children: [
                                    Text(
                                      // '\t\t\t${symptoms.firstWhere((symptom) => symptom.id == dtdSymptom[index].stId).name}',
                                      '\t\t\t${appointment['symptoms'][index]}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 75, 75, 75),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    // CircleAvatar(
                                    //   child: Text(
                                    //     '${appointment['symptoms'][index]['painScore']}',
                                    //     style: TextStyle(
                                    //         fontWeight: FontWeight.bold,
                                    //         color: Colors.white),
                                    //   ),
                                    //   backgroundColor: painScoreColor(
                                    //       appointment['symptoms'][index]['painScore']),
                                    // ),
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

// class AptStpDisCardWidget extends StatefulWidget {
//   final Map<String, dynamic> appointment;
//   final int index;
//   final List symptoms;
//   final List diseases;

//   AptStpDisCardWidget(
//     this.appointment,
//     this.index,
//     this. symptoms,
//     this.diseases,
//   );

//   @override
//   _AptStpDisCardWidgetState createState() => _AptStpDisCardWidgetState();
// }

// class _AptStpDisCardWidgetState extends State<AptStpDisCardWidget> {

// var _loadedInitData = false;

// final List<Symptom> symptoms = dummy_symptoms;
// final List<DiseaseAPI> diseases = dummy_diseaseAPIs;
// List<DetectedSymptom> dtdSymptom;
// List<DiagnosedDisease> diagDisease;

// @override
// void initState() {
//   // ...
//   super.initState();
// }

// @override
// void didChangeDependencies() {
//   if (!_loadedInitData) {
//     dtdSymptom = dummy_dtdSymptoms
//         .where((symptom) => symptom.apId == widget.appointment.apId)
//         .toList();
//     diagDisease = dummy_diagDiseases
//         .where((disease) => disease.apId == widget.appointment.apId)
//         .toList();
//     // _loadedInitData = true;
//   }
//   super.didChangeDependencies();
// }

//   Color painScoreColor(int painScore) {
//     if (painScore < 2) {
//       return Color.fromARGB(255, 81, 195, 169);
//     } else if (painScore < 5) {
//       return Color.fromARGB(255, 80, 200, 233);
//     } else if (painScore < 8) {
//       return Color.fromARGB(255, 241, 215, 78);
//     } else {
//       return Color.fromARGB(255, 205, 16, 16);
//     }
//   }

//   Widget _buildSeperator(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 15),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 10,
//           ),
//           Expanded(
//               child: Container(
//             height: 1,
//             color: Theme.of(context).primaryColor,
//           )),
//           SizedBox(
//             width: 10,
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       margin: EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 15,
//       ),
//       color: Theme.of(context).primaryColor,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: Colors.white,
//         ),
//         margin: EdgeInsets.all(3),
//         padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//         // height: 200,
//         // width: MediaQuery.of(context).size.width * 0.85,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Appointment ${this.widget.index}',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 24,
//               ),
//             ),
//             Text(
//               DateFormat.yMMMEd().format(this.widget.appointment.apDt),
//               style: TextStyle(color: Color.fromARGB(255, 100, 100, 100)),
//             ),
//             Expanded(
//               child: ListView(
//                 children: [
//                   Text(
//                     'Disease',
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                   Container(
//                     height: diagDisease.length * 25.0 + 20,
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                     child: ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.symmetric(vertical: 2.5),
//                           child: Text(
//                             '\t\t\t${diseases.firstWhere((disease) => disease.id == diagDisease[index].dId).commonName}',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Color.fromARGB(255, 75, 75, 75),
//                             ),
//                           ),
//                         );
//                       },
//                       itemCount: diagDisease.length,
//                     ),
//                   ),
//                   _buildSeperator(context),
//                   Text(
//                     'Symptom',
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                   Container(
//                     height: dtdSymptom.length * 45.0 + 20,
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                     child: ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 2.5),
//                           child: Row(
//                             children: [
//                               Text(
//                                 '\t\t\t${symptoms.firstWhere((symptom) => symptom.id == dtdSymptom[index].stId).name}',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Color.fromARGB(255, 75, 75, 75),
//                                 ),
//                               ),
//                               Expanded(child: Container()),
//                               CircleAvatar(
//                                 child: Text(
//                                   '${dtdSymptom[index].painScore}',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white),
//                                 ),
//                                 backgroundColor:
//                                     painScoreColor(dtdSymptom[index].painScore),
//                               )
//                             ],
//                           ),
//                         );
//                       },
//                       itemCount: dtdSymptom.length,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
