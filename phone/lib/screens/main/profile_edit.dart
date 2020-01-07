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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()));
              },
            ),
          ],
        );
      },
    );
  }

  _SettingsPageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
          onPressed: (){
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
            onPressed: (){
              _showDialog();
            },
            child: Text(
              'Log Out',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
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
                FlatButton(
                  onPressed: (){
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
              CircleAvatar(backgroundImage: this.user.photo, backgroundColor: Colors.transparent, radius: 80,),
            Divider(
              thickness: 1.1,
            ),
            TextFormField(
              autovalidate: true,
              initialValue: user.firstName + ' ' + user.lastName,
              validator: (String value){
                return nameExp.hasMatch(value.trim()) ? null : 'Enter valid name';
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
              initialValue: user.email,
              onFieldSubmitted: (String value){
                this.user.setEmail(value);
              },
              decoration: InputDecoration(
                icon: Icon(Icons.mail),
                labelText: 'Email',
              ),
            ),
            TextFormField(
              autovalidate: true,
              initialValue: user.phoneNum,
              validator: (String value){
                return phoneExp.hasMatch(value.trim()) ? null : 'Enter valid phone number';
              },
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
