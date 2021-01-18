import 'package:flutter/material.dart';
import '../Widget/adaptiveRaisedButton.dart';

class VitalSignMeasurePage extends StatefulWidget {
  @override
  _VitalSignMeasurePageState createState() => _VitalSignMeasurePageState();
}

class _VitalSignMeasurePageState extends State<VitalSignMeasurePage> {
  final textController = TextEditingController();

  _headerBuilder(
    String header,
  ) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
      child: Text(header,
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.clip),
    );
  }

  _descriptionBuilder(
    String description,
  ) {
    return Align(
      alignment: Alignment.centerRight,
      // color: Colors.deepPurple,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.95),
        child: Text(
          description,
          style: TextStyle(
            color: Color.fromARGB(255, 75, 75, 75),
            fontSize: 18,
          ),
          textAlign: TextAlign.end,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }

  AppBar _appBarBuilder() {
    return AppBar(
      centerTitle: true,
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
          onPressed: null,
        )
      ],
    );
  }

  _progressBarBuilder(
    int current,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (current == 1)
                ? Theme.of(context).primaryColor
                : Color.fromARGB(100, 75, 75, 75),
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (current == 2)
                ? Theme.of(context).primaryColor
                : Color.fromARGB(100, 75, 75, 75),
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (current == 3)
                ? Theme.of(context).primaryColor
                : Color.fromARGB(100, 75, 75, 75),
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (current == 4)
                ? Theme.of(context).primaryColor
                : Color.fromARGB(100, 75, 75, 75),
          ),
        ),
      ],
    );
  }

  Widget _tempBodyBuild() {
    return SingleChildScrollView(
      child: Container(
        // color: Colors.teal,
        height: (MediaQuery.of(context).size.height -
            _appBarBuilder().preferredSize.height -
            MediaQuery.of(context).padding.top),
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _headerBuilder('Body Temperature'),
            SizedBox(
              height: 20,
            ),
            _descriptionBuilder(
                'Use thermometer to measure yourself and select your temperature'),
            SizedBox(
              height: 120,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: TextField(
                    controller: textController,
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type here',
                      contentPadding: EdgeInsets.only(right: 15),
                    ),
                  ),
                ),
                Text(
                  '°C',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            _progressBarBuilder(1),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.center,
              child: AdaptiveRaisedButton(
                buttonText: 'Next',
                height: 35,
                width: MediaQuery.of(context).size.width * 0.35,
                handlerFn: (() {
                  setState(() {
                    body = _heartBodyBuilder();
                  });
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  _heartBodyBuilder() {
    return Center(
      child: Text('Heart Rate'),
    );
  }

  Widget body = _tempBodyBuild();

  @override
  Widget build(BuildContext context) {
    // final appBar =

    // final bloodBody = Container();
    // final respiratoryBody = Container();

    return Scaffold(
      appBar: _appBarBuilder(),
      body: body,
    );
  }
}
