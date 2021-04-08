import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:homepage_proto/dummy_data.dart';

import '../Provider/caseManagement_Info.dart';
import './caseMangementTab/cmDiseaseSymptom.dart';
import './caseMangementTab/cmPrescription.dart';
import './caseMangementTab/caseManagement.dart';

class CaseManagementPage extends StatefulWidget {
  static const routeName = '/caseManagement';
  // final String tpId = 'tp001';
  @override
  _CaseManagementPageState createState() => _CaseManagementPageState();
}

class _CaseManagementPageState extends State<CaseManagementPage> {
  int selectedPageIndex = 0;
  // String ptFullName = '';

  List<Map<String, Object>> _pages;

  @override
  void initState() {
    // ptFullName =
    //     '${dummy_Patients.firstWhere((pt) => dummy_treatmentPlans.firstWhere((tp) => tp.tpId == this.widget.tpId).pId == pt.pId).pName} ${dummy_Patients.firstWhere((pt) => dummy_treatmentPlans.firstWhere((tp) => tp.tpId == this.widget.tpId).pId == pt.pId).pSurname}';
    _pages = [
      {
        'title': 'Disease/Symptom',
        'tab': CMDiseaseSymptomTab(),
      },
      {
        'title': 'Prescription',
        'tab': CMPrescriptionTab(),
      },
      {
        'title': 'Case management',
        'tab': CaseManagementTab(),
      },
    ];
    super.initState();
  }

  _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final cmInfo = Provider.of<CMinfoProvider>(context, listen: false);
    cmInfo.loadCMInfo(
      data['tpId'],
      data['name'],
    );
    // cmInfo.savePname(data['name']);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pop()),
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/default_photo.png'),
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Case management',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  data['name'],
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _pages[selectedPageIndex]['tab'],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(context).primaryColor.withAlpha(150),
        currentIndex: selectedPageIndex,
        onTap: _selectPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: _pages[0]['title'],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: _pages[1]['title'],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_ind_outlined),
            label: _pages[2]['title'],
          ),
        ],
      ),
    );
  }
}
