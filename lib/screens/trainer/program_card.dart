import 'package:flutter/material.dart';
import 'goal_card.dart';
import 'package:phone/components/users.dart';
import 'package:phone/components/paperwork.dart';
import 'package:phone/screens/trainer/trainer_program_screen.dart';

class ProgramCard extends StatelessWidget {
  final Program program;
  final Trainer trainer;

  ProgramCard({@required this.program, @required this.trainer});

  get goals{
    List<GoalCard> goals = [];

    for(Goal goal in this.program.goals){
      goals.add(GoalCard(goal: goal,));
    }

    return goals;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.table_chart),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TrainerProgramPage(programCard: this, trainer: this.trainer,)));
        },
        title: Text(
          this.program.name,
          textAlign: TextAlign.left,
        ));
  }
}


