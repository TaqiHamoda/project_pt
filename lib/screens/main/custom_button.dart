import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String label;

  CustomButton({this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: FlatButton(
          onPressed: () {
            this.onTap();
          },
          child: Text(this.label)),
    );
  }
}

