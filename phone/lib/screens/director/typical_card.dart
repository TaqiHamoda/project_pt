import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';
import 'package:phone/screens/director/typical_trainers_details.dart';
import 'package:url_launcher/url_launcher.dart';

class UserCard extends StatelessWidget {

  final String name;
  final User user;
  Widget preferredWidget;

  UserCard(this.user, this.name){
    if (this.user is Trainer) {
      preferredWidget = IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            this.delete();
          });
    } else {
      preferredWidget = PopupMenuButton<Choices>(
        onSelected: (Choices result) {
          if (result == Choices.parQ) {
          } else {}
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TypicalTrainerDetails(this.user, this.name)));
        }
      },
      child: Card(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 70, height: 70,
                  child: this.user.photo,),
                  SizedBox(width: 10.0,),
                  Text(
                    this.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 3,
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.email), onPressed: () {
                    _launchURL('mailto:' + this.user.email + '?subject= &body= ');
                  }),

                  IconButton(icon: Icon(Icons.phone), onPressed: () {
                    _launchURL('tel:+1' + this.user.phoneNum);
                  }),
                  Container(
                      alignment: Alignment(1.0, 0.0), child: this.preferredWidget)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Future<void> _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
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

enum Choices { parQ, assessment }

