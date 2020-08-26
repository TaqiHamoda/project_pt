import 'package:flutter/material.dart';
import 'package:phone/screens/main/messaging_screen.dart';
import 'package:phone/screens/main/dialog.dart';
import 'package:phone/components/users.dart';
import 'package:phone/screens/main/message_list.dart';
import 'typical_card.dart';

class UserPage extends StatefulWidget {
  final Director director;
  final String screenType;

  UserPage(this.director, this.screenType,);

  @override
  _UserPageState createState() =>
      _UserPageState(this.director, this.screenType,);
}

class _UserPageState extends State<UserPage> {
  Director director;
  String screenType;
  String search = '';
  Widget floatingButton;

  _UserPageState(this.director, this.screenType,);

  List<UserCard> filter() {

    List<UserCard> filtered = [];
    List<User> users;

    if(this.screenType == 'Trainer'){
      users = director.trainers;
    } else if(this.screenType == 'Director'){
      users = director.directors;
    } else {
      users = [];

      for(Trainer trainer in this.director.directors + this.director.trainers){
        for(Client client in trainer.clients){
          users.add(client);
        }
      }

      users.addAll(this.director.clients);
    }

    for (User user in users) {

      String userName = user.firstName + ' ' + user.lastName;

      if (userName.toLowerCase().contains(this.search.toLowerCase())) {
        filtered.add(UserCard(
          user: user,
          name: userName,
        ));
      }
    }

    return filtered;
  }

  void add() {
    String firstName;
    String lastName;
    String email;
    String phone;

    SpecialDialog(
      context: context,
        title: 'Create a ' + this.screenType,
        onSubmit: () {
          if (this.screenType == 'Trainer') {
            director.addTrainer(
                Trainer(firstName, lastName, email, 'Bebop', phone));
          } else if (this.screenType == 'Director') {
            director.addDirector(
                Director(firstName, lastName, email, 'Bebop', phone));
          }
          
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: this.screenType == 'Client'
          ? null
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                this.add();
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
        centerTitle: true,
        title: Text(
          this.screenType + 's',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.near_me,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewMessagePage())); //fix later
            },
          ),
        ],
      ),
      body: ListView(
        children: this.filter(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('Schedule'),
            icon: Icon(
              Icons.calendar_today,
            ),
          ),
        ],
      ),
    );
  }
}
