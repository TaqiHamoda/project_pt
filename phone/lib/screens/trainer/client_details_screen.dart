import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../main/messages_screen.dart';
import 'package:phone/components/users.dart';
import 'package:phone/screens/main/custom_button.dart';
import 'package:phone/screens/main/dialog.dart';
import 'package:phone/components/paperwork.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientDetails extends StatefulWidget {
  final Client user;
  final String name;

  ClientDetails(this.user, this.name);

  @override
  _ClientDetails createState() =>
      _ClientDetails(this.user, this.name);
}

class _ClientDetails extends State<ClientDetails> {
  final String name;
  final Client client;

  _ClientDetails(this.client, this.name);

  void delete() {}

  void addProgram(BuildContext context) {
    String programName = '';

    SpecialDialog(context, 'Create a new program',
            (){setState(() {
              this.client.addProgram(Program(programName, this.client.goals));
            });},
        [TextField(
          autofocus: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.0),
            labelText: 'Program Name',
          ),
          onChanged: (value) {
            programName = value;
          },
        ),]);

  }

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
                child: Text('Delete ' + this.client.firstName),
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
                        child: CircleAvatar(backgroundImage: this.client.photo, radius: 65,)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 2.0, left: 5.0),
                          child: Text(
                            this.client.firstName + " " + this.client.lastName,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment(-1, 0),
                        ),

                        PressableInfo('Email: ', this.client.email, 'mailto:'),
                        PressableInfo('Phone Number: ', this.client.phoneNum, 'tel:'),
                        
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CustomButton((){}, 'Par-Q')
                  ),
                  Expanded(
                    child: CustomButton((){}, 'Assessment')
                  )
                ],
              )
            ] +
            this.client.programs +
            [CustomButton((){this.addProgram(context);}, 'Create Program')],
      ),
    );
  }
}


class PressableInfo extends StatelessWidget {
  String label;
  String info;
  String ext;

  PressableInfo(this.label, this.info, this.ext){
    if(this.ext == 'mailto:'){
      this.ext = 'mailto:' + this.info +'?subject=Training&body= ';
    } else if(this.ext == 'tel:'){
      if(this.info.length == 10){
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
            onTap: (){_launchURL(this.ext);},
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
