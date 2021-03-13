import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../dummy_data.dart';
import '../Widget/SuggestionCardContent.dart';
import '../Widget/carouselDotIndicator.dart';

class SuggestionPage extends StatefulWidget {
  static const routeName = '/suggestion';

  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  int carouselIndex = 0;

  List<Map<String, dynamic>> _loadedData() {
    // every apt with edited
    List<Map<String, Object>> data = [
      {
        'apDt': DateTime(2020, 12, 24),
        'symptoms': ['Headache', 'Rash', 'Paralysis'],
        'diseases': ['Tension Headache'],
        'drugs': ['Paracetamol', 'Bakamol'],
        'advise': 'Norn Dai leaw Deaw kheun Nee khaow Kor Klab Mah',
      },
      {
        'apDt': DateTime(2020, 12, 10),
        'symptoms': ['Headache', 'Stun', 'Paralysis'],
        'diseases': ['Tension Headache', 'Depression'],
        'drugs': ['Tango', 'Healing Salve'],
        'advise': 'Recommend to use Guardian Greaves',
      },
      {
        'apDt': DateTime(2020, 11, 30),
        'symptoms': ['Headache'],
        'diseases': ['Depression'],
        'drugs': ['Faerie Fire'],
        'advise': 'Use Magic wand',
      },
    ];

    return data;
  }

  // get status of this treatmentPlan
  TreatmentStatus status;

  // every apt with edited
  // List<Map<String, Object>> data = [
  //   {
  //     'apDt': DateTime(2020, 12, 24),
  //     'symptoms': ['Headache', 'Rash', 'Paralysis'],
  //     'diseases': ['Tension Headache'],
  //     'drugs': ['Paracetamol', 'Bakamol'],
  //     'advise': 'Norn Dai leaw Deaw kheun Nee khaow Kor Klab Mah',
  //   },
  //   {
  //     'apDt': DateTime(2020, 12, 10),
  //     'symptoms': ['Headache', 'Stun', 'Paralysis'],
  //     'diseases': ['Tension Headache', 'Depression'],
  //     'drugs': ['Tango', 'Healing Salve'],
  //     'advise': 'Recommend to use Guardian Greaves',
  //   },
  //   {
  //     'apDt': DateTime(2020, 11, 30),
  //     'symptoms': ['Headache'],
  //     'diseases': ['Depression'],
  //     'drugs': ['Faerie Fire'],
  //     'advise': 'Use Magic wand',
  //   },
  // ];

  Map _statusInfo(
    BuildContext context,
    TreatmentStatus status,
  ) {
    switch (status) {
      case TreatmentStatus.Api:
        return {
          'text': 'Mild',
          'color': Theme.of(context).primaryColor,
        };
        break;
      case TreatmentStatus.Cured:
        return {
          'text': 'Cured',
          'color': Theme.of(context).primaryColor,
        };
        break;
      case TreatmentStatus.InProgress:
        return {
          'text': 'In progress',
          'color': Theme.of(context).accentColor,
        };
        break;
      case TreatmentStatus.Hospital:
        return {
          'text': 'Hospital',
          'color': Color.fromARGB(255, 205, 16, 16),
        };
        break;
      default:
        {
          return {
            'texr': '',
            'color': Colors.transparent,
          };
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> data = _loadedData();
    data.sort((a, b) {
      DateTime aDt = a['apDt'];
      DateTime bDt = b['apDt'];
      return bDt.compareTo(aDt);
    });
    final TreatmentStatus status = ModalRoute.of(context).settings.arguments;
    AppBar appbar = AppBar(
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop()),
      title: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text('Suggestion'),
            SizedBox(height: 3),
            Text(
              '${_statusInfo(context, status)['text']}',
              style: TextStyle(
                color: _statusInfo(context, status)['color'],
                fontSize: 14,
              ),
            ),
          ],
        ),
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
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            top: 15,
            bottom: 15,
            // horizontal: 0,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  // color: Colors.pink[200],
                  child: CarouselSlider.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index, _) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(10),
                        height: double.infinity,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Center(
                          child:
                              SuggestionCardContent(data: data, index: index),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      height: MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          60,
                      enableInfiniteScroll: false,
                      initialPage: carouselIndex,
                      onPageChanged: (index, _) {
                        setState(() {
                          carouselIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CarouselDotIndicator(
                length: data.length,
                ctrlIndex: carouselIndex,
                selectedColor: Theme.of(context).primaryColorLight,
                unSelectedColor: Colors.white54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
