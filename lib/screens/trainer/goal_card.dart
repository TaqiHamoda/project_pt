import 'package:flutter/material.dart';
import 'package:phone/components/paperwork.dart';
import 'client_goal_screen.dart';
import 'package:phone/components/users.dart';

class GoalCard extends StatelessWidget {
  final Goal goal;
  final Client client;

  GoalCard({@required this.goal, @required this.client});

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
                    builder: (context) => GoalPage(goal: this.goal, client: this.client,)));
          },
        ),
        Divider(
          thickness: 1.5,
        )
      ],
    );
  }
}

