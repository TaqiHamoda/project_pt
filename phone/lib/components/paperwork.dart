import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phone/screens/trainer/trainer_program_screen.dart';

class Program extends StatelessWidget {
  List<Exercise> exercises = [];
  String warmup;
  String name;
  List<Goal> goals = [];

  Program(this.name, List<Goal> goals) {
    this.goals.addAll(goals);
  }

  List<Widget> getWorkout(String user) {
    List<Widget> workoutWidgets = [];

    if (user == 'Trainer') {
      for (Exercise exercise in this.exercises) {
        workoutWidgets.add(exercise.trainer());
      }
    } else {
      for (Exercise exercise in this.exercises) {
        workoutWidgets.add(exercise.client());
      }
    }

    return workoutWidgets;
  }

  void addExercise(Exercise exercise) {
    this.exercises.add(exercise);
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
                  builder: (context) => TrainerProgramPage(this)));
        },
        title: Text(
          this.name,
          textAlign: TextAlign.left,
        ));
  }
}

class Exercise {
  String name = '';
  String sets = '';
  String reps = '';
  String rest = '';
  String rpe = '';
  String notes = '';
  bool completed = false;

  Widget trainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        color: Colors.grey,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(children: <Widget>[
                Expanded(
                  flex: 5,
                    child: Container(child: TextField(
                      decoration: InputDecoration(labelText: 'Exercise Title', contentPadding: EdgeInsets.all(10)),
                    ), alignment: Alignment(0, -1),)
                ),

                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment(0, 1),
                      child: Icon(Icons.trip_origin, color: this.completed ? Colors.green : null,)
                  ),
                )


              ],),
            ),

            Row(children: <Widget>[
              Expanded(
                child: Column(children: <Widget>[
                  Text('Sets'),

                  TextField(
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              ),

              Expanded(
                child: Column(children: <Widget>[
                  Text('Reps'),

                  TextField(
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              ),

              Expanded(
                child: Column(children: <Widget>[
                  Text('Rest (Min)'),

                  TextField(
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              ),

              Expanded(
                child: Column(children: <Widget>[
                  Text('RPE'),

                  TextField(
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              )
            ],),

            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextField(
                maxLines: 2,
                decoration: InputDecoration(labelText: 'Notes', contentPadding: EdgeInsets.all(10)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget client() {}
}

class WarmUp {}

class SuperSet extends Exercise {}

class Goal extends StatelessWidget {
  String goal;
  bool reached = false;

  Goal(this.goal);

  void reachedGoal() {
    this.reached = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.trip_origin,
            color: reached ? Colors.green : null,
          ),
          title: Text('Goal: ' + this.goal),
        ),
        Divider(
          thickness: 1.5,
        )
      ],
    );
  }
}
