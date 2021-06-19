import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

// import '../../dummy_data.dart';
import '../../Widget/carouselDotIndicator.dart';
import '../../Widget/ptInfo_vsCard.dart';
import '../../Provider/patientInfo.dart';

class VitalSignTab extends StatefulWidget {
  @override
  _VitalSignTabState createState() => _VitalSignTabState();
}

class _VitalSignTabState extends State<VitalSignTab> {
  List<Map<String, dynamic>> data;
  var _loadInitData = false;
  int carouselIndex = 0;

  @override
  void didChangeDependencies() {
    if (!_loadInitData) {
      final patientInfo = Provider.of<PatientInfo>(context);
      data = patientInfo.vital_pain;
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
            child: Container(
              child: CarouselSlider.builder(
                itemCount: data.length,
                itemBuilder: (context, index, _) => VsCardWidget(data[index]),
                options: CarouselOptions(
                  height: 350,
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
