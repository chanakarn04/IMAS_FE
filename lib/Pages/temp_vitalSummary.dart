import 'package:flutter/material.dart';

class VSSummary extends StatelessWidget {
  final Map<String, Object> vital_data;

  VSSummary(this.vital_data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('testosterone'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('temp: ${vital_data['temp']}'),
            Text('pulse: ${vital_data['pulse']}'),
            Text('breath: ${vital_data['breath']}'),
            Text('pressure: ${vital_data['pressure']}'),
          ],
        ),
      ),
    );
  }
}
