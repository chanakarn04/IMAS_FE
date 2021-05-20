import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/adaptiveBorderButton.dart';
import '../Widget/AdaptiveRaisedButton.dart';
import '../Provider/caseManagement_Info.dart';

class CaseManagementConditionSearch extends StatefulWidget {
  static const routeName = 'caseManagement_conditionSearch';
  // final String title;
  // final String buttonText;
  // CaseManagementConditionSearch(
  //   this.title,
  //   this.buttonText,
  // );
  @override
  _CaseManagementConditionSearchState createState() =>
      _CaseManagementConditionSearchState();
}

class _CaseManagementConditionSearchState
    extends State<CaseManagementConditionSearch> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final title = ModalRoute.of(context).settings.arguments as String;
    final cmInfo = Provider.of<CMinfoProvider>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).padding.top + 15,
          horizontal: 25,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add disease',
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
                          padding: EdgeInsets.all(5),
                          itemBuilder: (context, index) {
                            return InkWell(
                                child: Card(
                                  child: Text(
                                    cmInfo.search_conditions[index]
                                        ['common_name'],
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
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
      ),
    );
  }
}
