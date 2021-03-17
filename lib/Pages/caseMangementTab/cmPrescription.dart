import 'package:flutter/material.dart';

import '../../dummy_data.dart';
import '../../Widget/caseMangementListitemBox.dart';
import '../../Widget/showMyDialog.dart';
import '../../Widget/caseManagementEditBottomSheet.dart';
import '../../Widget/caseManagementAdviseBox.dart';
import '../../Widget/caseManagementAdviseEdit.dart';

class CMPrescriptionTab extends StatefulWidget {
  final String tpId = 'tp001';

  @override
  _CMPrescriptionTabState createState() => _CMPrescriptionTabState();
}

class _CMPrescriptionTabState extends State<CMPrescriptionTab> {
  var _loadedInitData = false;
  List<Appointment> appointments;
  final controller = TextEditingController();
  String temp;

  _setAdd() {
    setState(() {
      temp = controller.text;
    });
    controller.clear();
    print('Add as $temp');
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Data added'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  _setEdit() {
    setState(() {
      temp = controller.text;
    });
    controller.clear();
    print('Edit as $temp');
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Data added'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      appointments = dummy_appointment
          .where((apt) =>
              (apt.tpId == widget.tpId) && (apt.status != AptStatus.Lastest))
          .toList();
      appointments.sort((a, b) => b.apDt.compareTo(a.apDt));
    }
    super.didChangeDependencies();
  }

  List<String> get _getPrescription {
    Prescription tempPs;
    List<String> temp = new List();
    tempPs =
        dummy_prescriptions.firstWhere((ps) => ps.apId == appointments[0].apId);
    // print('${tempPs.psId}');
    for (Drug drug
        in dummy_drug.where((drug) => drug.psId == tempPs.psId).toList()) {
      temp.add(drug.drugDetail);
    }
    return temp;
  }

  String get _getAdvise {
    // print('${appointments[0].apId}');
    // print('${appointments[0].advises}');
    return appointments[0].advises;
  }

  @override
  Widget build(BuildContext context) {
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
                title: 'Disease',
                items: _getPrescription,
                // addFn: () {
                //   caseManagementEditBottomSheet(
                //     context,
                //     'Add drug',
                //     controller,
                //     'Add',
                //     _setAdd,
                //   );
                // },
                // editFn: () {
                //   caseManagementEditBottomSheet(
                //     context,
                //     'Edit drug',
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
              child: CaseManagementAdviseBox(
                title: 'Treatment',
                item: _getAdvise,
                editFn: () {
                  caseManagementAdviseEdit(
                    context,
                    'Edit treatment',
                    controller,
                    'Edit',
                    _setEdit,
                  );
                },
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
