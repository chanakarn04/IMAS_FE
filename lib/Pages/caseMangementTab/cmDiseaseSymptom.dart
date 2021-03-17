import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../dummy_data.dart';
import '../../Provider/caseManagement_Info.dart';
import '../../Widget/caseMangementListitemBox.dart';
// import '../../Widget/showMyDialog.dart';
// import '../../Widget/caseManagementEditBottomSheet.dart';

class CMDiseaseSymptomTab extends StatefulWidget {
  @override
  _CMDiseaseSymptomTabState createState() => _CMDiseaseSymptomTabState();
}

class _CMDiseaseSymptomTabState extends State<CMDiseaseSymptomTab> {
  final controller = TextEditingController();
  String temp;

  @override
  Widget build(BuildContext context) {
    final cmInfo = Provider.of<CMinfoProvider>(context);

    // _setAdd(String caseIndex) {
    // setState(() {
    //   temp = controller.text;
    // });
    // controller.clear();
    // // add data
    // cmInfo.add(caseIndex, temp);
    // // print('Add as $temp');
    // Navigator.of(context).pop();
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: Text('$caseIndex added'),
    //     actions: [
    //       FlatButton(
    //         onPressed: () {
    //           Navigator.of(context).pop();
    //         },
    //         child: Text('OK'),
    //       ),
    //     ],
    //   ),
    // );
    // }

    // _setEdit(caseIndex, index) {
    //   setState(() {
    //     temp = controller.text;
    //   });
    //   controller.clear();
    //   cmInfo.edit(caseIndex, index, temp);
    //   // print('Edit as $temp');
    //   Navigator.of(context).pop();
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: Text('Data edited'),
    //       actions: [
    //         FlatButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: Text('OK'),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    return Container(
      padding: EdgeInsets.only(
        top: 15,
        // left: 20,
        // bottom: 20,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: CaseManagementListItemBox(
                caseIndex: 'disease',
                title: 'Disease',
                items: cmInfo.condition,
                // addFn: () {
                //   caseManagementEditBottomSheet(
                //     context,
                //     'Add disease',
                //     controller,
                //     'Add',
                //     _setAdd,
                //   );
                // },
                // editFn: () {
                //   caseManagementEditBottomSheet(
                //     context,
                //     'Edit disease',
                //     controller,
                //     'Edit',
                //     _setEdit,
                //   );
                // },
                // delFn: () {
                //   showMyDialog(
                //     context,
                //     'Delete?',
                //     'Confirm to delete this item?',
                //     'cancel',
                //     'confirm',
                //     () {
                //       print('Delete item');
                //       Navigator.of(context).pop();
                //     },
                //   );
                // },
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: CaseManagementListItemBox(
                caseIndex: 'symptom',
                title: 'Symptom',
                items: cmInfo.symptoms,
                // addFn: () {
                //   caseManagementEditBottomSheet(
                //     context,
                //     'Add symptom',
                //     controller,
                //     'Add',
                //     _setAdd,
                //   );
                // },
                // editFn: () {
                //   caseManagementEditBottomSheet(
                //     context,
                //     'Edit symptom',
                //     controller,
                //     'Edit',
                //     _setEdit,
                //   );
                // },
                // delFn: () {
                //   showMyDialog(
                //     context,
                //     'Delete?',
                //     'Confirm to delete this item?',
                //     'cancel',
                //     'confirm',
                //     () {
                //       print('Delete item');
                //       Navigator.of(context).pop();
                //     },
                //   );
                // },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 2,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}

// class CMDiseaseSymptomTabs extends StatefulWidget {
//   // CMDiseaseSymptomTab(this.tpId);

//   @override
//   _CMDiseaseSymptomTasbState createState() => _CMDiseaseSymptomTabsState();
// }

// class _CMDiseaseSymptomTabsState extends State<CMDiseaseSymptomTabs> {
//   var _loadedInitData = false;
//   List<Appointment> appointments;
//   List<DetectedSymptom> lastSymptoms;
//   List<DiagnosedDisease> lastDiagDiseases;
//   final controller = TextEditingController();
//   String temp;

//   @override
//   void didChangeDependencies() {
//     if (!_loadedInitData) {
//       appointments = dummy_appointment
//           .where((apt) =>
//               (apt.tpId == widget.tpId) && (apt.status != AptStatus.Lastest))
//           .toList();
//       appointments.sort((a, b) => b.apDt.compareTo(a.apDt));
//       // for (Appointment apt in appointments) {
//       //   print(apt.apId);
//       // }
//       lastDiagDiseases = dummy_diagDiseases
//           .where((disease) => disease.apId == appointments[0].apId)
//           .toList();
//       lastSymptoms = dummy_dtdSymptoms
//           .where((symptom) => symptom.apId == appointments[0].apId)
//           .toList();
//     }
//     super.didChangeDependencies();
//   }

//   _setAdd() {
//     setState(() {
//       temp = controller.text;
//     });
//     controller.clear();
//     print('Add as $temp');
//     Navigator.of(context).pop();
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Data added'),
//         actions: [
//           FlatButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   _setEdit() {
//     setState(() {
//       temp = controller.text;
//     });
//     controller.clear();
//     print('Edit as $temp');
//     Navigator.of(context).pop();
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Data edited'),
//         actions: [
//           FlatButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   List<String> get _getDiseaseNames {
//     List<String> temp = new List();
//     for (var i = 0; i < lastDiagDiseases.length; i++) {
//       for (var item in dummy_diseases
//           .where((disease) => disease.id == lastDiagDiseases[i].dId)) {
//         temp.add(item.name);
//       }
//     }
//     return temp;
//   }

//   List<String> get _getSymptomNames {
//     List<String> temp = new List();
//     for (var i = 0; i < lastSymptoms.length; i++) {
//       // print(lastSymptoms[i].apId);
//       for (var item in dummy_symptoms
//           .where((symptom) => symptom.id == lastSymptoms[i].stId)) {
//         temp.add(item.name);
//       }
//       // temp.add(dummy_symptoms
//       //     .firstWhere((symptom) => symptom.id == lastSymptoms[i].stId)
//       //     .name);
//     }
//     return temp;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         top: 15,
//         // left: 20,
//         // bottom: 20,
//       ),
//       child: Column(
//         children: [
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.only(left: 20),
//               child: CaseManagementListItemBox(
//                 title: 'Disease',
//                 items: _getDiseaseNames,
//                 addFn: () {
//                   caseManagementEditBottomSheet(
//                     context,
//                     'Add disease',
//                     controller,
//                     'Add',
//                     _setAdd,
//                   );
//                 },
//                 editFn: () {
//                   caseManagementEditBottomSheet(
//                     context,
//                     'Edit disease',
//                     controller,
//                     'Edit',
//                     _setEdit,
//                   );
//                 },
//                 delFn: () {
//                   showMyDialog(
//                     context,
//                     'Delete?',
//                     'Confirm to delete this item?',
//                     'cancel',
//                     'confirm',
//                     () {
//                       print('Delete item');
//                       Navigator.of(context).pop();
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(left: 20),
//               child: CaseManagementListItemBox(
//                 title: 'Symptom',
//                 items: _getSymptomNames,
//                 addFn: () {
//                   caseManagementEditBottomSheet(
//                     context,
//                     'Add symptom',
//                     controller,
//                     'Add',
//                     _setAdd,
//                   );
//                 },
//                 editFn: () {
//                   caseManagementEditBottomSheet(
//                     context,
//                     'Edit symptom',
//                     controller,
//                     'Edit',
//                     _setEdit,
//                   );
//                 },
//                 delFn: () {
//                   showMyDialog(
//                     context,
//                     'Delete?',
//                     'Confirm to delete this item?',
//                     'cancel',
//                     'confirm',
//                     () {
//                       print('Delete item');
//                       Navigator.of(context).pop();
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             width: double.infinity,
//             height: 2,
//             color: Theme.of(context).primaryColor,
//           )
//         ],
//       ),
//     );
//   }
// }
