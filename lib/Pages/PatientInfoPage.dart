import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Provider/user-info.dart';
import '../Provider/patientInfo.dart';
import './patientInfo/basicInfoTab.dart';
import './patientInfo/disease_symptomTab.dart';
import './patientInfo/vitalSignTab.dart';
import './patientInfo/suggestionTab.dart';

class PatientInfoPage extends StatefulWidget {
  static const routeName = '/patient-info';

  @override
  _PatientInfoPageState createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  // GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  var _loadedData = false;
  ScrollController _scrollController;
  bool sliverCollapsed = false;
  String appBarTitle = '';
  String pFullName = '';
  Map<String, dynamic> data;

  PatientInfo patientInfo;
  Map<String, dynamic> routeArg;

  // get treatmentPlan id from  route argument
  // get username, apDt with apStatus.lastest

  Map<String, dynamic> _loadData(String tpId) {
    // ...

    // assign pName for sliver header
    // pName + pSurname

    return {
      'userId': 'p0001',
      'pName': 'pName',
      'pSurname': 'pSurname',
      'apDt': DateTime(2021, 12, 14),
    };
  }

  // final lastAppointment =
  //     dummy_appointment.firstWhere((apt) => apt.status == AptStatus.Lastest);

  // @override
  // void initState() {
  //   _scrollController = ScrollController();

  //   _scrollController.addListener(() {
  //     if (_scrollController.offset > 80 &&
  //         !_scrollController.position.outOfRange) {
  //       if (!sliverCollapsed) {
  //         // do what ever you want when silver is collapsing !

  //         appBarTitle = '${data['pName']} ${data['pSurname']}';
  //         sliverCollapsed = true;
  //         setState(() {});
  //       }
  //     }
  //     if (_scrollController.offset <= 40
  //         // &&
  //         //     !_scrollController.position.outOfRange
  //         ) {
  //       if (sliverCollapsed) {
  //         // do what ever you want when silver is expanding !

  //         appBarTitle = '';
  //         sliverCollapsed = false;
  //         setState(() {});
  //       }
  //     }
  //   });
  //   super.initState();
  // }

  @override
  void didChangeDependencies() async {
    _scrollController = ScrollController();

    if (!_loadedData) {
      // {
      //   'tpid': 'tp0001',
      //   'pid': 'pisut.s@mail.com',
      //   'pName': 'Pisut Suntronkiti',
      // }
      _loadedData = true;
      routeArg = ModalRoute.of(context).settings.arguments;
      pFullName = routeArg['pName'];
      patientInfo = Provider.of<PatientInfo>(context);
      patientInfo.pInfoLoad = false;
      patientInfo.symp_condLoad = false;
      patientInfo.vital_painLoad = false;
      patientInfo.prescrip_suggestLoad = false;
      print('==> PtInfo Start Loading');
      print('routeArg: $routeArg');
      await patientInfo.getPatInfo(routeArg['pid'], routeArg['tpid']);
    }

    _scrollController.addListener(
      () {
        if (_scrollController.offset > 80 &&
            !_scrollController.position.outOfRange) {
          if (!sliverCollapsed) {
            // do what ever you want when silver is collapsing !

            appBarTitle = pFullName;
            sliverCollapsed = true;
            setState(() {});
          }
        }
        if (_scrollController.offset <= 40
            // &&
            //     !_scrollController.position.outOfRange
            ) {
          if (sliverCollapsed) {
            // do what ever you want when silver is expanding !

            appBarTitle = '';
            sliverCollapsed = false;
            setState(() {});
          }
        }
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final String tpId = ModalRoute.of(context).settings.arguments;
    final Map<String, dynamic> data = _loadData(
      routeArg['tpid'],
    );
    final appBar = SliverAppBar(
      title: Text(
        appBarTitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      floating: false,
      pinned: true,
      snap: false,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.menu_rounded,
            color: Colors.transparent,
          ),
          onPressed: null,
        )
      ],
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop()),
      expandedHeight: 200,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                    stops: [
                      0.4,
                      1.0,
                    ]),
              ),
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/default_photo.png'),
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 25,
                    child: FittedBox(
                      child: Text(
                        '${routeArg['pName']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Container(
                  //   height: 15,
                  //   child: FittedBox(
                  //     child: Text(
                  //       'Next Appointment : ${DateFormat.yMMMEd().format(data['apDt'])}',
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 45),
                ],
              ),
            ),
          );
        },
      ),
      bottom: TabBar(
        // indicatorSize: ,
        isScrollable: true,
        indicatorWeight: 4.0,
        indicatorColor: Theme.of(context).primaryColorLight,
        labelColor: Colors.white,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelColor: Colors.white54,
        tabs: <Widget>[
          Container(
            height: 20,
            child: Tab(
              text: 'Basic info',
            ),
          ),
          Container(
            height: 20,
            child: Tab(
              text: 'Disease/Symptom',
            ),
          ),
          Container(
            height: 20,
            child: Tab(
              text: 'Vital sign',
            ),
          ),
          Container(
            height: 20,
            child: Tab(
              text: 'Suggestion',
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      body: (patientInfo.pInfoLoad &&
              patientInfo.symp_condLoad &&
              patientInfo.vital_painLoad &&
              patientInfo.prescrip_suggestLoad)
          ? DefaultTabController(
              length: 4,
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, value) {
                  return [appBar];
                },
                body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    BasicInfoTab(),
                    DiseaseSymptomTab(),
                    VitalSignTab(),
                    SuggestionTab(),
                    // BasicInfoTab(data['userId']),
                    // DiseaseSymptomTab(routeArg['tpid']),
                    // VitalSignTab(routeArg['tpid']),
                    // SuggestionTab(routeArg['tpid']),
                  ],
                ),
              ),
            )
          : Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                child: CircularProgressIndicator(
                  strokeWidth: 5.0,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
            ),
    );
  }
}
