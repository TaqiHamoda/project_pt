import 'package:flutter/material.dart';
import 'package:phone/components/paperwork.dart';
import 'client_goal_screen.dart';
import 'package:phone/components/users.dart';

class GoalCard extends StatelessWidget {
  final Goal goal;
  final Client client;
  final bool userIsClient;

  GoalCard({@required this.goal, @required this.client, @required this.userIsClient});

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
                    builder: (context) => GoalPage(goal: this.goal, client: this.client, userIsClient: this.userIsClient,)));
          },
        ),
        Divider(
          thickness: 1.5,
        )
      ],
    );
  }
}

