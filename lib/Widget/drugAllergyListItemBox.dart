import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Provider/caseManagement_Info.dart';
import './caseManagementEditBottomSheet.dart';
import './showMyDialog.dart';

class DrugAllergyListItemBox extends StatefulWidget {
  final List<String> drug;
  final Function add;
  final Function edit;
  final Function remove;

  DrugAllergyListItemBox({
    this.drug,
    this.add,
    this.edit,
    this.remove,
  });

  @override
  _DrugAllergyListItemBoxState createState() => _DrugAllergyListItemBoxState();
}

class _DrugAllergyListItemBoxState extends State<DrugAllergyListItemBox> {
  final controller = TextEditingController();
  String temp;

  @override
  Widget build(BuildContext context) {
    void _add() {
      setState(() {
        temp = controller.text;
      });
      controller.clear();
      // add data
      this.widget.add(temp);
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('added'),
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

    void _edit(int index) {
      setState(() {
        temp = controller.text;
      });
      controller.clear();
      this.widget.edit(temp, index);
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

    void _del(
      int index,
    ) {
      showMyDialog(
        context,
        'Delete?',
        'Confirm to delete this item?',
        'cancel',
        'confirm',
        () {
          setState(() {
            this.widget.remove(index);
          });
          Navigator.of(context).pop();
        },
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Drug Allergy',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please tell us your allergy medication information.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 165, 165, 165),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                caseManagementEditBottomSheet(
                  context,
                  'Add drug',
                  controller,
                  'Add',
                  () {
                    _add();
                  },
                );
              },
              child: Icon(
                Icons.add_circle_outline_rounded,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: (this.widget.drug.length == 0)
                ? Container(
                    padding: EdgeInsets.only(top: 20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'There is no drug allergy record\nYou can add it by tapping at the above plus icon',
                      style: TextStyle(color: Color.fromARGB(255, 75, 75, 75)),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 40,
                            child: ListTile(
                              title: Text(this.widget.drug[index]),
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
                                      ),
                                      onTap: () {
                                        controller.text =
                                            this.widget.drug[index];
                                        caseManagementEditBottomSheet(
                                          context,
                                          'Edit',
                                          controller,
                                          'Edit',
                                          () {
                                            _edit(index);
                                          },
                                        );
                                      },
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
                                      onTap: () {
                                        setState(() {
                                          _del(index);
                                        });
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
                            height: 0.5,
                            margin: EdgeInsets.symmetric(horizontal: 14),
                            color: Colors.grey,
                          )
                        ],
                      );
                    },
                    itemCount: this.widget.drug.length,
                  ),
          ),
        ),
      ],
    );
  }
}
