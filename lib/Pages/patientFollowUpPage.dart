import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../Provider/user-info.dart';
import '../Widget/patientBox.dart';

class PatientFollowUpPage extends StatefulWidget {
  static const routeName = '/patient-followUp';

  @override
  _PatientFollowUpPageState createState() => _PatientFollowUpPageState();
}

class _PatientFollowUpPageState extends State<PatientFollowUpPage> {
  var _loadedData = false;

  List<Map<String, dynamic>> todayApt = [];
  List<Map<String, dynamic>> otherApt = [];

  @override
  void didChangeDependencies() async {
    if (!_loadedData) {
      _loadedData = true;
      final userInfo = Provider.of<UserInfo>(context);
      userInfo.ptFollowUpLoading = true;
      userInfo.calendarApt = [];
      userInfo.ptFollowUp = [];
      userInfo.treatmentPlan = [];
      await userInfo.calendarAppointment();
      await userInfo.patientFollowUpInfo();
      final List<Map<String, dynamic>> data = userInfo.ptFollowUp;
      DateTime now = DateTime.now();
      todayApt = data.where((elm) =>
              DateTime(elm['apDt'].year, elm['apDt'].month, elm['apDt'].day)
                  .difference(DateTime(now.year, now.month, now.day))
                  .inDays == 0).toList();
      otherApt = data.where((elm) =>
              DateTime(elm['apDt'].year, elm['apDt'].month, elm['apDt'].day)
                  .difference(DateTime(now.year, now.month, now.day))
                  .inDays != 0).toList();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
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
      body: (userInfo.ptFollowUpLoading)
          ? Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                child: CircularProgressIndicator(
                  strokeWidth: 5.0,
                  valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Today\'s Appointments',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    (todayApt.length != 0)
                        ? Container(
                            height: (75.0 * todayApt.length) + 30,
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              itemBuilder: (context, index) {
                                return PatientBox(
                                  pName: todayApt[index]['pName'],
                                  pid: todayApt[index]['pid'],
                                  imageAsset: todayApt[index]['imageAsset'],
                                  aptDt: todayApt[index]['apDt'],
                                  tpId: todayApt[index]['tpid'],
                                );
                              },
                              itemCount: todayApt.length,
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            alignment: Alignment.center,
                            child: Text(
                              'No appointment today.',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Other patients',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    (otherApt.length != 0)
                        ? Container(
                            height: (75.0 * otherApt.length) + 30,
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              itemBuilder: (context, index) {
                                return PatientBox(
                                  pName: otherApt[index]['pName'],
                                  pid: otherApt[index]['pid'],
                                  imageAsset: otherApt[index]['imageAsset'],
                                  aptDt: otherApt[index]['apDt'],
                                  tpId: otherApt[index]['tpid'],
                                );
                              },
                              itemCount: otherApt.length,
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            alignment: Alignment.center,
                            child: Text(
                              'No other patients.',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
