import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './searchResultPages.dart';
import '../Widget/sideDrawer.dart';
import '../Provider/user-info.dart';
import '../Provider/symptomAssessment.dart';

class AssessmentPages extends StatefulWidget {
  static const routeName = '/assessment';
  @override
  _AssessmentPagesState createState() => _AssessmentPagesState();
}

class _AssessmentPagesState extends State<AssessmentPages> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  final _symptomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context, listen: false);
    final symptomAssessment =
        Provider.of<SymptomAssessmentProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    symptomAssessment.init(userInfo.userData['dob'], userInfo.userData['gender']);
    final _imageWidth = MediaQuery.of(context).size.width - 20;
    final _imageHeight = _imageWidth * 1.25;
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);
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
          child: Text('IMAS'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.transparent,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // alignment: Alignment.centerRight,
                height: size.height * 0.04,
                child: FittedBox(
                  child: Text(
                    'First, what is your main symptom',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.03,
                child: FittedBox(
                  child: Text(
                    'touch the body to choose symptom',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Container(
                height: _imageWidth * 1.25,
                width: _imageWidth,
                // color: Colors.pink.withAlpha(50),
                child: Stack(
                  children: [
                    // Positioned
                    Positioned.fill(
                      child: Container(
                        // color: Colors.pink.withAlpha(50),
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          'assets/images/body.png',
                          // fit: BoxFit.,
                        ),
                      ),
                    ),
                    Positioned(
                      top: _imageHeight * 0.04,
                      // size of screen - padding - container size
                      right: (_imageWidth - (_imageWidth * 0.12)) * 0.5,
                      height: _imageHeight * 0.11,
                      width: _imageWidth * 0.12,
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            // print('search Head');
                            // print(_symptomController.text);
                            _symptomController.text = 'Head';
                            Navigator.of(context).pushNamed(SearchResultPages.routeName,
                              arguments: _symptomController.text);
                          },
                          // child: Container(
                          //   color: Colors.amber.withAlpha(100),
                          // ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: _imageHeight * 0.15,
                      // size of screen - padding - container size
                      right: (_imageWidth - (_imageWidth * 0.2)) * 0.5,
                      height: _imageHeight * 0.03,
                      width: _imageWidth * 0.2,
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            // print('search Neck');
                            _symptomController.text = 'Neck';
                            Navigator.of(context).pushNamed(SearchResultPages.routeName,
                              arguments: _symptomController.text);
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: _imageHeight * 0.18,
                      // size of screen - padding - container size
                      right: (_imageWidth - (_imageWidth * 0.2)) * 0.5,
                      height: _imageHeight * 0.09,
                      width: _imageWidth * 0.2,
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            // print('search Chest');
                            _symptomController.text = 'Chest';
                            Navigator.of(context).pushNamed(SearchResultPages.routeName,
                              arguments: _symptomController.text);
                          },
                          // child: Container(
                          //   color: Colors.purple.withAlpha(100),
                          // ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: _imageHeight * 0.27,
                      // size of screen - padding - container size
                      right: (_imageWidth - (_imageWidth * 0.2)) * 0.5,
                      height: _imageHeight * 0.145,
                      width: _imageWidth * 0.2,
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            // print('search Abdomen');
                            _symptomController.text = 'Abdomen';
                            Navigator.of(context).pushNamed(SearchResultPages.routeName,
                              arguments: _symptomController.text);
                          },
                          // child: Container(
                          //   color: Colors.blue.withAlpha(100),
                          // ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: _imageHeight * 0.415,
                      // size of screen - padding - container size
                      right: (_imageWidth - (_imageWidth * 0.25)) * 0.5,
                      height: _imageHeight * 0.085,
                      width: _imageWidth * 0.25,
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            // print('search Pelvis');
                            _symptomController.text = 'Pelvis';
                            Navigator.of(context).pushNamed(SearchResultPages.routeName,
                              arguments: _symptomController.text);
                          },
                          // child: Container(
                          //   color: Colors.orange.withAlpha(100),
                          // ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: _imageHeight * 0.5,
                      // size of screen - padding - container size
                      right: (_imageWidth - (_imageWidth * 0.32)) * 0.5,
                      height: _imageHeight * 0.46,
                      width: _imageWidth * 0.32,
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            // print('search Leg');
                            _symptomController.text = 'Leg';
                            Navigator.of(context).pushNamed(SearchResultPages.routeName,
                              arguments: _symptomController.text);
                          },
                          // child: Container(
                          //   color: Colors.teal.withAlpha(100),
                          // ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: _imageHeight * 0.165,
                      // size of screen - padding - container size
                      left: _imageWidth * 0.01,
                      // (MediaQuery.of(context).size.width - 20),
                      height: _imageHeight * 0.22,
                      width: _imageWidth * 0.39,
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            // print('search Arm');
                            _symptomController.text = 'Arm';
                            Navigator.of(context).pushNamed(SearchResultPages.routeName,
                              arguments: _symptomController.text);
                          },
                          // child: Container(
                          //   color: Colors.green.withAlpha(100),
                          // ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: _imageHeight * 0.165,
                      // size of screen - padding - container size
                      right: _imageWidth * 0.01,
                          // (MediaQuery.of(context).size.width - 20),
                      height: _imageHeight * 0.22,
                      width: _imageWidth * 0.39,
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            // print('search Arm');
                            _symptomController.text = 'Arm';
                            Navigator.of(context).pushNamed(SearchResultPages.routeName,
                              arguments: _symptomController.text);
                          },
                          // child: Container(
                          //   color: Colors.green.withAlpha(100),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                  decoration:
                      InputDecoration(hintText: 'type your symptom here'),
                  controller: _symptomController,
                  onSubmitted: (_) {
                    // print(_symptomController.text);
                    Navigator.of(context).pushNamed(SearchResultPages.routeName,
                        arguments: _symptomController.text);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
