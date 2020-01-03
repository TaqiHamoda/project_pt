import 'package:flutter/material.dart';
import 'package:phone/screens/new_message_screen.dart';
import 'package:phone/components/users.dart';

class MessagePage extends StatefulWidget {
  final User user;

  MessagePage(this.user);

  @override
  _MessagePageState createState() => _MessagePageState(this.user);
}

class _MessagePageState extends State<MessagePage> {
  User user;

  _MessagePageState(this.user);

  List<Widget> createMessageList(List users){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[

        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewMessagePage()));
        },
      ),
    );
  }
}
