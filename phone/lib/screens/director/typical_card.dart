import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';
import 'package:phone/screens/director/typical_trainers_details.dart';
import 'package:phone/screens/main/pressable_info.dart';


class UserCard extends StatelessWidget {

  final String name;
  final User user;
  final List<PressableInfo> info = [];
  Widget preferredWidget;

  UserCard({this.user, this.name}){
    this.info.add(PressableInfo(label: 'E-mail: ', info: this.user.email, ext: 'mailto:'));
    this.info.add(PressableInfo(label: 'Phone Number: ', info: this.user.phoneNum, ext: 'tel:'));

    if (this.user is Trainer) {
      preferredWidget = PopupMenuButton<Choices>(
        onSelected: (Choices result) {
          if (result == Choices.delete) {
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Choices>>[
          PopupMenuItem<Choices>(
            value: Choices.delete,
            child: Text('Delete'),
          ),
        ],
      );
    }

    else {
      Client client = this.user;

      this.info.add(PressableInfo(label: 'Sessions Remaining: ', info: client.sessions.toString(), ext: null));

      preferredWidget = PopupMenuButton<Choices>(
        onSelected: (Choices result) {
          if (result == Choices.parQ) {

          } else if (result == Choices.assessment){

          } else if (result == Choices.addSessions){

          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Choices>>[
          PopupMenuItem<Choices>(
            value: Choices.parQ,
            child: Text('Par-Q'),
          ),
          PopupMenuItem<Choices>(
            value: Choices.assessment,
            child: Text('Assessment'),
          ),
          PopupMenuItem<Choices>(
            value: Choices.addSessions,
            child: Text('Add Sessions'),
          ),
        ],
      );
    }
  }


  void delete() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: false,
      splashColor: Colors.transparent,
      onTap: () {
        if (this.user is Trainer) {
          Trainer trainer = this.user;

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TypicalTrainerDetails(trainer: trainer, name: this.name,)));
        }
      },
      child: Card(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(10),
                  child: CircleAvatar(backgroundImage: this.user.photo, radius: 45,)),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ] + this.info,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment(1.0, 0.0),
                child: this.preferredWidget,),
            )
          ],
        ),
      ),
    );
  }
}

enum Choices {delete, parQ, assessment, addSessions}

