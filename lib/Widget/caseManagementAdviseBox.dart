import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './caseManagementAdviseEdit.dart';
import '../Provider/caseManagement_Info.dart';

class CaseManagementAdviseBox extends StatefulWidget {
  final String caseIndex;
  final String title;
  final String item;
  // final CMinfoProvider cmInfo;
  // final Function editFn;

  CaseManagementAdviseBox({
    this.caseIndex,
    this.title,
    this.item,
    // this.cmInfo,
    // this.editFn,
  });

  @override
  _CaseManagementAdviseBoxState createState() =>
      _CaseManagementAdviseBoxState();
}

class _CaseManagementAdviseBoxState extends State<CaseManagementAdviseBox> {
  final controller = TextEditingController();
  // String temp;

  @override
  Widget build(BuildContext context) {
    final cmInfo = Provider.of<CMinfoProvider>(context);

    void _edit(String caseIndex) {
      // setState(() {
      //   temp = controller.text;
      // });
      // controller.clear();
      cmInfo.edit(caseIndex, 0, controller.text);
      // print('Edit as ${cmInfo.condition[index]}');
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Data edited'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(child: Container()),
            SizedBox(
              height: 45,
              width: 45,
              child: IconButton(
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  onPressed: () {
                    // print('test');
                    controller.text = cmInfo.suggestions;
                    caseManagementAdviseEdit(
                      context,
                      this.widget.title,
                      controller,
                      'Edit',
                      () {
                        // controller.text = this.widget.item;
                        _edit(widget.caseIndex);
                      },
                    );
                  }),
            ),
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topLeft: Radius.circular(15),
                )),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                '    \u2022 ${cmInfo.suggestions}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
