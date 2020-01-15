import 'package:flutter/material.dart';
import 'package:phone/components/paperwork.dart';

class GoalCard extends StatelessWidget {
  final Goal goal;

  GoalCard({@required this.goal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircularProgressIndicator(value: (this.goal.current/this.goal.load), backgroundColor: Colors.grey,),
          title: Text(this.goal.exercise + ' ' + this.goal.load.toString() + ' ' + this.goal.unit + ' by ' + this.goal.date),
        ),
        Divider(
          thickness: 1.5,
        )
      ],
    );
  }
}

