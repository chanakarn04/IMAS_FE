import 'package:flutter/material.dart';
import './customSliderThumbCircle.dart';

class PainScoreSlider extends StatefulWidget {
  // double value;
  final int min;
  final int max;
  final double height;

  PainScoreSlider({
    // this.value,
    this.min = 0,
    this.max = 10,
    this.height = 50,
  });

  @override
  _PainScoreSliderState createState() => _PainScoreSliderState();
}

class _PainScoreSliderState extends State<PainScoreSlider> {
  // int min = this.widget.min;
  // int max = 10;
  double sldValue = 0;
  // double height = 50;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.widget.height,
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.lightBlue[200],
            Colors.teal[300],
            Colors.green[400],
            Colors.yellow,
            Colors.amber,
            Colors.orange,
            Colors.red[700],
          ],
          stops: [0.05, 0.2, 0.3, 0.55, 0.7, 0.80, 0.95],
        ),
      ),
      child: Row(
        children: [
          Text(
            this.widget.min.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: this.widget.height * .4,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                //undone
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white,
                tickMarkShape: RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.white,
                inactiveTickMarkColor: Colors.white.withAlpha(100),
                thumbColor: Theme.of(context).primaryColor,
                // overlayColor: Theme.of(context).primaryColor.withAlpha(125),
                // valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                // valueIndicatorColor: Theme.of(context).primaryColor,
                // valueIndicatorTextStyle: TextStyle(
                //   color: Colors.white,
                // ),
                //done
                trackShape: RoundedRectSliderTrackShape(),
                trackHeight: this.widget.height / 6,

                thumbShape: CustomSliderThumbCircle(
                    thumbRadius: this.widget.height / 2.5,
                    max: this.widget.max,
                    min: this.widget.min),
                // overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
              ),
              child: Slider(
                min: this.widget.min.toDouble(),
                max: this.widget.max.toDouble(),
                divisions: 10,
                value: sldValue,
                label: sldValue.round().toString(),
                onChanged: (value) {
                  setState(() {
                    sldValue = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(
            this.widget.max.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: this.widget.height * .4,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
