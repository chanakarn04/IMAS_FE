import 'package:flutter/material.dart';

import '../../dummy_data.dart';
import '../../Widget/caseMangementListitemBox.dart';
import '../../Widget/showMyDialog.dart';

class CaseManagementAdviseBox extends StatelessWidget {
  final String title;
  final String item;
  final Function editFn;

  CaseManagementAdviseBox({
    this.title,
    this.item,
    this.editFn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(child: Container()),
            SizedBox(
              height: 45,
              width: 45,
              child: IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: editFn,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topLeft: Radius.circular(15),
                )),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                '    \u2022 $item',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CMPrescriptionTab extends StatefulWidget {
  final String tpId = 'tp001';

  @override
  _CMPrescriptionTabState createState() => _CMPrescriptionTabState();
}

class _CMPrescriptionTabState extends State<CMPrescriptionTab> {
  var _loadedInitData = false;
  List<Appointment> appointments;

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
                addFn: () {
                  print('add');
                },
                editFn: () {
                  print('edit');
                },
                delFn: () {
                  showMyDialog(
                    context,
                    'Delete?',
                    'Confirm to delete this item?',
                    'cancel',
                    'confirm',
                    () {
                      print('Delete item');
                    },
                  );
                },
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
                  print('edit treatment');
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
