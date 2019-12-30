import 'package:flutter/material.dart';
import 'package:phone/screens/register_screen.dart';
import 'director_screen.dart';
import 'trainer_screen.dart';
import 'user_screen.dart';
import 'forgot_password_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String userEmail = '';
  String userPassword = '';
  String userType = ''; // user? trainer? director? etc. Will go more in depth once we use firebase.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'Trainer',
              style: TextStyle(
                color: Color(0xFF292E21),
                fontFamily: 'Boogaloo',
                fontSize: 45.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
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
              onChanged: (value){
                userEmail = value;
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
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
              onChanged: (value){
                userPassword = value;
              },
            ),
          ),
          ButtonTheme(
            minWidth: 275.0,
            height: 20.0,
            buttonColor: Colors.orangeAccent,
            child: RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  RegisterPage()));
              },
              child: Text(
                'Register',
                style: TextStyle(
                  color: Color(0xFF292E21),
                  fontFamily: 'Boogaloo',
                  fontSize: 35.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          ButtonTheme(
            minWidth: 275.0,
            height: 20.0,
            buttonColor: Colors.orangeAccent,
            child: RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  UserPage()));
                // for now, eventually will have bunch of if statements to determine user type.
              },
              child: Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFF292E21),
                  fontFamily: 'Boogaloo',
                  fontSize: 35.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          FlatButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  ForgotPwPage()));
            },
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 17.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
