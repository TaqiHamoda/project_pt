import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phone/screens/trainer/client_card.dart';
import 'package:phone/screens/trainer/program_screen.dart';
import '../main/messages_screen.dart';
import '../../components/users.dart';
import 'package:phone/components/paperwork.dart';

class ClientDetails extends StatefulWidget {
  final Client user;
  final String photo;
  final String name;

  ClientDetails(this.user, this.name, this.photo);

  @override
  _ClientDetails createState() => _ClientDetails(this.user, this.name, this.photo);
}

class _ClientDetails extends State<ClientDetails> {
  final String name;
  final String photo;
  final Client client;

  _ClientDetails(this.client, this.name, this.photo);

  void delete(){}

  void addProgram(BuildContext context) {
    String programName = '';

    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: const Text('Create a new program'),
          children: <Widget>[

            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                labelText: 'Program Name',
              ),

              onChanged: (value){ programName = value; },
            ),


            Row(children: <Widget>[
            Container(
              alignment: Alignment(-1.0, 0.0),
              child: FlatButton(
                child: new Text('Ok',
                  style: TextStyle(color: Colors.blue),),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    this.client.addProgram(Program(programName, this.client.goals));
                  });
                },
              ),
            ),

            Container(
              alignment: Alignment(1.0, 0.0),
              child: FlatButton(
                child: new Text('Cancel',
                  style: TextStyle(color: Colors.blue),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            ])
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){this.addProgram(context);},
      ),

      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.near_me),
              onPressed: (){}),

          PopupMenuButton<Choices>(
            onSelected: (Choices result) { setState(() { delete(); }); },
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
                    child: Image.asset(this.photo)),
              ),

              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 2.0, left: 5.0),
                      child: Text(this.client.firstName + " " + this.client.lastName,
                        style: TextStyle(fontSize: 30,
                            fontWeight: FontWeight.bold),),
                      alignment: Alignment(-1, 0),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
                      child: Text("Email: " + this.client.email,
                        style: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.bold),),
                      alignment: Alignment(-1, 0),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 10.0, left: 5.0),
                      child: Text("Phone Number: " + this.client.phoneNum,
                        style: TextStyle(fontSize: 15,
                            fontWeight: FontWeight.bold),),
                      alignment: Alignment(-1, 0),
                    ),
                  ],
                ),
              )
            ],
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                  ),
                  child: FlatButton(
                    onPressed: (){},
                    child: Text("Par-Q"),
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: FlatButton(
                      onPressed: (){},
                      child: Text("Assessment")),
                ),
              )
            ],
          )
        ] + this.client.programs,
      ),
    );
  }
}


enum Choices{delete}

