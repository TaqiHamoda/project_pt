import 'package:flutter/material.dart';
import 'screens/main/login_screen.dart';
import 'package:phone/components/users.dart';


void main() => runApp(Starter());

class Starter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

