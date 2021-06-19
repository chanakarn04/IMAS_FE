import 'package:flutter/material.dart';

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

    if (_isNumeric(value) == true) {
      setState(() {
        validate = true;
      });
    } else {
      setState(() {
        validate = false;
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
      onSubmitted: (_) => checkTextInputData(),
      textAlign: TextAlign.end,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        hintText: 'Type here',
        errorText: widget.textController.text.isEmpty
            ? null
            : !validate
                ? 'Must be numeric'
                : null,
        errorStyle: TextStyle(),
        contentPadding: EdgeInsets.only(right: 15),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
