import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../loginPage.dart';
// import '../../Widget/AdaptiveRaisedButton.dart';
// import '../../Widget/adaptiveBorderButton.dart';
// import '../../Script/socketioScript.dart' as socketIO;
import '../../Script/socketioScript.dart';
import '../../Provider/user-info.dart';
import '../../Widget/progressDot.dart';
import '../../Widget/drugAllergyListItemBox.dart';
import '../../Widget/registeredBody.dart';
import '../../Widget/registerError.dart';

class RegisterPatient3Screen extends StatefulWidget {
  static const routeName = '/Register-patient-step3';

  @override
  _RegisterPatient3ScreenState createState() => _RegisterPatient3ScreenState();
}

class _RegisterPatient3ScreenState extends State<RegisterPatient3Screen> {
  List<String> drug = [];

  var _isRegistered = false;
  var _isRegistering = false;
  var _isRegisterSuccess = false;
  var _init = false;
  String errorDescribe;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_init) {
      errorDescribe = '';
      _init = !_init;
    }
    super.didChangeDependencies();
  }

  void addDrug(String drugName) {
    drug.add(drugName);
  }

  void editDrug(String drugName, int index) {
    drug[index] = drugName;
  }

  void removeDrug(int index) {
    drug.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    Map<String, dynamic> registerData =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: (_isRegistering)
          ? (_isRegistered)
              ? (_isRegisterSuccess)
                  ? registerdBody(context)
                  : registerError(
                      context: context,
                      title: Text(
                        'Oops!',
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                      describe: Text(
                        errorDescribe,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ))
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: CircularProgressIndicator(
                          strokeWidth: 8.0,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Registering...',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 5,
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 25),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 27),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Personal Infomation',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 20,
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                  child: DrugAllergyListItemBox(
                                drug: drug,
                                add: addDrug,
                                edit: editDrug,
                                remove: removeDrug,
                              )),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ProgressDot(
                                length: 3,
                                markedIndex: 3,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  registerData.addAll({
                                    'patDrugAllergy': drug,
                                  });
                                  setState(() {
                                    _isRegistering = true;
                                  });
                                  // print(registerData);
                                  // ... send register to server HERE
                                  // ... use RegisteredData
                                  await regisSocketConnect({
                                    'token': '',
                                    'userid': '',
                                  });
                                  await regisSocket.emit('event', [
                                    {
                                      'transaction': 'register',
                                      'payload': registerData
                                    }
                                  ]);
                                  await for (dynamic data in regisSocket.on('r-register')) {
                                    print('On r-register: ${data[0]['value']['payload']['message']}');
                                    // something  more
                                    if (data != null) {
                                      setState(() {
                                        _isRegistered = true;
                                      });
                                      if (data[0]['value']['payload']['message'] == 'Register success') {
                                        setState(() {
                                          _isRegisterSuccess = true;
                                        });
                                      } else {
                                        setState(() {
                                          errorDescribe = data[0]['value']['payload']['message'];
                                        });
                                      }
                                    }
                                  }
                                  await regisSocketDisconnect();
                                  // socketConnect(token).then((_) async {
                                  //   await socketIO.emit('event', [
                                  //     {
                                  //       'transaction': 'register',
                                  //       'payload': registerData
                                  //     }
                                  //   ]);
                                  //   socketIO.on('r-register').listen((data) {
                                  //     // print('On r-register: $data');
                                  //     print(
                                  //         'On r-register: ${data[0]['value']['payload']['message']}');
                                  //     // something  more
                                  //     if (data != null) {
                                  //       setState(() {
                                  //         _isRegistered = true;
                                  //       });
                                  //       if (data[0]['value']['payload']
                                  //               ['message'] ==
                                  //           'Register success') {
                                  //         setState(() {
                                  //           _isRegisterSuccess = true;
                                  //         });
                                  //       } else {
                                  //         setState(() {
                                  //           errorDescribe = data[0]['value']
                                  //               ['payload']['message'];
                                  //         });
                                  //       }
                                  //     }
                                  //   });
                                  // });
                                  // ...
                                  // Navigator.of(context)
                                  //     .pushNamed(RegisterPatient3Screen.routeName);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                  padding: EdgeInsets.all(5),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 0,
                                ),
                                child: Container(
                                  height: 30,
                                  width: 120,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Submit',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
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

// [
//   {
//     magicByte: 2,
//     attributes: 0,
//     timestamp: 1619595297592,
//     offset: 34, 
//     key: null, 
//     value: {
//       transaction: r-register, 
//       passport: {token: , userid: a@b.c}, 
//       payload: {message: Register success, socketId: VTq2MQTf7Hk_6OIYAAAB}
//     }, 
//     headers: {}, i
//     sControlRecord: false, 
//     batchContext: {
//       firstOffset: 34, 
//       firstTimestamp: 1619595297592, 
//       partitionLeaderEpoch: 0, 
//       inTransaction: false, 
//       isControlBatch: false, 
//       lastOffsetDelta: 0, 
//       producerId: -1, 
//       producerEpoch: 0, 
//       firstSequence: 0, 
//       maxTimestamp: 1619595297592, 
//       timestampType: 0, 
//       magicByte: 2
//     }, 
//     topic: gateway, 
//     partition: 0,
//   }
// ]