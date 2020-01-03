import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/trainer_screen.dart';

void main() => runApp(Starter());

class Starter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

