import 'package:flutter/material.dart';
import 'screens/main/login_screen.dart';
import 'package:phone/components/users.dart';


void main() => runApp(Starter());

class Starter extends StatelessWidget {
  User user;

  Starter(){
    List<User> users = localUsers();

    for(User user in users){
      if(user is Director){
        this.user = user;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

