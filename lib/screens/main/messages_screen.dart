import 'package:flutter/material.dart';
import 'package:phone/screens/main/new_message_screen.dart';
import 'package:phone/components/users.dart';
import 'message_card.dart';

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
    List<Widget> messageWidgets = [];
    for(User person in users){
      String name = person.firstName + ' ' + person.lastName;
      MessageCard mc = MessageCard(name, 'images/profile.png');
      messageWidgets.add(mc);
    }
    return messageWidgets;
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
        children: createMessageList(user.messageList),
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
