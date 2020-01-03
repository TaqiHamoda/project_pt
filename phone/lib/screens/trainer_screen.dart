import 'package:flutter/material.dart';
import 'package:phone/screens/user_card.dart';
import 'user_card.dart';


class TrainerPage extends StatefulWidget {
  @override
  _TrainerPageState createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.lightBlue,
              child: Icon(
                Icons.near_me,
              ),
              height: 20.0,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20.0, top: 20.0),
            ),
          ),
          Expanded(
            flex: 6,
            child: UserCard()
          ),
          Expanded(
            child: Container(
              color: Colors.lightBlue,
              child: Icon(
                Icons.near_me,
              ),
              height: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
