import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './caseManagementAdviseEdit.dart';
import '../Provider/caseManagement_Info.dart';

class CaseManagementAdviseBox extends StatefulWidget {
  final String caseIndex;
  final String title;
  final String description;
  final String item;

  CaseManagementAdviseBox({
    this.caseIndex,
    this.title,
    this.description,
    this.item,
  });

  @override
  _CaseManagementAdviseBoxState createState() => _CaseManagementAdviseBoxState();
}

class _CaseManagementAdviseBoxState extends State<CaseManagementAdviseBox> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cmInfo = Provider.of<CMinfoProvider>(context);

    void _edit(String caseIndex) {
      cmInfo.edit(caseIndex, 0, controller.text);
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
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.widget.title,
                    style: TextStyle(fontSize: 28),
                  ),
                  SizedBox(height: 5),
                  Text(
                    this.widget.description,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
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
                  controller.text = cmInfo.suggestions;
                  caseManagementAdviseEdit(
                    context,
                    this.widget.title,
                    controller,
                    'Edit',
                    () => _edit(widget.caseIndex),
                  );
                },
              ),
            ),
            SizedBox(width: 25)
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 30),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey[700],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: (cmInfo.suggestions != '') ? Text(
                '${cmInfo.suggestions}',
                style: TextStyle(fontSize: 14),
              ) : Text(
                'Feel free to type any text here. For example, this is text for testing the treatment guide text field.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey
                ),
              )
            ),
          ),
        ),
      ],
    );
  }
}
