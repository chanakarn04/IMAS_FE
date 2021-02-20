import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

import '../closeCasePage.dart';
import '../../Widget/showMyDialog.dart';
import '../../Widget/caseManagementCreateAppointment.dart';

class CaseManagementTab extends StatefulWidget {
  @override
  _CaseManagementTabState createState() => _CaseManagementTabState();
}

class _CaseManagementTabState extends State<CaseManagementTab> {
  DateTime selectedDate = DateTime.now().add(Duration(days: 2));
  TimeOfDay selectedTime = TimeOfDay.now();

  Widget _buildBox({
    BuildContext context,
    Color color,
    String title,
    String description,
    String buttonTitle,
    Function buttonFn,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: color,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            topLeft: Radius.circular(15),
          )),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              subtitle: Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 40,
              width: 180,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: color,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FlatButton(
                  child: Text(
                    buttonTitle,
                    style: TextStyle(color: color),
                  ),
                  onPressed: buttonFn,
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
        ],
      ),
    );
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
            child: _buildBox(
                context: context,
                color: Color.fromARGB(255, 255, 0, 0),
                title: 'Critical',
                description: '    Patient need to go to hospital right now!',
                buttonTitle: 'Close case',
                buttonFn: () {
                  showMyDialog(
                    context,
                    'Critical?',
                    'Confirm to close case as critical?',
                    'cancel',
                    'confirm',
                    () {
                      print('close case as critical');
                      Navigator.of(context)
                          .popAndPushNamed(CloseCasePage.routneName);
                    },
                  );
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: _buildBox(
                context: context,
                color: Color.fromARGB(255, 81, 195, 169),
                title: 'Cured',
                description: '    Patient has cured or has no symptom anymore.',
                buttonTitle: 'Close case',
                buttonFn: () {
                  showMyDialog(
                    context,
                    'Cured?',
                    'Confirm to close case as cured?',
                    'cancel',
                    'confirm',
                    () {
                      print('close case as Cured');
                      Navigator.of(context)
                          .popAndPushNamed(CloseCasePage.routneName);
                    },
                  );
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: _buildBox(
                context: context,
                color: Color.fromARGB(255, 77, 159, 206),
                title: 'On track',
                description:
                    '    Close this consult and make appointment of next consult.',
                buttonTitle: 'Create appointment',
                buttonFn: () {
                  showModalBottomSheet(
                    context: context,
                    isDismissible: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return CaseManagementCreateAppointment(
                        'Harold Pain',
                        selectedDate,
                        selectedTime,
                      );
                    },
                  );
                }),
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
