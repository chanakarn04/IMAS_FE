import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

import './chatRoom.dart';
import './PatientInfoPage.dart';
import '../Provider/user-info.dart';
import '../Provider/chatRoom_info.dart';

class AppointmentDoctorPage extends StatefulWidget {
  static const routeName = '/appointment-doctor';

  @override
  _AppointmentDoctorPageState createState() => _AppointmentDoctorPageState();
}

class _AppointmentDoctorPageState extends State<AppointmentDoctorPage> {
  CalendarController _calendarController;
  DateTime _selectedDate;
  var _loadedData = false;

  List<Map<String, dynamic>> data = [];

  // List<Map<String, Object>> _loadData(
  //     // String userId,
  //     ) {
  // load data from server
  // get apDt of last ap and dr Name

  //   List<Map<String, dynamic>> data = [
  //     {
  //       'apId': 'ap001',
  //       'tpId': 'tp001',
  //       'image': 'assets/images/default_photo.png',
  //       'pName': 'Samitanan Techabunyawatthanakul',
  //       'apDt': DateTime(2021, 2, 25, 14, 30),
  //     },
  //     {
  //       'apId': 'ap002',
  //       'tpId': 'tp002',
  //       'image': 'assets/images/default_photo.png',
  //       'pName': 'Never More',
  //       'apDt': DateTime(2021, 2, 24, 20, 30),
  //     },
  //     {
  //       'apId': 'ap003',
  //       'tpId': 'tp003',
  //       'image': 'assets/images/default_photo.png',
  //       'pName': 'Mega Tron',
  //       'apDt': DateTime(2021, 2, 24, 10, 30),
  //     },
  //     {
  //       'apId': 'ap004',
  //       'tpId': 'tp004',
  //       'image': 'assets/images/default_photo.png',
  //       'pName': 'Hot Rod',
  //       'apDt': DateTime(2021, 2, 24, 9, 20),
  //     },
  //     {
  //       'apId': 'ap005',
  //       'tpId': 'tp005',
  //       'image': 'assets/images/default_photo.png',
  //       'pName': 'Manta Style',
  //       'apDt': DateTime(2021, 2, 24, 18, 15),
  //     },
  //     {
  //       'apId': 'ap006',
  //       'tpId': 'tp006',
  //       'image': 'assets/images/default_photo.png',
  //       'pName': 'Battle Fury',
  //       'apDt': DateTime(
  //         DateTime.now().year,
  //         DateTime.now().month,
  //         DateTime.now().day,
  //         DateTime.now().hour,
  //         DateTime.now().minute - 5,
  //       ),
  //     },
  //     {
  //       'apId': 'ap007',
  //       'tpId': 'tp007',
  //       'image': 'assets/images/default_photo.png',
  //       'pName': 'Nyx Azzin',
  //       'apDt': DateTime(2021, 2, 26, 9, 40),
  //     },
  //     {
  //       'apId': 'ap008',
  //       'tpId': 'tp008',
  //       'image': 'assets/images/default_photo.png',
  //       'pName': 'Mona Lisa',
  //       'apDt': DateTime(2021, 2, 26, 13, 0),
  //     },
  //   ];
  //   return data;
  // }

