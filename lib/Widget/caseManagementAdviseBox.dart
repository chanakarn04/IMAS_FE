import 'package:flutter/material.dart';

class CaseManagementAdviseBox extends StatelessWidget {
  final String title;
  final String item;
  final Function editFn;

  CaseManagementAdviseBox({
    this.title,
    this.item,
    this.editFn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
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
                onPressed: editFn,
              ),
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
                '    \u2022 $item',
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
