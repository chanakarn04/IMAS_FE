import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../dummy_data.dart';
// import '../../Widget/showMyDialog.dart';
// import '../../Widget/caseManagementEditBottomSheet.dart';
import '../../Provider/caseManagement_Info.dart';
import '../../Widget/caseMangementListitemBox.dart';
import '../../Widget/caseManagementAdviseBox.dart';
// import '../../Widget/caseManagementAdviseEdit.dart';

class CMPrescriptionTab extends StatefulWidget {
  // final String tpId = 'tp001';

  @override
  _CMPrescriptionTabState createState() => _CMPrescriptionTabState();
}

class _CMPrescriptionTabState extends State<CMPrescriptionTab> {
  @override
  Widget build(BuildContext context) {
    final cmInfo = Provider.of<CMinfoProvider>(context);
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 15,
        // left: 20,
        // bottom: 20,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: InkWell(
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: CaseManagementListItemBox(
                caseIndex: 'prescription',
                title: 'Perscription',
                description: 'Medicines that patient should take',
                items: cmInfo.prescriptions,
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
                caseIndex: 'suggestion',
                title: 'Treatment',
                description: 'Guideline for patient self-treatment',
                item: 'test test 1 2 4',
                // cmInfo: cmInfo,
                // editFn: () {
                // caseManagementAdviseEdit(
                //   context,
                //   'Edit treatment',
                //   controller,
                //   'Edit',
                //   // _setEdit,
                // );
                // },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Container(
          //   width: double.infinity,
          //   height: 2,
          //   color: Theme.of(context).primaryColor,
          // )
        ],
      ),
    );
  }
}
