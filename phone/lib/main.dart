import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() => runApp(Trainer());

class Trainer extends StatelessWidget { // Trainer is a placeholder name for the app name.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF7775FF), // eh ra2yak?
        scaffoldBackgroundColor: Color(0xFF7775FF),
      ),
      home: LoginPage(),
    );
  }
}

