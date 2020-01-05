import 'package:flutter/material.dart';


class SpecialDialog {
  final List<Widget> children;
  final Function submitFunction;
  final String title;


  SpecialDialog( BuildContext context, this.title, this.submitFunction, this.children) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: Text(this.title),
          children: this.children + [

            Row(children: <Widget>[
              Container(
                alignment: Alignment(-1.0, 0.0),
                child: FlatButton(
                  child: new Text('Ok',
                    style: TextStyle(color: Colors.blue),),
                  onPressed: () {
                    Navigator.of(context).pop();
                    this.submitFunction();},
                ),
              ),

              Container(
                alignment: Alignment(1.0, 0.0),
                child: FlatButton(
                  child: new Text('Cancel',
                    style: TextStyle(color: Colors.blue),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ]
            )
          ],
        );
      },
    );
  }
}
