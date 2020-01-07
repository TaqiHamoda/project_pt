import 'package:flutter/material.dart';
import 'package:phone/screens/main/messages_screen.dart';
import 'package:phone/screens/main/dialog.dart';
import 'package:phone/components/users.dart';
import 'typical_card.dart';

class UserPage extends StatefulWidget {

  final User user;
  final String screenType;
  final List<UserCard> cards;

  UserPage(this.user, this.screenType, this.cards);

  @override
  _UserPageState createState() => _UserPageState(this.user, this.screenType, this.cards);
}

class _UserPageState extends State<UserPage> {

  User user;
  String screenType;
  List<UserCard> cards;
  String search = '';

  _UserPageState(this.user, this.screenType, this.cards);

  List<UserCard> filter(String filterText) {

    if (filterText == '') {
      return cards;
    }
    List<UserCard> filteredUsers = [];
    for (UserCard card in cards) {
      String userName = card.name.toLowerCase();
      if (userName.contains(filterText.toLowerCase())) {
        filteredUsers.add(card);
      }
    }
    return filteredUsers;
  }

  void add(BuildContext context) {
    String firstName;
    String lastName;
    String email;
    String phone;

    SpecialDialog(context, 'Create a ' + this.screenType, () {
      setState(() {
        if(this.screenType == 'Trainer') {
          Director director = this.user;
          director.addTrainer(Trainer(firstName, lastName, email, 'Bebop', phone));
        }

        else if(this.screenType == 'Director') {
          Director director = this.user;
          director.addDirector(Director(firstName, lastName, email, 'Bebop', phone));
        }

        else{
          Trainer trainer = this.user;
          trainer.addClient(Client(firstName, lastName, email, 'Bebop', phone, this.user));
        }
      });
    }, <Widget>[
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          this.add(context);
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
              onChanged: (value){setState(() {
                this.search = value;
              });},
            ),
          ),
        ),
        centerTitle: true,
        title: Text(this.screenType + 's',
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
                      builder: (context) => MessagePage(this.user)));
            },
          ),
        ],
      ),
      body: ListView(
        children: this.filter(this.search),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index){
          if (index == 0){
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