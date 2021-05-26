import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Pages/caseMangeConditionSearch.dart';
import '../Provider/caseManagement_Info.dart';
import './adaptiveBorderButton.dart';
import './showMyDialog.dart';

class CaseManagementListConditionBox extends StatefulWidget {
  final String caseIndex = 'disease';
  final String title;
  final String description;
  // final List<String> items;
  // final Function addFn;
  // final Function editFn;
  // final Function delFn;

  CaseManagementListConditionBox({
    // this.caseIndex,
    this.title,
    this.description,
    // this.items,
    // this.addFn,
    // this.editFn,
    // this.delFn,
  });

  @override
  _CaseManagementListConditionBoxState createState() =>
      _CaseManagementListConditionBoxState();
}

class _CaseManagementListConditionBoxState
    extends State<CaseManagementListConditionBox> {
  final controller = TextEditingController();
  String temp;
  CMinfoProvider cmInfo;

  @override
  Widget build(BuildContext context) {
    final cmInfo = Provider.of<CMinfoProvider>(context);

    caseManagementDiseaseListBottomSheet(
      BuildContext context,
      String title,
      TextEditingController controller,
      String buttonText,
      // Function buttonHandler,
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
            height: 300,
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
              top: 20,
              bottom: 20,
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
                  controller: controller,
                  onSubmitted: (value) {
                    cmInfo.search_conditions_Loaded = false;
                    cmInfo.searchCondition(value);
                  },
                ),
                Expanded(
                  child: (cmInfo.search_conditions_Loaded)
                      ? (cmInfo.search_conditions.length != 0)
                          ? ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemBuilder: (context, index) {
                                return InkWell(
                                    child: Container(
                                        // color: Colors.amber,
                                        // padding: EdgeInsets.all(10),
                                        // child: Text(
                                        //   cmInfo.search_conditions[index]
                                        //       ['common_name'],
                                        //   style: TextStyle(
                                        //     // fontSize: 28,
                                        //     color: Colors.red,
                                        //   ),
                                        // ),
                                        ),
                                    onTap: () {
                                      cmInfo.addCondition(
                                          cmInfo.search_conditions[index]['id'],
                                          cmInfo.search_conditions[index]
                                              ['common_name']);
                                      Navigator.of(context).pop();
                                    });
                              },
                              itemCount: cmInfo.search_conditions.length,
                            )
                          : Center(
                              child: Text(
                                'No condition',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            )
                      : Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.0,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                ),
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
                    // Expanded(child: Container()),
                  ],
                ),
              ],
            ),
          );
        },
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
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.widget.title,
                    style: TextStyle(
                      fontSize: 28,
                      // fontWeight: FontWeight.bold,
                      // color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
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
                  // onPressed: this.widget.addFn,
                  onPressed: () {
                    cmInfo.search_conditions_Loaded = true;
                    cmInfo.search_conditions = [];
                    // print('Edit as ${cmInfo.condition[index]}');
                    Navigator.of(context).pushNamed(
                      CaseManagementConditionSearch.routeName,
                    );
                  }
                  // onPressed: () => print('add'),
                  ),
            ),
            SizedBox(
              width: 25,
            )
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 30),
            // color: Colors.pink[50],
            // width: double.infinity,
            // decoration: BoxDecoration(
            //     border: Border.all(
            //       width: 2,
            //       color: Theme.of(context).primaryColor,
            //     ),
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(15),
            //       topLeft: Radius.circular(15),
            //     )),
            child: (cmInfo.conditions.length != 0)
                ? ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      final _conditionsList = cmInfo.conditions.values.toList();
                      final _conditionsKeyList =
                          cmInfo.conditions.keys.toList();
                      return Column(
                        children: [
                          Container(
                            height: 40,
                            // alignment: Alignment.center,
                            // color: Colors.pink[300],
                            child: ListTile(
                              title: Text(_conditionsList[index]),
                              trailing: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: InkWell(
                                      child: Icon(
                                        Icons.delete_outline_outlined,
                                        size: 24,
                                        color: Colors.grey[700],
                                      ),
                                      // onTap: this.widget.delFn,
                                      onTap: () {
                                        cmInfo.delCondition(
                                            _conditionsKeyList[index]);
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
                            color: Colors.grey[700],
                          )
                        ],
                      );
                    },
                    itemCount: cmInfo.conditions.length,
                  )
                : Center(
                    child: Text(
                      'There is no detected disease record. You can add it by tapping at the above plus icon',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
