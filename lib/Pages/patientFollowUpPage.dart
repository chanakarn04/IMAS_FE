import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../dummy_data.dart';
import '../Provider/user-info.dart';
import './patientFollowUp/onConsultTab.dart';
import './patientFollowUp/inCareTab.dart';

class PatientFollowUpPage extends StatefulWidget {
  static const routeName = '/patient-followUp';

  @override
  _PatientFollowUpPageState createState() => _PatientFollowUpPageState();
}

class _PatientFollowUpPageState extends State<PatientFollowUpPage> {
  int selectedPageIndex = 0;
  List<Map<String, Object>> _pages;

  List<Map<String, dynamic>> _loadData(String userId) {
    // ... load all tp with drId

    return [
      {
        'pName': 'Pisit',
        'pSurname': 'Pasut',
        'imageAsset': 'assets/images/default_photo.png',
        'apDt': DateTime.now().add(
          new Duration(minutes: 10),
        ),
        'tpId': 'tp001'
      },
      {
        'pName': 'Mango',
        'pSurname': 'Steen',
        'imageAsset': '',
        'apDt': DateTime.now().add(
          new Duration(days: 8),
        ),
        'tpId': 'tp002'
      },
      {
        'pName': 'Jack',
        'pSurname': 'Fruit',
        'imageAsset': '',
        'apDt': DateTime.now().add(
          new Duration(days: 17),
        ),
        'tpId': 'tp003'
      },
      {
        'pName': 'Ichigo',
        'pSurname': 'Strawberry',
        'imageAsset': '',
        'apDt': DateTime.now().add(
          new Duration(days: 24),
        ),
        'tpId': 'tp004'
      },
      {
        'pName': 'Orange',
        'pSurname': 'Joe',
        'imageAsset': '',
        'apDt': DateTime.now().add(
          new Duration(days: 34),
        ),
        'tpId': 'tp005'
      },
      {
        'pName': 'Faceless',
        'pSurname': 'Void',
        'imageAsset': '',
        'apDt': DateTime.now().add(
          new Duration(days: 36),
        ),
        'tpId': 'tp006'
      },
      {
        'pName': 'Outworld',
        'pSurname': 'Destroyer',
        'imageAsset': '',
        'apDt': DateTime.now().add(
          new Duration(days: 38),
        ),
        'tpId': 'tp007'
      },
      {
        'pName': 'Shadow',
        'pSurname': 'Shaman',
        'imageAsset': '',
        'apDt': DateTime.now().add(
          new Duration(days: 38),
        ),
        'tpId': 'tp008'
      },
    ];
  }

  @override
  void initState() {
    final userInfo = Provider.of<UserInfo>(context, listen: false);
    final List<Map<String, dynamic>> data = _loadData(userInfo.userId);
    print(data[0]['apDt'].difference(DateTime.now()));
    // print(data
    //     .where((element) =>
    //         (DateTime.now().difference(element['apDt']).inMinutes >= 0 &&
    //             DateTime.now().difference(element['apDt']).inMinutes <= 30))
    //     .toList()
    //     .length);
    _pages = [
      {
        'title': 'On Consult',
        'tab': OnConsultTab(
          data
              .where((element) =>
                  (element['apDt'].difference(DateTime.now()).inMinutes >= 0 &&
                      element['apDt'].difference(DateTime.now()).inMinutes <=
                          30))
              .toList(),
        ),
      },
      {
        'title': 'In Care',
        'tab': InCareTab(
          data,
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
