import 'package:flutter/material.dart';

class CaseManagementListItemBox extends StatefulWidget {
  final String title;
  final List<String> items;
  final Function addFn;
  final Function editFn;
  final Function delFn;

  CaseManagementListItemBox({
    this.title,
    this.items,
    this.addFn,
    this.editFn,
    this.delFn,
  });

  @override
  _CaseManagementListItemBoxState createState() =>
      _CaseManagementListItemBoxState();
}

class _CaseManagementListItemBoxState extends State<CaseManagementListItemBox> {
  @override
  Widget build(BuildContext context) {
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
                onPressed: this.widget.addFn,
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
                                onTap: this.widget.editFn,
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
                                onTap: this.widget.delFn,
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
