import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';
import 'package:phone/screens/main/messages_screen.dart';

class CustomAppBar{
  final String label;
  final Function _function;
  final User user;
  String search;

  CustomAppBar(this.label, this.user, this._function);

  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size(100.0, 50.0),
        child: Container(
          margin: EdgeInsets.only(top: 5.0),
          child: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              contentPadding: EdgeInsets.only(left: 10.0),
              labelText: 'Search by name',
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            onChanged: (value){this.search = value; _function();},
          ),
        ),
      ),
      centerTitle: true,
      title: Text(this.label,
        style: TextStyle(
          fontSize: 30.0,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.near_me,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MessagePage(this.user)));
          },
        ),
      ],
    );
  }
}

