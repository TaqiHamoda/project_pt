import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone/screens/register_screen.dart';
import 'director_screen.dart';
import 'trainer_screen.dart';
import 'user_screen.dart';
import 'forgot_password_screen.dart';
import 'local_users.dart';
import 'users.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _userEmail = '';
  String _userPassword = '';
  bool error = false;

  void logIn(){
    createUsers();

    for(User user in users){
      if((user.email == this._userEmail) && user.signIn(this._userPassword)){

        if(user is Client){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserPage()));
        }

        else if(user is Trainer){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TrainerPage()));
        }
      }
    }

    setState(() {
      this.error = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background1.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Image.asset(
              'images/temp-logo.png',
              height: 200,
              width: 200,
            )),
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10.0, bottom: 5.0),
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  icon: Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                onChanged: (value) {
                  _userEmail = value;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 5.0, bottom: 10.0),
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                onChanged: (value) {
                  _userPassword = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 200.0),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ForgotPwPage()));
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () { this.logIn(); },
              child: Container(
                width: 250.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50].withOpacity(0.1),
                  border: Border(
                    top: BorderSide(width: 2.0, color: Colors.lightBlue.shade50),
                    bottom: BorderSide(width: 2.0, color: Colors.lightBlue.shade50),
                    right: BorderSide(width: 2.0, color: Colors.lightBlue.shade50),
                    left: BorderSide(width: 2.0, color: Colors.lightBlue.shade50)
                  ),

                ),

                child: Center(
                  child: Text('Log-in',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

            Visibility(
              visible: this.error,
              child: Text('The E-mail or the password is incorrect',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
