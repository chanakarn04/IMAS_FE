import 'package:flutter/material.dart';

class DiseaseDetailCard extends StatelessWidget {
  final String description;
  final String cause;
  final List<String> treatment;
  // final Color headColor = Theme.of(context).primaryColor;
  final Color textColor = Color.fromARGB(255, 75, 75, 75);

  DiseaseDetailCard({
    @required this.description,
    @required this.cause,
    @required this.treatment,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        margin: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          // color: Colors.purple[100],
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  '\t\t\t\t${description}',
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Casue',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  '\t\t\t\t${cause}',
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Treatment',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                // color: Colors.teal[100],
                height: (treatment.length * 22).toDouble(),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return Text(
                      '\u2022 ${treatment[index]}',
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                      ),
                    );
                  },
                  itemCount: treatment.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
