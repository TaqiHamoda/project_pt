import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../components/users.dart';

class TrainerDetails extends StatefulWidget {
  final Trainer user;
  final String photo;
  final String name;

  TrainerDetails(this.user, this.name, this.photo);

  @override
  _TrainerDetails createState() =>
      _TrainerDetails(this.user, this.name, this.photo);
}

class _TrainerDetails extends State<TrainerDetails> {
  final String name;
  final String photo;
  final Trainer trainer;

  _TrainerDetails(this.trainer, this.name, this.photo);

  void delete() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.near_me), onPressed: () {}),
          PopupMenuButton<Choices>(
            onSelected: (Choices result) {
              setState(() {
                delete();
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choices>>[
              PopupMenuItem<Choices>(
                value: Choices.delete,
                child: Text('Delete ' + this.trainer.firstName),
              ),
            ],
          )
        ],
      ),
      body: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 5.0, left: 5.0),
                      child: Image.asset(this.photo)),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 2.0, left: 5.0),
                        child: Text(
                          this.trainer.firstName + " " + this.trainer.lastName,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment(-1, 0),
                      ),

                      PressableInfo('Email: ', this.trainer.email, (){}),
                      PressableInfo('Phone Number: ', this.trainer.phoneNum, (){}),

                    ],
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text("Clients"),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)),
                    child: FlatButton(
                        onPressed: () {}, child: Text("Forms")),
                  ),
                )
              ],
            )
          ]
      ),
    );
  }
}

class PressableInfo extends StatelessWidget {
  final String label;
  final String info;
  final Function _function;

  PressableInfo(this.label, this.info, this._function);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
      child: Row(
        children: <Widget>[
          Text(
            this.label,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          InkWell(
            splashColor: Colors.transparent,
            enableFeedback: false,
            onTap: this._function,
            child: Text(
              this.info,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          )
        ],
      ),
      alignment: Alignment(-1, 0),
    );
  }
}

enum Choices { delete }


