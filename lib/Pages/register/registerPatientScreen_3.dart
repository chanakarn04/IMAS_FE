import 'package:flutter/material.dart';

// import '../loginPage.dart';
// import '../../Widget/AdaptiveRaisedButton.dart';
// import '../../Widget/adaptiveBorderButton.dart';
import '../../Widget/progressDot.dart';
import '../../Widget/drugAllergyListItemBox.dart';
import '../../Widget/registeredBody.dart';

class RegisterPatient3Screen extends StatefulWidget {
  static const routeName = '/Register-patient-step3';

  @override
  _RegisterPatient3ScreenState createState() => _RegisterPatient3ScreenState();
}

class _RegisterPatient3ScreenState extends State<RegisterPatient3Screen> {
  List<String> drug = [];

  var _isLogIn = false;

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
    Map<String, dynamic> registerData =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: (_isLogIn)
          ? registerdBody(context)
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
                                onPressed: () {
                                  registerData.addAll({
                                    'drugAllegy': drug,
                                  });
                                  // ... send register to server HERE
                                  // ... use RegisteredData
                                  // ...
                                  setState(() {
                                    _isLogIn = true;
                                  });
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

              // Container(
              //   padding: EdgeInsets.only(
              //     left: 30,
              //     right: 30,
              //     bottom: 30,
              //     top: 50,
              //   ),
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget>[
              //       Container(
              //         alignment: Alignment.centerLeft,
              //         child: Text(
              //           'Register',
              //           style: TextStyle(
              //             color: Theme.of(context).primaryColor,
              //             fontSize: 36,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 35,
              //       ),
              //       Container(
              //         alignment: Alignment.centerLeft,
              //         child: Text(
              //           'Do you have any drug allergy?',
              //           style: TextStyle(fontSize: 24),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       Expanded(
              //         // height: (length < 7) ? 50 * length.toDouble() : 350,
              //         // color: Colors.pink[200],
              //         child: (length == 0)
              //             ? Container(
              //                 // color: Colors.amber,
              //                 alignment: Alignment.topLeft,
              //                 child: Text(
              //                     'No drugs yet.\nTap add button on bottom right corner'))
              //             : ListView.builder(
              //                 padding: EdgeInsets.only(left: 10),
              //                 itemBuilder: (context, index) {
              //                   return Row(
              //                     children: [
              //                       Expanded(
              //                         child: SizedBox(
              //                           height: 50,
              //                           child: TextField(
              //                             controller: textControllers[index],
              //                             decoration: InputDecoration(
              //                                 hintText: 'e.g. Paracetamol'),
              //                           ),
              //                         ),
              //                       ),
              //                       IconButton(
              //                         icon: Icon(
              //                           Icons.delete_rounded,
              //                           color: Colors.grey,
              //                         ),
              //                         onPressed: rmvTextField,
              //                       )
              //                     ],
              //                   );
              //                 },
              //                 itemCount: length,
              //               ),
              //       ),
              //       SizedBox(
              //         height: 15,
              //       ),
              //       Align(
              //         alignment: Alignment.centerRight,
              //         child: Container(
              //           height: 52,
              //           width: 52,
              //           decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Theme.of(context).primaryColor,
              //           ),
              //           child: IconButton(
              //             icon: Icon(Icons.add_rounded),
              //             color: Colors.white,
              //             onPressed: addTextField,
              //           ),
              //         ),
              //       ),
              //       // Expanded(child: Container()),
              //       SizedBox(
              //         height: 15,
              //       ),
              //       ProgressDot(
              //         length: 3,
              //         markedIndex: 3,
              //       ),
              //       SizedBox(
              //         height: 15,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           AdaptiveBorderButton(
              //             buttonText: 'Back',
              //             handlerFn: () {
              //               Navigator.of(context).pop();
              //             },
              //             width: 130,
              //             height: 50,
              //           ),
              //           SizedBox(
              //             width: 30,
              //           ),
              //           AdaptiveRaisedButton(
              //             buttonText: (length == 0) ||
              //                     (length == 1 && textControllers[0].text.isEmpty)
              //                 ? 'Skip'
              //                 : 'Submit',
              //             handlerFn: () {
              //               // add list of drug allergy to allergy key
              //               // like {'allergy': list}
              //               // ...
              //               // update to server
              //               // ...
              //               // show alertDialog
              //               // ...
              //               Navigator.of(context)
              //                   .popUntil(ModalRoute.withName(LogInPage.routeName));
              //               print('Register Done!!');
              //             },
              //             width: 120,
              //             height: 40,
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ),
    );
  }
}
