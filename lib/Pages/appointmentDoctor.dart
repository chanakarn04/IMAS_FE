import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import './chatRoom.dart';
import './PatientInfoPage.dart';

class AppointmentDoctorPage extends StatefulWidget {
  static const routeName = '/appointment-doctor';

  @override
  _AppointmentDoctorPageState createState() => _AppointmentDoctorPageState();
}

class _AppointmentDoctorPageState extends State<AppointmentDoctorPage> {
  CalendarController _calendarController;
  DateTime _selectedDate;

  // Expected data from BE
  List<Map<String, Object>> data = [
    {
      'apId': 'ap001',
      'tpId': 'tp001',
      'image': 'assets/images/default_photo.png',
      'pName': 'Samitanan Techabunyawatthanakul',
      'apDt': DateTime(2021, 2, 25, 14, 30),
    },
    {
      'apId': 'ap002',
      'tpId': 'tp002',
      'image': 'assets/images/default_photo.png',
      'pName': 'Never More',
      'apDt': DateTime(2021, 2, 24, 20, 30),
    },
    {
      'apId': 'ap003',
      'tpId': 'tp003',
      'image': 'assets/images/default_photo.png',
      'pName': 'Mega Tron',
      'apDt': DateTime(2021, 2, 24, 10, 30),
    },
    {
      'apId': 'ap004',
      'tpId': 'tp004',
      'image': 'assets/images/default_photo.png',
      'pName': 'Hot Rod',
      'apDt': DateTime(2021, 2, 24, 9, 20),
    },
    {
      'apId': 'ap005',
      'tpId': 'tp005',
      'image': 'assets/images/default_photo.png',
      'pName': 'Manta Style',
      'apDt': DateTime(2021, 2, 24, 18, 15),
    },
    {
      'apId': 'ap006',
      'tpId': 'tp006',
      'image': 'assets/images/default_photo.png',
      'pName': 'Battle Fury',
      'apDt': DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        DateTime.now().hour,
        DateTime.now().minute - 5,
      ),
    },
    {
      'apId': 'ap007',
      'tpId': 'tp007',
      'image': 'assets/images/default_photo.png',
      'pName': 'Nyx Azzin',
      'apDt': DateTime(2021, 2, 26, 9, 40),
    },
    {
      'apId': 'ap008',
      'tpId': 'tp008',
      'image': 'assets/images/default_photo.png',
      'pName': 'Mona Lisa',
      'apDt': DateTime(2021, 2, 26, 13, 0),
    },
  ];

  Map<DateTime, List<Map<String, Object>>> _event = {};

  List<Map<String, Object>> _selectedEvent = [];

  _createEvent() {
    DateTime _tempDt;
    int _tempIndex;
    List<DateTime> _dt = [];
    List<List<Map<String, Object>>> _eventList = [];
    for (Map<String, Object> item in data) {
      _tempDt = item['apDt'];
      if (_dt.contains(DateTime(_tempDt.year, _tempDt.month, _tempDt.day))) {
        _tempIndex =
            _dt.indexOf(DateTime(_tempDt.year, _tempDt.month, _tempDt.day));
        _eventList[_tempIndex].add(item);
      } else {
        _dt.add(DateTime(_tempDt.year, _tempDt.month, _tempDt.day));
        _tempIndex =
            _dt.indexOf(DateTime(_tempDt.year, _tempDt.month, _tempDt.day));
        _eventList.add([item]);
      }
    }
    for (List<Map<String, Object>> list in _eventList) {
      list.sort((a, b) {
        DateTime aDt = a['apDt'];
        DateTime bDt = b['apDt'];
        return aDt.compareTo(bDt);
      });
    }
    _event = Map.fromIterables(_dt, _eventList);
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _selectedDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
  }

  @override
  void didChangeDependencies() {
    _createEvent();
    if (_event[_selectedDate].isNotEmpty) {
      _selectedEvent = _event[_selectedDate];
    } else {
      _selectedEvent = [];
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Widget _buildSeperator(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Container(
            height: 1,
            color: Theme.of(context).primaryColor,
          )),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
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
          child: Text('Appointment'),
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
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarController: _calendarController,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
              CalendarFormat.week: 'Week',
            },
            onDaySelected: (day, events, holidays) {
              setState(() {
                _selectedDate = DateTime(day.year, day.month, day.day);
                if (events.isNotEmpty) {
                  _selectedEvent = events;
                } else {
                  _selectedEvent = [];
                }
              });
            },
            events: _event,
            initialSelectedDay: _selectedDate,
            initialCalendarFormat: CalendarFormat.week,
            headerStyle: HeaderStyle(
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
              formatButtonDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            calendarStyle: CalendarStyle(
              todayColor: Theme.of(context).primaryColor.withAlpha(204),
              selectedColor: Theme.of(context).primaryColor,
              markersColor: Theme.of(context).primaryColorDark,
              // markersColor: Theme.of(context).primaryColor,
            ),
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          _buildSeperator(context),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  // color: Colors.teal[200],
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${DateFormat.yMMMMd().format(_selectedDate)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: (_selectedEvent.isNotEmpty)
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                                left: 20,
                              ),
                              child: Container(
                                // height: 40,
                                // width: ,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    )),
                                child: ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage(
                                          _selectedEvent[index]['image'],
                                        ),
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    _selectedEvent[index]['pName'],
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${DateFormat.jm().format(_selectedEvent[index]['apDt'])}',
                                    overflow: TextOverflow.fade,
                                    // style: TextStyle(
                                    //   color: Theme.of(context).primaryColor,
                                    //   fontSize: 20,
                                    // ),
                                  ),
                                  trailing: ((DateTime.now()
                                                  .difference(
                                                      _selectedEvent[index]
                                                          ['apDt'])
                                                  .inMinutes >=
                                              0) &&
                                          (DateTime.now()
                                                  .difference(
                                                      _selectedEvent[index]
                                                          ['apDt'])
                                                  .inMinutes <=
                                              30))
                                      ? SizedBox(
                                          height: 35,
                                          width: 35,
                                          child: InkWell(
                                            child: Icon(
                                              Icons.chat_bubble_outline_rounded,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
                                            ),
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  ChatRoom.routeName);
                                            },
                                          ),
                                        )
                                      : SizedBox(
                                          height: 35,
                                          width: 35,
                                          child: InkWell(
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 30,
                                            ),
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  PatientInfoPage.routeName);
                                            },
                                          ),
                                        ),
                                ),
                              ),
                            );
                          },
                          itemCount: _selectedEvent.length,
                        )
                      : Center(
                          child: Text(
                            'No appointment on this day.',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
