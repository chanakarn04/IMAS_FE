// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class NumberTextField extends StatefulWidget {
  final TextEditingController textController;

  const NumberTextField({Key key, this.textController}) : super(key: key);

  NumberTextFieldState createState() => NumberTextFieldState();
}

class NumberTextFieldState extends State<NumberTextField> {
  String value = '';
  bool validate = true;

  checkTextInputData() {
    setState(() {
      value = widget.textController.text;
    });

    // print(_isNumeric(value));

    if (_isNumeric(value) == true) {
      setState(() {
        validate = true;
        // print('Value is Number');
        // output = 'Value is Number';
      });
    } else {
      setState(() {
        validate = false;
        // output = 'Value is Not Number';
        // print('Value is not number');
      });
    }
  }

  bool _isNumeric(String result) {
    if (result == null) {
      return true;
    }
    return double.tryParse(result) != null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      onSubmitted: (_) {
        checkTextInputData();
      },
      textAlign: TextAlign.end,
      style: TextStyle(
        fontSize: 20,
      ),
      // autofocus: true,
      decoration: InputDecoration(
        hintText: 'Type here',
        errorText: widget.textController.text.isEmpty
            ? null
            : !validate
                ? 'Must be numeric'
                : null,
        errorStyle: TextStyle(),
        // errorBorder: Input,
        contentPadding: EdgeInsets.only(right: 15),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
