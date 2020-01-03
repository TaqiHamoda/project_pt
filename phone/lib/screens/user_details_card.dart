import 'package:flutter/material.dart';
import 'package:phone/screens/user_card.dart';
import 'messages_screen.dart';

class UserDetails extends StatelessWidget {

  UserDetails(this.name, this.photo);

  final String name;
  final String photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$name\'s profile'
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessagePage()));
            },
            icon: Icon(
              Icons.near_me,
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Hero(
                tag: 'dash',
                child: Image.asset(
                  this.photo,
                  height: 150.0,
                  width: 150.0,
                ),
              ),
            ),
            Center(
              child: Text(
                this.name,
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
