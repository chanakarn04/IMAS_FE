import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Widget/SuggestionCardContent.dart';
import '../Widget/carouselDotIndicator.dart';

class SuggestionPage extends StatefulWidget {
  static const routeName = '/suggestion';

  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  int carouselIndex = 0;

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

  List items = [
    {
      'content': 'ONE',
      'color': Colors.red,
    },
    {
      'content': 'TWO',
      'color': Colors.amber,
    },
    {
      'content': 'THREE',
      'color': Colors.green,
    },
    {
      'content': 'FOUR',
      'color': Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    data.sort((a, b) {
      DateTime aDt = a['apDt'];
      DateTime bDt = b['apDt'];
      return bDt.compareTo(aDt);
    });
    AppBar appbar = AppBar(
      title: Text('Title'),
      backgroundColor: Colors.white,
    );
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 20,
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
                        height: MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            60,
                        enableInfiniteScroll: false,
                        initialPage: carouselIndex,
                        onPageChanged: (index, _) {
                          setState(() {
                            carouselIndex = index;
                          });
                        }),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CarouselDotIndicator(
                length: data.length,
                ctrlIndex: carouselIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