  Map<DateTime, List<Map<String, Object>>> event = {};

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
    event = Map.fromIterables(_dt, _eventList);
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
  void didChangeDependencies() async {
    if (!_loadedData) {
      final userInfo = Provider.of<UserInfo>(context);
      userInfo.calendarAptloading = true;
      userInfo.calendarApt = [];
      userInfo.treatmentPlan = [];
      await userInfo.calendarAppointment();
      _loadedData = true;
      data = userInfo.calendarApt;
      print('==> data: $data');
      // "payload":[
      //   {"_id":"609a336dc5100400298ed476","status":2,"apdt":"2021-05-11T07:34:05.239Z","tpid_ref":"609a336dc5100400298ed475","__v":0},
      //   {"_id":"609a34e5c975330029609f14","status":2,"apdt":"2021-05-11T07:58:00.000Z","tpid_ref":"609a336dc5100400298ed475","__v":0},
      //   {"_id":"609a524ba317c2001fae33df","status":2,"apdt":"2021-05-11T09:53:00.000Z","tpid_ref":"609a336dc5100400298ed475","__v":0},
      //   {"_id":"609a524ba317c2001fae33e0","status":2,"apdt":"2021-05-11T09:55:00.000Z","tpid_ref":"609a336dc5100400298ed475","__v":0},
      //   {"_id":"609a573aa317c2001fae33e1","status":2,"apdt":"2021-05-11T10:24:00.000Z","tpid_ref":"609a336dc5100400298ed475","__v":0},
      //   {"_id":"609e23bbbe47e8001ff7f469","status":2,"apdt":"2021-05-14T07:34:00.000Z","tpid_ref":"609a336dc5100400298ed475","__v":0},
      //   {"_id":"609e2594be47e8001ff7f46a","status":2,"apdt":"2021-05-14T07:42:00.000Z","tpid_ref":"609a336dc5100400298ed475","__v":0},
      //   {"_id":"609e2594be47e8001ff7f46b","status":2,"apdt":"2021-05-14T07:42:00.000Z","tpid_ref":"609a336dc5100400298ed475","__v":0}
      // ]
      _createEvent();
      if (event[_selectedDate] != null) {
        _selectedEvent = event[_selectedDate];
      } else {
        _selectedEvent = [];
      }
    }
    // data = _loadData(
    //     // userInfo.userId
    //     );
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
    final userInfo = Provider.of<UserInfo>(context);
    final chatroom = Provider.of<ChatRoomProvider>(context);
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
      body: (userInfo.calendarAptloading)
          ? Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                child: CircularProgressIndicator(
                  strokeWidth: 5.0,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
            )
          : Column(
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
                  events: event,
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
                            // color: Theme.of(context).primaryColor,
                            // fontWeight: FontWeight.bold,
                            fontSize: 24,
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
                                  DateTime now = DateTime.now();
                                  DateTime tempDt = DateTime(
                                      now.year,
                                      now.month,
                                      now.day,
                                      now.hour,
                                      now.minute + 5);
                                  print('event => ${_selectedEvent[index]}');
                                  print(
                                      'aptDt => ${_selectedEvent[index]['apDt'].runtimeType}');
                                  print(
                                      'aptDt => ${_selectedEvent[index]['apDt']}');
                                  print(
                                      'nowDt => ${DateTime.now().runtimeType}');
                                  print('nowDt => ${DateTime.now()}');
                                  print('temDt => ${tempDt.runtimeType}');
                                  print('temDt => $tempDt');
                                  // print('diffenrece => ${_selectedEvent[index]['apDt'].difference(DateTime.now()).inMinutes - 420}');
                                  print(
                                      'diffenrece => ${DateTime.parse(_selectedEvent[index]['apDt'].toString()).difference(DateTime.now()).inMinutes - 390}');
                                  print(
                                      'Test diffenrece => ${now.difference(tempDt).inMinutes}');
                                  // ((DateTime.now().difference(_selectedEvent[index]['apDt']).inMinutes >= 0) &&
                                  //             (DateTime.now().difference(_selectedEvent[index]['apDt']).inMinutes <=30))
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, left: 20, right: 20),
                                    child: Container(
                                      // height: 40,
                                      // width: ,
                                      // padding: EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          // width: 3,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ListTile(
                                        leading: Container(
                                          height: 40,
                                          width: 40,
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
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          _selectedEvent[index]['pName'],
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 18,
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
                                        trailing: (_selectedEvent[index]
                                                    ['status'] ==
                                                2)
                                            ? ((DateTime.parse(_selectedEvent[
                                                                            index]
                                                                        ['apDt']
                                                                    .toString())
                                                                .difference(
                                                                    DateTime
                                                                        .now())
                                                                .inMinutes -
                                                            390 >=
                                                        0) &&
                                                    (DateTime.parse(_selectedEvent[
                                                                            index]
                                                                        ['apDt']
                                                                    .toString())
                                                                .difference(
                                                                    DateTime
                                                                        .now())
                                                                .inMinutes -
                                                            390 <=
                                                        30))
                                                ? SizedBox(
                                                    height: 35,
                                                    width: 35,
                                                    child: InkWell(
                                                      child: Icon(
                                                        Icons
                                                            .chat_bubble_outline_rounded,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 30,
                                                      ),
                                                      onTap: () {
                                                        if (!chatroom
                                                            .chatRoomRegis) {
                                                          chatroom
                                                              .aptDoctorCreateChat(
                                                                  Role.Doctor);
                                                        }
                                                        Navigator.of(context)
                                                            .pushNamed(ChatRoom
                                                                .routeName);
                                                        // Navigator.of(context)
                                                        //     .pushNamed(
                                                        //         ChatRoom.routeName);
                                                      },
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: 35,
                                                    width: 35,
                                                    child: InkWell(
                                                      child: Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 30,
                                                      ),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                PatientInfoPage
                                                                    .routeName,
                                                                arguments: {
                                                              'tpid':
                                                                  data[index]
                                                                      ['tpid'],
                                                              'pid': data[index]
                                                                  ['pid'],
                                                              'pName':
                                                                  data[index]
                                                                      ['pName'],
                                                            });
                                                      },
                                                    ),
                                                  )
                                            : SizedBox(
                                                height: 35,
                                                width: 35,
                                                child: InkWell(
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    size: 30,
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            PatientInfoPage
                                                                .routeName,
                                                            arguments: {
                                                          'tpid': data[index]
                                                              ['tpid'],
                                                          'pid': data[index]
                                                              ['pid'],
                                                          'pName': data[index]
                                                              ['pName'],
                                                        });
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
