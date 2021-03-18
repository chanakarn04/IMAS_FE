import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './adaptiveBorderButton.dart';
import './AdaptiveRaisedButton.dart';
import '../Pages/closeCasePage.dart';
import '../Provider/caseManagement_Info.dart';

class CaseManagementCreateAppointment extends StatefulWidget {
  // final String pName;
  // final Function datePicker;
  // final Function timePicker;
  DateTime date;
  TimeOfDay time;

  CaseManagementCreateAppointment(
    // this.pName,
    // this.datePicker,
    // this.timePicker,
    this.date,
    this.time,
  );
  @override
  _CaseManagementCreateAppointmentState createState() =>
      _CaseManagementCreateAppointmentState();
}

class _CaseManagementCreateAppointmentState
    extends State<CaseManagementCreateAppointment> {
  DateTime selectedDate = DateTime.now().add(Duration(days: 2));
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    selectedDate = widget.date;
    selectedTime = widget.time;
    super.initState();
  }

  void _presentDatePicker() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      // initialDate: DateTime(DateTime.now().year),
      // firstDate: DateTime(1950),
      // lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _presentTimePicker() async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      // initialDate: selectedDate,
      // firstDate: DateTime.now(),
      // lastDate: DateTime(DateTime.now().year + 1),
      initialTime: TimeOfDay(hour: selectedDate.hour, minute: 0),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cmInfo = Provider.of<CMinfoProvider>(context);
    return Container(
      height: 300,
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
        top: 20,
        bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Create appointment',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'with',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              cmInfo.pName,
              style: TextStyle(
                fontSize: 24,
                // color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'on',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text(
                  // 'test',
                  '${DateFormat.yMd().format(selectedDate)}',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 35,
                  width: 35,
                  child: InkWell(
                    child: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                    onTap: _presentDatePicker,
                  ),
                ),
                Expanded(child: Container()),
                Text(
                  '${selectedTime.format(context)}',
                  // '${DateFormat.jm().format(this.widget.selectedTime)}',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 35,
                  width: 35,
                  child: InkWell(
                    child: Icon(
                      Icons.access_time_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                    onTap: _presentTimePicker,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Expanded(child: Container()),
              AdaptiveBorderButton(
                buttonText: 'Cancel',
                handlerFn: () {
                  // controller.clear();
                  Navigator.of(context).pop();
                },
                height: 40,
                width: 150,
              ),
              SizedBox(
                width: 20,
              ),
              AdaptiveRaisedButton(
                buttonText: 'Create',
                handlerFn: () {
                  print('Create appointment');
                  setState(() {
                    this.widget.date = selectedDate;
                    this.widget.time = selectedTime;
                  });
                  cmInfo.createAppointment(
                    DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    ),
                  );
                  cmInfo.cleanDispose();
                  // cmInfo.dispose();
                  Navigator.of(context).popAndPushNamed(
                    CloseCasePage.routneName,
                    arguments: {
                      'name': cmInfo.pName,
                      'closeCase': false,
                      'date': DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      ),
                    },
                  );
                  // Not passing back for now.
                  print('${DateFormat.yMd().format(this.widget.date)}');
                  print('${this.widget.time.format(context)}');
                },
                height: 30,
                width: 140,
              ),
              // Expanded(child: Container()),
            ],
          ),
        ],
      ),
    );
  }
}
