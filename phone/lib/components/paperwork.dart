import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phone/screens/trainer/trainer_program_screen.dart';
import 'dart:core';

class Program extends StatelessWidget {
  List<Exercise> exercises = [];
  String warmup;
  String name;
  List<Goal> goals = [];

  Program({this.name, List<Goal> goals}) {
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
                      onChanged: (value){ this.name = value; },
                      controller: TextEditingController(text: this.name),
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
                    textAlign: TextAlign.center,
                    onChanged: (value){ this.sets = value; },
                    controller: TextEditingController(text: this.sets),
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              ),

              Expanded(
                child: Column(children: <Widget>[
                  Text('Reps'),

                  TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value){ this.reps = value; },
                    controller: TextEditingController(text: this.reps),
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              ),

              Expanded(
                child: Column(children: <Widget>[
                  Text('Weight'),

                  TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value){ this.reps = value; },
                    controller: TextEditingController(text: this.reps),
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              ),

              Expanded(
                child: Column(children: <Widget>[
                  Text('Rest (Min)'),

                  TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value){ this.rest = value; },
                    controller: TextEditingController(text: this.rest),
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              ),

              Expanded(
                child: Column(children: <Widget>[
                  Text('RPE'),

                  TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value){ this.rpe = value; },
                    controller: TextEditingController(text: this.rpe),
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              )
            ],),

            Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  controller: TextEditingController(text: this.notes),
                  onChanged: (value){ this.notes = value; },
                  maxLines: 3,
                  decoration: InputDecoration(contentPadding: EdgeInsets.all(10), labelText: 'Notes'),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget client() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      color: Colors.grey,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(children: <Widget>[
              Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                      child: Text(this.name, style: TextStyle(fontSize: 20),)
                  )
              ),

              Expanded(
                flex: 1,
                child: Container(
                    alignment: Alignment(0, 1),
                    child: IconButton(
                        icon: Icon(Icons.trip_origin, color: this.completed ? Colors.green : null,),
                      onPressed: (){ this.completed = !this.completed; },)
                ),
              )


            ],),
          ),

          Row(children: <Widget>[
            Expanded(
              child: Column(children: <Widget>[
                Text('Sets'),

                TextField(
                  textAlign: TextAlign.center,
                  controller: TextEditingController(text: this.sets),
                  enabled: false,
                  decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                )
              ],),
            ),

            Expanded(
              child: Column(children: <Widget>[
                Text('Reps'),

                TextField(
                  textAlign: TextAlign.center,
                  controller: TextEditingController(text: this.reps),
                  enabled: false,
                  decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                )
              ],),
            ),

            Expanded(
              child: Column(children: <Widget>[
                Text('Weight'),

                TextField(
                  textAlign: TextAlign.center,
                  controller: TextEditingController(text: this.reps),
                  enabled: false,
                  decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                )
              ],),
            ),

            Expanded(
              child: Column(children: <Widget>[
                Text('Rest (Min)'),

                TextField(
                  textAlign: TextAlign.center,
                  controller: TextEditingController(text: this.rest),
                  enabled: false,
                  decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                )
              ],),
            ),

            Expanded(
              child: Column(children: <Widget>[
                Text('RPE'),

                TextField(
                  textAlign: TextAlign.center,
                  controller: TextEditingController(text: this.rpe),
                  enabled: false,
                  decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                )
              ],),
            )
          ],),

          Container(
            margin: EdgeInsets.only(top: 20),
            child: TextField(
              controller: TextEditingController(text: this.notes),
              enabled: false,
              maxLines: 3,
              decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
            )
            ),
        ],
      ),
    );
  }
}


class Circuit extends Exercise {}

class Goal extends StatelessWidget {
  int load;
  String exercise;
  List<List<dynamic>> progress = [];
  String unit;
  double current;
  String date;

  Goal({this.exercise, this.load, this.date, this.unit='lbs', this.current=0});

  void record(double value) {
    current = value;
    this.progress.add([DateTime.now(), value]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircularProgressIndicator(value: (this.current/this.load), backgroundColor: Colors.grey,),
          title: Text(this.exercise + ' ' + this.load.toString() + ' ' + this.unit + ' by ' + this.date),
        ),
        Divider(
          thickness: 1.5,
        )
      ],
    );
  }
}
