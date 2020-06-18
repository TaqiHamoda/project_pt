import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';
import 'package:phone/screens/main/change_password_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'login_screen.dart';

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
  bool _darkMode = false;
  Widget _image;

  final RegExp nameExp = RegExp(r"^[a-z]+ [a-z]+$", caseSensitive: false);
  final RegExp phoneExp = RegExp(r"^[0-9]{10}$");
  // No regex for email cuz a7a bro there's .com, .ca, youssef.nafei@mail.utoronto.ca

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      this.user.photo = (image == null ? this.user.photo : FileImage(image));
    });
  }

  _SettingsPageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangePwPage(this.user)));
          },
          label: Text('Change Password'),
          icon: Icon(
            Icons.lock,
          ),
          backgroundColor: Colors.pink,
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              'Log Out',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
        title: Text(
          'Edit Profile',
        ),
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: this.user.photo,
                    backgroundColor: Colors.transparent,
                    radius: 100,
                  ),
                  FlatButton(
                    onPressed: () {
                      getImage();
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1.1,
              ),
              TextFormField(
                autovalidate: true,
                initialValue: user.firstName + ' ' + user.lastName,
                validator: (String value) {
                  return nameExp.hasMatch(value.trim())
                      ? null
                      : 'Enter valid name';
                },
                onFieldSubmitted: (String value) {
                  this.user.setName(value);
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                initialValue: user.email,
                onFieldSubmitted: (String value) {
                  this.user.email = value;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.mail),
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                autovalidate: true,
                initialValue: user.phoneNum,
                validator: (String value) {
                  return phoneExp.hasMatch(value.trim())
                      ? null
                      : 'Enter valid phone number';
                },
                onFieldSubmitted: (String value) {
                  this.user.phoneNum = value;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  labelText: 'Phone Number',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      height: 50,
                      minWidth: 120,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          setState(() {
                            user.unit = 'Metric';
                          });
                        },
                        child: Text('Metric', style: TextStyle(color: Colors.white, fontSize: 18),),
                        color: user.unit == 'Metric' ? Colors.blue : Colors.lightBlueAccent,
                      ),
                    ),
                    SizedBox(width: 30,),
                    ButtonTheme(
                      height: 50,
                      minWidth: 120,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          setState(() {
                            user.unit = 'Imperial';
                          });
                        },
                        child: Text('Imperial', style: TextStyle(color: Colors.white, fontSize: 18),),
                        color: user.unit == 'Imperial' ? Colors.blue : Colors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
