import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/caseManagement_Info.dart';
import './caseManagementEditBottomSheet.dart';
import './showMyDialog.dart';

class CaseManagementListItemBox extends StatefulWidget {
  final String caseIndex;
  final String title;
  final String description;
  final List<String> items;

  CaseManagementListItemBox({
    this.caseIndex,
    this.title,
    this.description,
    this.items,
  });

  @override
  _CaseManagementListItemBoxState createState() => _CaseManagementListItemBoxState();
}

class _CaseManagementListItemBoxState extends State<CaseManagementListItemBox> {
  final controller = TextEditingController();
  String temp;

  @override
  Widget build(BuildContext context) {
    final cmInfo = Provider.of<CMinfoProvider>(context);

    void _add(String caseIndex) {
      setState(() {
        temp = controller.text;
      });
      controller.clear();
      cmInfo.add(caseIndex, temp);
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('$caseIndex added'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }

    void _edit(String caseIndex, int index) {
      setState(() {
        temp = controller.text;
      });
      controller.clear();
      cmInfo.edit(caseIndex, index, temp);
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Data edited'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }

    void _del(
      String caseIndex,
      int index,
    ) {
      showMyDialog(
        context,
        'Delete?',
        'Confirm to delete this item?',
        'cancel',
        'confirm',
        () {
          cmInfo.del(caseIndex, index);
          Navigator.of(context).pop();
        },
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
                    Icons.add_circle_outline_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  onPressed: () => caseManagementEditBottomSheet(
                      context,
                      'Add ${this.widget.caseIndex}',
                      controller,
                      'Add',
                      () => _add(this.widget.caseIndex),
                    ),
                  ),
            ),
            SizedBox(width: 25),
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 30),
            child: (this.widget.items.length > 0) ? ListView.builder(
              padding: EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 40,
                      child: ListTile(
                        title: Text(this.widget.items[index]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: InkWell(
                                child: Icon(
                                  Icons.edit_outlined,
                                  size: 24,
                                  color: Colors.grey[700],
                                ),
                                onTap: () {
                                  switch (this.widget.caseIndex) {
                                    case 'symptom':
                                      controller.text =
                                          '${cmInfo.symptoms[index]}';
                                      break;
                                    case 'disease':
                                      controller.text =
                                          '${cmInfo.conditions[index]}';
                                      break;
                                    case 'prescription':
                                      controller.text =
                                          '${cmInfo.prescriptions[index]}';
                                      break;
                                    default:
                                      break;
                                  }
                                  caseManagementEditBottomSheet(
                                    context,
                                    'Edit ${this.widget.caseIndex}',
                                    controller,
                                    'Edit',
                                    () {
                                      _edit(this.widget.caseIndex, index);
                                    },
                                  );
                                }
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: InkWell(
                                child: Icon(
                                  Icons.delete_outline_outlined,
                                  size: 24,
                                  color: Colors.grey[700],
                                ),
                                onTap: () => _del(this.widget.caseIndex, index),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 1,
                      color: Colors.grey[700],
                    )
                  ],
                );
              },
              itemCount: this.widget.items.length,
            ) : Center(
              child: Text('There is no ${this.widget.caseIndex} record. You can add it by tapping at the above plus icon', style: TextStyle(color: Colors.grey),),
            )
          ),
        ),
      ],
    );
  }
}
