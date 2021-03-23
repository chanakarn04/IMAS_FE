import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/caseManagement_Info.dart';
import './caseManagementEditBottomSheet.dart';
import './showMyDialog.dart';

class CaseManagementListItemBox extends StatefulWidget {
  final String caseIndex;
  final String title;
  final List<String> items;
  // final Function addFn;
  // final Function editFn;
  // final Function delFn;

  CaseManagementListItemBox({
    this.caseIndex,
    this.title,
    this.items,
    // this.addFn,
    // this.editFn,
    // this.delFn,
  });

  @override
  _CaseManagementListItemBoxState createState() =>
      _CaseManagementListItemBoxState();
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
      // add data
      cmInfo.add(caseIndex, temp);
      // print('Add as $temp');
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('$caseIndex added'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
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
      // print('Edit as ${cmInfo.condition[index]}');
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Data edited'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
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
          print('Delete item');
          Navigator.of(context).pop();
        },
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Text(
              this.widget.title,
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
                    Icons.add_circle_outline_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  // onPressed: this.widget.addFn,
                  onPressed: () {
                    // print('Edit as ${cmInfo.condition[index]}');
                    caseManagementEditBottomSheet(
                      context,
                      'Add ${this.widget.caseIndex}',
                      controller,
                      'Add',
                      () {
                        _add(this.widget.caseIndex);
                      },
                    );
                  }
                  // onPressed: () => print('add'),
                  ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20),
            // width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topLeft: Radius.circular(15),
                )),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 40,
                      // alignment: Alignment.center,
                      // color: Colors.pink[300],
                      child: ListTile(
                        title: Text(this.widget.items[index]),
                        trailing: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: InkWell(
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 24,
                                  ),
                                  onTap: () {
                                    // print('Edit as ${cmInfo.condition[index]}');
                                    print('index: $index');
                                    switch (this.widget.caseIndex) {
                                      case 'symptom':
                                        controller.text =
                                            '${cmInfo.symptoms[index]}';
                                        break;
                                      case 'disease':
                                        controller.text =
                                            '${cmInfo.condition[index]}';
                                        break;
                                      case 'prescription':
                                        controller.text =
                                            '${cmInfo.prescriptions[index]}';
                                        break;
                                      default:
                                        break;
                                    }
                                    // controller.text =
                                    //     '${cmInfo.condition[index]}';
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
                                  // _edit(this.widget.caseIndex, index),
                                  // print('edit'),
                                  ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: InkWell(
                                child: Icon(
                                  Icons.delete_outline_outlined,
                                  size: 24,
                                ),
                                // onTap: this.widget.delFn,
                                onTap: () {
                                  _del(this.widget.caseIndex, index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    )
                  ],
                );
              },
              itemCount: this.widget.items.length,
            ),
          ),
        ),
      ],
    );
  }
}
