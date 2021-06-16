import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../Widget/carouselDotIndicator.dart';
import '../../Widget/ptInfo_aptSuggestCard.dart';
import '../../Models/model.dart';
import '../../Provider/patientInfo.dart';

class SuggestionTab extends StatefulWidget {
  @override
  _SuggestionTabState createState() => _SuggestionTabState();
}

class _SuggestionTabState extends State<SuggestionTab> {
  List<Map<String, dynamic>> data;
  var _loadInitData = false;
  int carouselIndex = 0;

  @override
  void didChangeDependencies() {
    if (!_loadInitData) {
      final patientInfo = Provider.of<PatientInfo>(context);
      data = patientInfo.prescrip_suggest;
      _loadInitData = true;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider.builder(
              itemCount: data.length,
              itemBuilder: (context, index, _) => AptSuggestCard(
                data[index]['apDt'],
                (data[index]['prescription'] != null) ? List<String>.from(data[index]['prescription']) : null,
                (data[index]['advises'] != null) ? data[index]['advises'] : null,
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
