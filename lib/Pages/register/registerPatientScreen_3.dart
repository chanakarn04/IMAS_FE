import 'package:flutter/material.dart';

import '../loginPage.dart';
import '../../Widget/AdaptiveRaisedButton.dart';
import '../../Widget/adaptiveBorderButton.dart';
import '../../Widget/progressDot.dart';

class RegisterPatient3Screen extends StatefulWidget {
  static const routeName = '/Register-patient-step3';

  @override
  _RegisterPatient3ScreenState createState() => _RegisterPatient3ScreenState();
}

class _RegisterPatient3ScreenState extends State<RegisterPatient3Screen> {
  final List<TextEditingController> textControllers = [];
  int length = 1;

  @override
  void initState() {
    textControllers.add(TextEditingController());
    super.initState();
  }

  void addTextField() {
    setState(() {
      length++;
      textControllers.add(TextEditingController());
    });
  }

  void rmvTextField() {
    setState(() {
      length--;
      textControllers.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> registerData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            bottom: 30,
            top: 50,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Do you have any drug allergy?',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                // height: (length < 7) ? 50 * length.toDouble() : 350,
                // color: Colors.pink[200],
                child: (length == 0)
                    ? Container(
                        // color: Colors.amber,
                        alignment: Alignment.topLeft,
                        child: Text(
                            'No drugs yet.\nTap add button on bottom right corner'))
                    : ListView.builder(
                        padding: EdgeInsets.only(left: 10),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextField(
                                    controller: textControllers[index],
                                    decoration: InputDecoration(
                                        hintText: 'e.g. Paracetamol'),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_rounded,
                                  color: Colors.grey,
                                ),
                                onPressed: rmvTextField,
                              )
                            ],
                          );
                        },
                        itemCount: length,
                      ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add_rounded),
                    color: Colors.white,
                    onPressed: addTextField,
                  ),
                ),
              ),
              // Expanded(child: Container()),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AdaptiveBorderButton(
                    buttonText: 'Back',
                    handlerFn: () {
                      Navigator.of(context).pop();
                    },
                    width: 130,
                    height: 50,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  AdaptiveRaisedButton(
                    buttonText: (length == 0) ||
                            (length == 1 && textControllers[0].text.isEmpty)
                        ? 'Skip'
                        : 'Submit',
                    handlerFn: () {
                      // add list of drug allergy to allergy key
                      // like {'allergy': list}
                      // ...
                      // update to server
                      // ...
                      // show alertDialog
                      // ...
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName(LogInPage.routeName));
                      print('Register Done!!');
                    },
                    width: 120,
                    height: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
