import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';
import 'package:phone/screens/director/typical_card.dart';
import 'package:phone/screens/main/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class TypicalTrainerDetails extends StatefulWidget {
  final Trainer user;
  final String name;

  TypicalTrainerDetails(this.user, this.name);

  @override
  _TypicalTrainerDetails createState() => _TypicalTrainerDetails(this.user, this.name);
}

class _TypicalTrainerDetails extends State<TypicalTrainerDetails> {
  final String name;
  final Trainer user;
  List<UserCard> cards;
  String search = '';

  _TypicalTrainerDetails(this.user, this.name) {
    if (this.user is Trainer) {
      Trainer trainer = this.user;
      this.cards = [];

      for (Client client in trainer.getClients(trainer)) {
        cards.add(UserCard(
            user: client, name: client.firstName + " " + client.lastName));
      }

    } else {
      Row(
        children: <Widget>[
          Expanded(
            child: CustomButton(() {}, 'Par-Q'),
          ),
          Expanded(child: CustomButton(() {}, 'Assessment'))
        ],
      );
    }
  }

  List<Widget> filter(String filterText) {
    if (filterText == '') {
      return cards;
    }
    List<Widget> filteredUsers = [];
    for (UserCard card in cards) {
      String userName = card.name.toLowerCase();
      if (userName.contains(filterText.toLowerCase())) {
        filteredUsers.add(card);
      }
    }
    return filteredUsers;
  }

  void delete() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              onChanged: (value){setState(() {
                this.search = value;
              });},
            ),
          ),
        ),
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
                child: Text('Delete ' + this.user.firstName),
              ),
            ],
          )
        ],
      ),
      body: ListView(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 5.0, left: 5.0),
                  child: Image.asset(this.user.photo)),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 2.0, left: 5.0),
                    child: Text(
                      this.user.firstName + " " + this.user.lastName,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment(-1, 0),
                  ),
                  PressableInfo('Email: ', this.user.email, 'mailto:'),
                  PressableInfo('Phone Number: ', this.user.phoneNum, 'tel:'),
                ],
              ),
            )
          ],
        ),

        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          padding: EdgeInsets.all(10),
          children: this.filter(this.search),
        )
      ]),
    );
  }
}

class PressableInfo extends StatelessWidget {
  String label;
  String info;
  String ext;

  PressableInfo(this.label, this.info, this.ext) {
    if (this.ext == 'mailto:') {
      this.ext = 'mailto:' + this.info + '?subject=Training&body= ';
    } else if (this.ext == 'tel:') {
      if (this.info.length == 10) {
        this.ext = 'tel:+1' + this.info;
      }
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

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
            onTap: () {
              _launchURL(this.ext);
            },
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
