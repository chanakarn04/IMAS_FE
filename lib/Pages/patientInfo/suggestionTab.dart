import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../Widget/carouselDotIndicator.dart';
import '../../Widget/ptInfo_aptSuggestCard.dart';
import '../../Models/model.dart';

class SuggestionTab extends StatefulWidget {
  final String tpId;

  SuggestionTab(this.tpId);

  @override
  _SuggestionTabState createState() => _SuggestionTabState();
}

class _SuggestionTabState extends State<SuggestionTab> {
  // List<Appointment> appointments;
  List<Map<String, dynamic>> data;
  var _loadInitData = false;
  int carouselIndex = 0;

  List<Map<String, dynamic>> _loadData(String tpId) {
    // ... use tp id to get data

    return [
      {
        'apId': 'ap001',
        // 'tpId': 'tp001',
        // 'note': '',
        'apDt': DateTime.utc(2020, 12, 20),
        'status': AptStatus.Pass,
        'advises': 'Rest mak mak na',
        'prescription': [
          'Paracetamol',
        ],
      },
      {
        'apId': 'ap002',
        // 'tpId': 'tp001',
        // 'note': '',
        'apDt': DateTime.utc(2020, 12, 26),
        'status': AptStatus.Pass,
        'advises': 'Kin Kwaw yer yer',
        'prescription': [
          'Paracetamol',
          'Bakamol',
        ],
      },
    ];
  }

  @override
  void didChangeDependencies() {
    if (!_loadInitData) {
      data = _loadData(this.widget.tpId);
      //   appointments = dummy_appointment
      //       .where((apt) =>
      //           (apt.tpId == widget.tpId) && (apt.status == AptStatus.Edited))
      //       .toList()
      //       .reversed
      //       .toList();
      // }
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              // height: (MediaQuery.of(context).size.height
              // MediaQuery.of(context).padding.top -
              // MediaQuery.of(context).padding.bottom -
              // this.widget.appBarSize
              child: CarouselSlider.builder(
                itemCount: data.length,
                itemBuilder: (context, index, _) => AptSuggestCard(
                  data[index]['apDt'],
                  data[index]['prescription'],
                  data[index]['advises'],
                  (data.length - index),
                ),
                options: CarouselOptions(
                  height: 500,
                  enlargeCenterPage: true,
                  initialPage: carouselIndex,
                  enableInfiniteScroll: false,
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
            height: 5,
          ),
          CarouselDotIndicator(
            length: data.length,
            ctrlIndex: carouselIndex,
            selectedColor: Theme.of(context).primaryColor,
            unSelectedColor: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
