import 'package:flutter/material.dart';

class CaseManagementPage extends StatefulWidget {
  static const routeName = '/caseManagement';
  @override
  _CaseManagementPageState createState() => _CaseManagementPageState();
}

class _CaseManagementPageState extends State<CaseManagementPage> {
  int selectedPageIndex = 0;

  List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {
        'title': 'Disease/Symptom',
        'tab': Center(child: Text('Disease/Symptom')),
      },
      {
        'title': 'Prescription',
        'tab': Center(child: Text('Prescription')),
      },
      {
        'title': 'Case management',
        'tab': Center(child: Text('Case management')),
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
        unselectedItemColor: Theme.of(context).primaryColor.withAlpha(150),
        currentIndex: selectedPageIndex,
        onTap: _selectPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: _pages[selectedPageIndex]['title'],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: _pages[selectedPageIndex]['title'],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_ind_outlined),
            label: _pages[selectedPageIndex]['title'],
          ),
        ],
      ),
    );
  }
}
