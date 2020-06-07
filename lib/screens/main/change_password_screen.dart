import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';
import 'login_screen.dart';

class ChangePwPage extends StatefulWidget {

  final User user;
  ChangePwPage(this.user);

  @override
  _ChangePwPageState createState() => _ChangePwPageState(this.user);
}

class _ChangePwPageState extends State<ChangePwPage> {

  User user;
  String pw = ''; // validation still requires slight tweaking, will be worked on later.


  _ChangePwPageState(this.user);

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('You have successfully changed your password'),
          actions: <Widget>[
            FlatButton(
              child: Text('Return to login page'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              autovalidate: true,
              validator: (String value){
                return user.signIn(this.user.email, value)? null : 'Password does not match';
              },
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Current password',
              ),
            ),
            TextFormField(
              onChanged: (String value){
                pw = value;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline),
                labelText: 'New password',
              ),
            ),
            TextFormField(
              autovalidate: true,
              validator: (String value){
                return value == pw? null : 'Passwords do not match';
              },
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline),
                labelText: 'Confirm new password',
              ),
            ),
            FlatButton(
              color: Colors.lightBlue,
              onPressed: (){
                user.setPassword(pw);
                setState(() {
                  _showDialog();
                });
              },
              child: Text(
                'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
