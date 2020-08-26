import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';
import 'package:phone/screens/director/typical_card.dart';
import 'package:phone/screens/main/custom_button.dart';
import 'package:phone/screens/main/pressable_info.dart';
import 'package:phone/screens/main/dialog.dart';

class TypicalTrainerDetails extends StatefulWidget {
  final Trainer trainer;
  final String name;

  TypicalTrainerDetails({this.trainer, this.name});

  @override
  _TypicalTrainerDetails createState() =>
      _TypicalTrainerDetails(this.trainer, this.name);
}

class _TypicalTrainerDetails extends State<TypicalTrainerDetails> {
  final String name;
  final Trainer user;
  String search = '';

  _TypicalTrainerDetails(this.user, this.name);

  List<Widget> filter() {
    List<UserCard> filteredUsers = [];

    for (Client client in this.user.clients) {
      String clientName = client.firstName + ' ' + client.lastName;
      if (clientName.toLowerCase().contains(this.search.toLowerCase())) {
        filteredUsers.add(UserCard(name: clientName, user: client,));
      }
    }
    return filteredUsers;
  }

  void addClient() {
    String firstName;
    String lastName;
    String email;
    String phone;

    SpecialDialog(
      context: context,
        title: 'Create a client',
        onSubmit: () {
          this.user.addClient(Client(firstName, lastName, email, 'Bebop', phone));

          setState(() {
            this.filter();
          });
        },
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.0),
                    labelText: 'First Name',
                  ),
                  onChanged: (value) {
                    firstName = value;
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.0),
                    labelText: 'Last Name',
                  ),
                  onChanged: (value) {
                    lastName = value;
                  },
                ),
              ),
            ],
          ),
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10.0),
              labelText: 'Email',
            ),
            onChanged: (value) {
              email = value;
            },
          ),
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10.0),
              labelText: 'Phone Number',
            ),
            onChanged: (value) {
              phone = value;
            },
          ),
        ]);
  }

  void delete() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addClient();
        },
      ),
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
              onChanged: (value) {
                setState(() {
                  this.search = value;
                });
              },
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
      body: ListView(
          children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(top: 5.0, left: 5.0),
                          child: CircleAvatar(
                            backgroundImage: this.user.photo,
                            radius: 65,
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 2.0, left: 5.0),
                            child: Text(
                              this.user.firstName + " " + this.user.lastName,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            alignment: Alignment(-1, 0),
                          ),
                          PressableInfo(
                              label: 'Email: ',
                              info: this.user.email,
                              ext: 'mailto:'),
                          PressableInfo(
                              label: 'Phone Number: ',
                              info: this.user.phoneNum,
                              ext: 'tel:'),
                        ],
                      ),
                    )
                  ],
                ),
              ] +
              this.filter()),
    );
  }
}

enum Choices { delete }
