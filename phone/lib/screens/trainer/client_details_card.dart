import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phone/screens/trainer/client_card.dart';
import '../main/messages_screen.dart';
import '../../components/users.dart';
import 'package:phone/components/paperwork.dart';

class ClientDetails extends StatelessWidget {

  ClientDetails({@required this.client, @required this.name, @required this.photo});

  final String name;
  final String photo;
  final Client client;

  void addProgram(BuildContext context) {
    String programName = '';
    String warmup = '';

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

              onChanged: (value){ programName += value; },
            ),

            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                labelText: 'Warmup',
              ),

              onChanged: (value){ warmup += value; },
            ),

            Row(children: <Widget>[
            Container(
              alignment: Alignment(-1.0, 0.0),
              child: FlatButton(
                child: new Text('Ok',
                  style: TextStyle(color: Colors.blue),),
                onPressed: () {
                  this.client.addProgram(Program(programName, warmup, this.client.goals));
                  Navigator.of(context).pop();
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
        title: Text(
          '$name\'s profile'
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessagePage(this.client)));
            },
            icon: Icon(
              Icons.near_me,
            ),
          ),
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
                      margin: EdgeInsets.only(bottom: 10.0, left: 5.0),
                      child: Text("Name: " + this.client.firstName + " " + this.client.lastName,
                        style: TextStyle(fontSize: 15,
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
        ],
      ),
    );
  }
}
