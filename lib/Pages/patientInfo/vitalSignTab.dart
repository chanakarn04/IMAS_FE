import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

// import '../../dummy_data.dart';
import '../../Widget/carouselDotIndicator.dart';
import '../../Widget/ptInfo_vsCard.dart';
import '../../Provider/patientInfo.dart';

class VitalSignTab extends StatefulWidget {
  // final String tpId;

  // VitalSignTab(this.tpId);

  @override
  _VitalSignTabState createState() => _VitalSignTabState();
}

class _VitalSignTabState extends State<VitalSignTab> {
  // List<Appointment> appointments;
  // List<VitalSign> vitalSigns;
  List<Map<String, dynamic>> data;
  var _loadInitData = false;
  int carouselIndex = 0;

  List<Map<String, dynamic>> _loadData(
    String tpId,
  ) {
    // ... use tpId toget data

    return [
      {
        'vsId': 'vs001',
        'apId': 'ap001',
        'vsDt': DateTime.utc(2020, 12, 20),
        'bodyTemp': 36.5,
        'pulse': 87.0,
        'respiratRate': 15,
        'bloodPress': '80/120',
      },
      {
        'vsId': 'vs002',
        'apId': 'ap001',
        'vsDt': DateTime.utc(2020, 12, 26),
        'bodyTemp': 37.5,
        'pulse': 90.0,
        'respiratRate': null,
        'bloodPress': null,
      },
      {
        'vsId': 'vs003',
        'apId': 'ap003',
        'vsDt': DateTime.utc(2020, 12, 27),
        'bodyTemp': 36.5,
        'pulse': 87.0,
        'respiratRate': null,
        'bloodPress': null,
      }
    ];
  }

  @override
  void didChangeDependencies() {
    if (!_loadInitData) {
      final patientInfo = Provider.of<PatientInfo>(context);
      data = patientInfo.vital_pain;
      _loadInitData = true;
      // data = _loadData(this.widget.tpId);
      // vitalSigns = [];
      // appointments = dummy_appointment
      //     .where((apt) =>
      //         (apt.tpId == widget.tpId) && (apt.status == AptStatus.Edited))
      //     .toList()
      //     .reversed
      //     .toList();
      // for (Appointment apt in appointments) {
      //   vitalSigns.addAll(dummy_vitalSign.where((vs) => vs.apId == apt.apId));
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
