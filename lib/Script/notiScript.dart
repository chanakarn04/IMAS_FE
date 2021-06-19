import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Pages/homePages.dart';

const initAndroid = AndroidInitializationSettings('noti_icon');
const initIOs = IOSInitializationSettings();
const initSetttings = InitializationSettings(
  android: initAndroid,
  iOS: initIOs,
);

const androidNotiDetail = AndroidNotificationDetails(
  'Noti_IMAS_0',
  'Noti IMAS',
  'Notification of IMAS appplications',
);
const iosNotiDetail = IOSNotificationDetails();
const notiDetails = NotificationDetails(
  android: androidNotiDetail,
  iOS: iosNotiDetail,
);

notiNavigatorPush({
  @required BuildContext context,
  @required String routeName,
  Object argument,
}) {
  Navigator.of(context).popUntil(ModalRoute.withName(HomePage.routeName));
  if (argument == null) {
    Navigator.of(context).pushNamed(routeName);
  } else {
    Navigator.of(context).pushNamed(routeName, arguments: argument);
  }
}
