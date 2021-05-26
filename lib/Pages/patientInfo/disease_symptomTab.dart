import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../Widget/carouselDotIndicator.dart';
import '../../Widget/ptInfo_aptSymptomDieaseCard.dart';
import '../../Models/model.dart';
import '../../Provider/patientInfo.dart';

class DiseaseSymptomTab extends StatefulWidget {
  // final String tpId = 'tp001';
  // final String tpId;

  // DiseaseSymptomTab(this.tpId);

  @override
  _DiseaseSymptomTabState createState() => _DiseaseSymptomTabState();
}

class _DiseaseSymptomTabState extends State<DiseaseSymptomTab> {
  List<Map<String, dynamic>> data;
  var _loadedInitData = false;
  int carouselIndex = 0;

  List<Map<String, dynamic>> _loadData(
    String tpId,
  ) {
    // use tpId  to get data
    return [
      {
        'apId': 'ap001',
        'tpId': 'tp001',
        'note': '',
        'advises': 'Rest mak mak na',
        'apDt': DateTime.utc(2020, 12, 20),
        'status': AptStatus.Pass,
        'symptom': [
          {'name': 'Headache', 'painScore': 6},
          {'name': 'Paralysis', 'painScore': 9},
        ],
        'disease': [
          'Tension Headache',
        ],
      },
      {
        'apId': 'ap002',
        'tpId': 'tp001',
        'note': '',
        'advises': 'Kin kwaw yer yer',
        'apDt': DateTime.utc(2020, 12, 26),
        'status': AptStatus.Pass,
        'symptom': [
          {'name': 'Headache', 'painScore': 1},
        ],
        'disease': [
          'Tension Headache',
        ],
      },
    ];
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final patientInfo = Provider.of<PatientInfo>(context);
      data = patientInfo.symp_cond;
      _loadedInitData = true;
      // data = _loadData(this.widget.tpId).reversed.toList();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    // print('====> ${data.length}');
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              // color: Colors.purple[300],
              // height: (MediaQuery.of(context).size.height),
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
