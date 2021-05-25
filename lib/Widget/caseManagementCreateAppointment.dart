import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_widget/time_picker_widget.dart' as timePicker;

import './adaptiveBorderButton.dart';
import './AdaptiveRaisedButton.dart';
import '../Pages/closeCasePage.dart';
import '../Provider/caseManagement_Info.dart';
import '../Provider/chatRoom_info.dart';
import '../Provider/user-info.dart';

class CaseManagementCreateAppointment extends StatefulWidget {
  // final String pName;
  // final Function datePicker;
  // final Function timePicker;
  final List<Map<String, dynamic>> apt;
  // DateTime date;
  // TimeOfDay time;

  CaseManagementCreateAppointment(
    // this.pName,
    // this.datePicker,
    // this.timePicker,
    this.apt,
    // this.date,
    // this.time,
  );
  @override
  _CaseManagementCreateAppointmentState createState() =>
      _CaseManagementCreateAppointmentState();
}

class _CaseManagementCreateAppointmentState
    extends State<CaseManagementCreateAppointment> {
  // DateTime selectedDate = DateTime.now().add(Duration(days: 2));
  DateTime selectedDate;
  // TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime;

  List<DateTime> events = [];
  List<DateTime> thisDayEvents = [];

  var _loadData = false;
  String test;

  // @override
  // void initState() {
  //   selectedDate = widget.date;
  //   selectedTime = widget.time;
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (!_loadData) {
      for (Map<String, dynamic> ap in this.widget.apt) {
        events.add(ap['apDt']);
      }
      _loadData = true;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _loadEvent() {
    for (Map<String, dynamic> ap in this.widget.apt) {
      events.add(ap['apDt']);
    }
  }

  void _presentDatePicker() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 2)),
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
        thisDayEvents.clear();
        selectedDate = picked;
        thisDayEvents.addAll(events
            .where((apt) =>
                (picked.year == apt.year) &&
                (picked.month == apt.month) &&
                (picked.day == apt.day))
            .toList());
        print('thisDayEvent: $thisDayEvents');
      });
    }
  }

  void _presentTimePicker() async {
    final TimeOfDay picked = await timePicker.showCustomTimePicker(
      context: context,
      onFailValidation: (context) {},
      // selectableTimePredicate: (time) => (time.hour >= 5) && (time.minute < 50),
      selectableTimePredicate: (time) {
        var _b = true;
        if (events.isNotEmpty) {
          for (DateTime aptDt in thisDayEvents) {
            if (aptDt.minute < 15) {
              if ((time.hour == aptDt.hour) &&
                  (time.minute < aptDt.minute + 15)) {
                _b = false;
                break;
              } else if ((time.hour == aptDt.hour - 1) &&
                  (time.minute > (aptDt.minute + 45))) {
                _b = false;
                break;
              }
            } else if (aptDt.minute > 45) {
              if ((time.hour == aptDt.hour) &&
                  (time.minute > aptDt.minute - 15)) {
                _b = false;
                break;
              } else if ((time.hour == aptDt.hour + 1) &&
                  (time.minute < (aptDt.minute - 45))) {
                _b = false;
                break;
              }
            }
            if (time.hour == aptDt.hour) {
              if ((time.minute > aptDt.minute - 15) &&
                  (time.minute < aptDt.minute + 15)) {
                _b = false;
                break;
              }
            }
          }
        }
        return _b;
      },
      initialTime: TimeOfDay(
        hour: 0,
        minute: 0,
      ),
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
    final chatroom = Provider.of<ChatRoomProvider>(context);
    print('tpid: ${chatroom.tpid}');
    final userInfo = Provider.of<UserInfo>(context, listen: false);
    // print(this.widget.apt);
    // _loadEvent();
    // print(events);
    return Container(
      height: 400,
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
                // fontWeight: FontWeight.bold,
                fontSize: 28,
                // color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(right: 30),
            child: Text(
              'Specify date and time below to make an appointment with patient',
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color.fromARGB(255, 165, 165, 165),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.grey[400],
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Date',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Row(
              children: [
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    // 'test',
                    (selectedDate == null)
                        ? 'No date select'
                        : '${DateFormat.yMd().format(selectedDate)}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                color: Colors.grey[400],
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Time',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Row(
              children: [
                TextButton(
                  onPressed: (selectedDate == null) ? null : _presentTimePicker,
                  child: (selectedDate == null)
                      ? Text(
                          'Select Date first',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey[400],
                          ),
                        )
                      : Text(
                          (selectedTime == null)
                              ? 'No time select'
                              : '${selectedTime.format(context)}',
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).primaryColor,
                          ),
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
                handlerFn: () async {
                  print(chatroom.tpid);
                  print('Create appointment');
                  // setState(() {
                  //   this.widget.date = selectedDate;
                  //   this.widget.time = selectedTime;
                  // });
                  await cmInfo.createAppointment(
                    chatroom.tpid,
                    DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    ),
                  );
                  await chatroom.deleteChatroom();
                  await cmInfo.upload(chatroom.apid, chatroom.note, 0);
                  await userInfo.updatePlan(chatroom.tpid, 0);
                  chatroom.closeChat();
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
                  // print('${DateFormat.yMd().format(this.widget.date)}');
                  // print('${this.widget.time.format(context)}');
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
