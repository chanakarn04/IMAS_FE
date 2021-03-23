import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart';

// import '../Models/model.dart';

class VitalSignProvider with ChangeNotifier {
  String tpId;
  double temp;
  double pulse;
  double breath;
  List<double> pressure;

  void uploadValue(
    String userId,
  ) {
    // ... uplad vital sign data to server
    // ... use userId to find tpId
    // ... use DateTime.now() as vsDt

    // test zone
    print(temp);
    print(pulse);
    print(breath);
    print('${pressure[0]}/${pressure[1]}');
  }
}
