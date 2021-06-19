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

  CaseManagementListConditionBox({
    this.title,
    this.description,
  });

  @override
  _CaseManagementListConditionBoxState createState() => _CaseManagementListConditionBoxState();
}

class _CaseManagementListConditionBoxState extends State<CaseManagementListConditionBox> {
  final controller = TextEditingController();
  String temp;
  CMinfoProvider cmInfo;

  @override
  Widget build(BuildContext context) {
    final cmInfo = Provider.of<CMinfoProvider>(context);
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
                onPressed: () {
                  cmInfo.search_conditions_Loaded = true;
                  cmInfo.search_conditions = [];
                  Navigator.of(context).pushNamed(CaseManagementConditionSearch.routeName);
                }
              ),
            ),
            SizedBox(width: 25)
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 30),
            child: (cmInfo.conditions.length != 0)
                ? ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      final _conditionsList = cmInfo.conditions.values.toList();
                      final _conditionsKeyList = cmInfo.conditions.keys.toList();
                      return Column(
                        children: [
                          Container(
                            height: 40,
                            child: ListTile(
                              title: Text(_conditionsList[index]),
                              trailing: Row(
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
                                      onTap: () => cmInfo.delCondition(_conditionsKeyList[index]),
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
