import 'package:flutter/material.dart';

// import '../dummy_data.dart';
import './patientFollowUp/onConsultTab.dart';
import './patientFollowUp/inCareTab.dart';

class PatientFollowUpPage extends StatefulWidget {
  static const routeName = '/patient-followUp';

  @override
  _PatientFollowUpPageState createState() => _PatientFollowUpPageState();
}

class _PatientFollowUpPageState extends State<PatientFollowUpPage> {
  // var _loadedInitData = false;
  int selectedPageIndex = 0;

  final String drId = 'd001';
  List<Map<String, Object>> _pages;
  // List<TreatmentPlan> thisDoctorTreatmentPlans;
  // List<Appointment> thisDoctorAppointments = new List();
  // List<Patient> patients;

  // @override
  // void didChangeDependencies() {
  //   // if (!_loadedInitData) {
  //   //   thisDoctorTreatmentPlans = dummy_treatmentPlans
  //   //       .where((tp) =>
  //   //           (tp.drId == drId) && (tp.status == TreatmentStatus.InProgress))
  //   //       .toList();
  //   //   for (TreatmentPlan tp in thisDoctorTreatmentPlans) {
  //   //     print('tester: ${tp.tpId}');
  //   //     thisDoctorAppointments.addAll(dummy_appointment
  //   //         .where((apt) =>
  //   //             (apt.tpId == tp.tpId) && (apt.status == AptStatus.Lastest))
  //   //         .toList());
  //   //     // patients
  //   //     //     .addAll(dummy_Paitents.where((p) => (p.pId == tp.pId)).toList());
  //   //   }
  //   //   // for (Appointment apt in thisDoctorAppointments) {
  //   //   //   // print('tester: ${tp.tpId}');
  //   //   //   patients.addAll(dummy_Paitents.where((pt) =>
  //   //   //       (pt.pId == apt.) && (apt.status == AptStatus.Lastest)));
  //   //   // }

  //     // _loadedInitData = true;
  //   }
  //   super.didChangeDependencies();
  // }

  // final String name = 'f-name';
  // final String surname = 's-name';
  // final String imageAsset = '';
  // final DateTime aptDt;

  @override
  void initState() {
    _pages = [
      {
        'title': 'On Consult',
        // 'tab': OnConsultTab(),
        'tab': OnConsultTab(
          [
            {
              'fname': 'pisit',
              'sname': 'pasut',
              'imageAsset': 'assets/images/default_photo.png',
              'apDt': DateTime.now().subtract(
                new Duration(minutes: 10),
              ),
              'tpId': 'tp001'
            },
            {
              'fname': 'mango',
              'sname': 'steen',
              'imageAsset': '',
              'apDt': DateTime.now().subtract(
                new Duration(minutes: 15),
              ),
              'tpId': 'tp002'
            },
          ],
        ),
      },
      {
        'title': 'In Care',
        'tab': InCareTab(
          [
            {
              'fname': 'Pisit',
              'sname': 'Pasut',
              'imageAsset': 'assets/images/default_photo.png',
              'aptDt': DateTime.now().add(
                new Duration(minutes: 10),
              ),
              'tpId': 'tp001'
            },
            {
              'fname': 'Mango',
              'sname': 'Steen',
              'imageAsset': '',
              'aptDt': DateTime.now().add(
                new Duration(days: 8),
              ),
              'tpId': 'tp002'
            },
            {
              'fname': 'Jack',
              'sname': 'Fruit',
              'imageAsset': '',
              'aptDt': DateTime.now().add(
                new Duration(days: 17),
              ),
              'tpId': 'tp003'
            },
            {
              'fname': 'Ichigo',
              'sname': 'Strawberry',
              'imageAsset': '',
              'aptDt': DateTime.now().add(
                new Duration(days: 24),
              ),
              'tpId': 'tp004'
            },
            {
              'fname': 'Orange',
              'sname': 'Joe',
              'imageAsset': '',
              'aptDt': DateTime.now().add(
                new Duration(days: 34),
              ),
              'tpId': 'tp005'
            },
            {
              'fname': 'Faceless',
              'sname': 'Void',
              'imageAsset': '',
              'aptDt': DateTime.now().add(
                new Duration(days: 36),
              ),
              'tpId': 'tp006'
            },
            {
              'fname': 'Outworld',
              'sname': 'Destroyer',
              'imageAsset': '',
              'aptDt': DateTime.now().add(
                new Duration(days: 38),
              ),
              'tpId': 'tp007'
            },
            {
              'fname': 'Shadow',
              'sname': 'Shaman',
              'imageAsset': '',
              'aptDt': DateTime.now().add(
                new Duration(days: 38),
              ),
              'tpId': 'tp008'
            },
          ],
        )
      },
    ];
    super.initState();
  }

  _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  // getInCareInfo() {
  //   List<Patient> patients;
  //   // String tpId;
  //   for (TreatmentPlan tp in thisDoctorTreatmentPlans) {
  //     dummy_Patients.firstWhere((pt) => )
  //     patients.addAll(dummy_Patients.where((pt) => tp.pId == pt.pId));
  //   }
  //   for (Patient pt in patients) {
  //     print(pt.pId);
  //     print(pt.pName);
  //     print(pt.pSurname);
  //   }
  //   // return
  // }

  // geOnConsultInfo() {
  //   List<Patient> patients;
  //   List<Appointment> appoitments = thisDoctorAppointments.where((apt) => apt.apDt);
  //   for (TreatmentPlan tp in thisDoctorTreatmentPlans) {
  //     patients.addAll(dummy_Patients.where((pt) => (tp.pId == pt.pId) && ()));
  //   }
  //   for (Patient pt in patients) {
  //     print(pt.pId);
  //   }
  //   // return
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pop()),
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Patient',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.transparent,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: _pages[selectedPageIndex]['tab'],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Theme.of(context).primaryColor,
        // selectedItemColor: Colors.white,
        unselectedItemColor: Theme.of(context).primaryColor.withAlpha(150),
        currentIndex: selectedPageIndex,
        onTap: _selectPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: _pages[0]['title'],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: _pages[1]['title'],
          ),
        ],
      ),
    );
  }
}
