import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';


class SettingsPage extends StatefulWidget {

  final User user;
  SettingsPage(this.user);

  @override
  _SettingsPageState createState() => _SettingsPageState(this.user);
}

class _SettingsPageState extends State<SettingsPage> {

  User user;
  String name = '';
  String email = '';
  String number = '';

  _SettingsPageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Profile Picture',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 18.0
                  ),
                ),
              ],
            ),
            Image.asset(
              'images/profile.png',
              height: 100.0,
              width: 100.0,
            ),
            Divider(
              thickness: 1.1,
            ),
            TextFormField(
              autovalidate: true,
              initialValue: user.firstName + ' ' + user.lastName,
              validator: (String value){
                return value.contains(' ')? null : 'enter valid name';
              },
              onFieldSubmitted: (String value){
                this.user.setName(value);
              },
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Name',
              ),
            ),
            TextFormField(
              autovalidate: true,
              initialValue: user.email,
              validator: (String value){
                return value.contains('@')? null : 'Please enter valid email';
              },
              onFieldSubmitted: (String value){
                this.user.setEmail(value);
              },
              decoration: InputDecoration(
                icon: Icon(Icons.mail),
                labelText: 'Email',
              ),
            ),
            TextFormField(
              autovalidate: true, // will add one eventually
              initialValue: user.phoneNum,
              onFieldSubmitted: (String value){
                this.user.setNumber(value);
              },
              decoration: InputDecoration(
                icon: Icon(Icons.phone),
                labelText: 'Phone Number',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
