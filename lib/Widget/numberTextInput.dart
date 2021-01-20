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
      onSubmitted: checkTextInputData(),
      textAlign: TextAlign.end,
      style: TextStyle(
        fontSize: 20,
      ),
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

//   Scaffold(
//       body: Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Container(
//             width: 280,
//             padding: EdgeInsets.all(10.0),
//             child: TextField(
//               controller: textFieldHolder,
//               autocorrect: true,
//               decoration: InputDecoration(hintText: 'Enter Some Text Here'),
//             )),
//         RaisedButton(
//           onPressed: checkTextInputData,
//           color: Color(0xff33691E),
//           textColor: Colors.white,
//           padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//           child: Text('Click Here To Check Value Is Number Or Not'),
//         ),
//         Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text("$output", style: TextStyle(fontSize: 20)))
//       ],
//     ),
//   ));
// }
