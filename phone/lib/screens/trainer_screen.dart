import 'package:flutter/material.dart';
import 'package:phone/screens/messages_screen.dart';
import 'package:phone/screens/user_card.dart';
import 'user_card.dart';
import 'users.dart';
import 'local_users.dart';



class TrainerPage extends StatefulWidget {
  @override
  _TrainerPageState createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {

  TextEditingController controller = new TextEditingController();
  String filter;

  // will add search functionality later

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),),
      appBar: AppBar(
        title: Text(
          'Trainer',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.near_me,
            ),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessagePage()));
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10.0),
              labelText: 'Search by name',
              prefixIcon: Icon(
                Icons.search,
              ),
            ),
            controller: controller,
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: EdgeInsets.all(10),
            children: <Widget>[
              Hero(
                tag: 'dash',
                child: UserCard(
                  name: 'Youssef',
                  photo: 'images/temp-logo.png'
                ),
              ),
              UserCard(
                name: 'Youssef Nafei',
                photo: 'images/temp-logo.png'
              ),
              UserCard(
                name: 'Youssef Nafei',
                photo: 'images/temp-logo.png'
              ),
              UserCard(
                name: 'Youssef Nafei',
                photo: 'images/temp-logo.png'
              ),
              UserCard(
                name: 'Youssef Nafei',
                photo: 'images/temp-logo.png'
              ),
              UserCard(
                name: 'Youssef Nafei',
                photo: 'images/temp-logo.png'
              ),
              UserCard(
                name: 'Youssef Nafei',
                photo: 'images/temp-logo.png'
              ),
              UserCard(
                name: 'Youssef Nafei',
                photo: 'images/temp-logo.png'
              ),
              UserCard(
                name: 'Youssef Nafei',
                photo: 'images/temp-logo.png'
              ),
              UserCard(
                name: 'Youssef Nafei',
                photo: 'images/temp-logo.png'
              ),
              UserCard(
                name: 'Youssef Nafei',
                photo: 'images/temp-logo.png'
              ),
              UserCard(
                name: 'Youssef Nafei',
                photo: 'images/temp-logo.png'
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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