import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../Widget/carouselDotIndicator.dart';
import '../../Widget/ptInfo_aptSymptomDieaseCard.dart';
import '../../Models/model.dart';
import '../../Provider/patientInfo.dart';

class DiseaseSymptomTab extends StatefulWidget {
  @override
  _DiseaseSymptomTabState createState() => _DiseaseSymptomTabState();
}

class _DiseaseSymptomTabState extends State<DiseaseSymptomTab> {
  List<Map<String, dynamic>> data;
  var _loadedInitData = false;
  int carouselIndex = 0;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final patientInfo = Provider.of<PatientInfo>(context);
      data = patientInfo.symp_cond;
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: CarouselSlider.builder(
                itemCount: data.length,
                itemBuilder: (context, index, _) {
                  return AptSymptomDiseaseCard(
                    data[index],
                    (data.length - index),
                  );
                },
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
