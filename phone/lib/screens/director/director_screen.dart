import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';
import 'package:phone/screens/director/all_clients_screen.dart';
import 'package:phone/screens/director/my_clients_screen.dart';
import 'package:phone/screens/main/profile_edit.dart';
import 'directors_screen.dart';
import 'trainers_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DirectorPage extends StatefulWidget {
  final Director user;

  DirectorPage(this.user);

  @override
  _DirectorPageState createState() => _DirectorPageState(this.user);
}

class _DirectorPageState extends State<DirectorPage> {
  Director user;
  _DirectorPageState(this.user);

  @override
  Widget build(BuildContext context) { // will deal with the icons later.
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('images/profile.png'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsPage(this.user)));
          },
        ),
        centerTitle: true,
        title: Text(
          'Director ' + this.user.firstName,
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

            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Color(0xFF4C4F5E),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DirectorsPage(this.user)));
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.supervisor_account,
                          size: 50.0,
                          color: Colors.pink,
                        ),
                        Text(
                          'Directors',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Color(0xFF8D8E98),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: RaisedButton(
                    color: Color(0xFF4C4F5E),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainersPage(this.user)));
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.supervisor_account,
                          size: 50.0,
                          color: Colors.pink,
                        ),
                        Text(
                          'Trainers',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Color(0xFF8D8E98),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Color(0xFF4C4F5E),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyClientsPage(this.user)));
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.supervisor_account,
                          size: 50.0,
                          color: Colors.pink,
                        ),
                        Text(
                          'My Clients',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Color(0xFF8D8E98),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: RaisedButton(
                    color: Color(0xFF4C4F5E),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllClientsPage(this.user)));
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.supervisor_account,
                          size: 50.0,
                          color: Colors.pink,
                        ),
                        Text(
                          'All Clients',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Color(0xFF8D8E98),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
