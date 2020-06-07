import 'package:flutter/material.dart';
import 'package:phone/components/paperwork.dart';
import 'client_goal_screen.dart';

class GoalCard extends StatelessWidget {
  final Goal goal;

  GoalCard({@required this.goal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircularProgressIndicator(value: (this.goal.current/this.goal.load), backgroundColor: Colors.grey,),
          title: Text(this.goal.toString()),
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GoalPage(goal: this.goal)));
          },
        ),
        Divider(
          thickness: 1.5,
        )
      ],
    );
  }
}

