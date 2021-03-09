import 'package:flutter/material.dart';

import './adaptiveBorderButton.dart';
import './AdaptiveRaisedButton.dart';

caseManagementAdviseEdit(
  BuildContext context,
  String title,
  TextEditingController controller,
  String buttonText,
  Function buttonHandler,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Container(
        height: 350 + MediaQuery.of(context).viewInsets.bottom,
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: 20,
          bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            TextField(
              minLines: 1,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              controller: controller,
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Expanded(child: Container()),
                AdaptiveBorderButton(
                  buttonText: 'Cancel',
                  handlerFn: () {
                    controller.clear();
                    Navigator.of(context).pop();
                  },
                  height: 40,
                  width: 150,
                ),
                SizedBox(
                  width: 20,
                ),
                AdaptiveRaisedButton(
                  buttonText: buttonText,
                  handlerFn: buttonHandler,
                  height: 30,
                  width: 140,
                ),
                // Expanded(child: Container()),
              ],
            ),
          ],
        ),
      );
    },
  );
}
