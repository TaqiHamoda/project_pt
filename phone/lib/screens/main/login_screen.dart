import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../director/director_screen.dart';
import '../trainer/trainer_screen.dart';
import '../trainer/client_screen.dart';
import 'typical_submit_info_screen.dart';
import '../../components/users.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _userEmail = '';
  String _userPassword = '';
  bool error = false;

  void logIn() {
    bool success = false;

    for (User user in userCreator()) {
      if ((user.email == this._userEmail) && user.signIn(this._userPassword)) {

        if (user is Client) {
          success = true;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ClientPage(user)));
        } else if (user is Director){
          success = true;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DirectorPage(user)));
        } else if (user is Trainer) {
          success = true;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TrainerPage(user)));
        }

      }
    }

    setState(() {
      this.error =  !success;
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

            Expanded(child: Container()),

            Expanded(
              flex: 5,
              child: Center(
                  child: Image.asset(
                'images/temp-logo.png',
                height: 200,
                width: 200,
              )),
            ),

            Expanded(
              flex: 10,
              child: Column(children: <Widget>[
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
                    obscureText: true,
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

                Row(
                  children: <Widget>[
                    Expanded(child: Container(), flex: 5,),

                    Expanded(
                      flex: 4,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubmitInfoPage(
                                    'Forgot Password', 'Enter your email', Icon(Icons.mail))));
                        },
                        child: Text(
                          'Forgot Password?',
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),

                InkWell(
                  onTap: () {
                    this.logIn();
                  },
                  child: Container(
                    width: 250.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50].withOpacity(0.1),
                      border: Border.all( width: 2.0, color: Colors.lightBlue.shade50 ),
                    ),
                    child: Center(
                      child: Text(
                        'Log-in',
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
                SizedBox(
                  height: 5.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubmitInfoPage(
                              'Register', 'Registration Key', Icon(Icons.vpn_key))));
                  },
                  child: Container(
                    width: 250.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50].withOpacity(0.1),
                      border: Border.all( width: 2.0, color: Colors.lightBlue.shade50 ),
                    ),
                    child: Center(
                      child: Text(
                        'Register',
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

                SizedBox(
                  height: 20,
                ),

                Visibility(
                  visible: this.error,
                  child: Text(
                    'The E-mail or the password is incorrect',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                    textAlign: TextAlign.center,
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
