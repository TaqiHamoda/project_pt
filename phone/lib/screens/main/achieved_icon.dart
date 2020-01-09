import 'package:flutter/material.dart';

class AchievedIcon extends StatefulWidget {
  final bool completed;

  AchievedIcon(this.completed);

  @override
  _AchievedIconState createState() => _AchievedIconState(this.completed);
}

class _AchievedIconState extends State<AchievedIcon> {
  bool completed;

  _AchievedIconState(this.completed);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.trip_origin, color: this.completed ? Colors.green : null,),
      onPressed: (){ this.completed = !this.completed; },);
  }
}


