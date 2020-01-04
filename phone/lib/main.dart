import 'package:flutter/material.dart';
import 'screens/main/login_screen.dart';
import 'package:phone/components/users.dart';
import 'package:phone/screens/trainer/trainer_screen.dart';


void main() => runApp(Starter());

class Starter extends StatelessWidget {
  User user;

  Starter(){
    List<User> users = localUsers();

    for(User user in users){
      if(user is Trainer){
        this.user = user;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TrainerPage(this.user),
    );
  }
}

