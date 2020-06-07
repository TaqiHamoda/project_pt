import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  final String name;
  final String profilePic;

  MessageCard(this.name, this.profilePic);

  @override
  _MessageCardState createState() => _MessageCardState(name, profilePic);
}

class _MessageCardState extends State<MessageCard> {
  _MessageCardState(this.name, this.profilePic);

  String name;
  String profilePic;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      height: 40.0,
      child: Row(
        children: <Widget>[
          Image.asset(
            this.profilePic,
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    this.name,
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  Text(
                    '5:00 pm' // place holder for time last message was sent
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'The last message sent',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
