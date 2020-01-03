import 'package:flutter/material.dart';
import 'package:phone/screens/client_card.dart';
import 'messages_screen.dart';
import '../components/users.dart';

class ClientDetails extends StatelessWidget {

  ClientDetails({@required this.client, @required this.name, @required this.photo});

  final String name;
  final String photo;
  final Client client;

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
