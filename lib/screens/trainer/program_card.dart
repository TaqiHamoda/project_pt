import 'package:flutter/material.dart';
import 'package:phone/screens/main/dialog.dart';
import 'goal_card.dart';
import 'package:phone/components/users.dart';
import 'package:phone/components/paperwork.dart';
import 'package:phone/screens/trainer/trainer_program_screen.dart';

class ProgramCard extends StatelessWidget {
  final Program program;
  final User user;
  final Function delete;

  ProgramCard(
      {@required this.program, @required this.user, @required this.delete});

  get goals {
    List<GoalCard> goals = [];

    for (Goal goal in this.program.goals) {
      goals.add(GoalCard(
        goal: goal,
      ));
    }

    return goals;
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Remove this program?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'You will not be able to restore the program after it is deleted.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Delete', style: TextStyle(fontSize: 18),),
                onPressed: () {
                  delete();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Cancel', style: TextStyle(fontSize: 18),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.table_chart),
        trailing: this.user is Trainer ? IconButton(
          onPressed: () {
            _showDialog(context);
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ) : null,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TrainerProgramPage(
                        programCard: this,
                        user: this.user,
                      )));
        },
        title: Text(
          this.program.name,
          textAlign: TextAlign.left,
        ));
  }
}
