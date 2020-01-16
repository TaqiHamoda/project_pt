import 'package:flutter/material.dart';
import 'package:phone/components/paperwork.dart';
import 'package:phone/components/users.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final Function onChosen;
  final User user;
  bool _chosen = false;

  ExerciseCard({@required this.exercise, this.onChosen, @required this.user});

  bool get chosen{
    return this._chosen;
  }

  @override
  Widget build(BuildContext context) {
    IconButton selectIcon = IconButton(
      icon: Icon(Icons.trip_origin, color: this._chosen ? Colors.green : null,),
      onPressed: (){
      this._chosen = !this._chosen;
      this.onChosen();
      },);

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
                    child: Container(child: TextFormField(
                      validator: (String value){}, //TODO: Implement the validator
                      onChanged: (value){ this.exercise.name = value; },
                      initialValue: this.exercise.name,
                      enabled: this.user is Trainer,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: this.user is Trainer ? 'Exercise Name' : null,
                          suffixIcon: this.user is Trainer ? selectIcon : null),
                    ), alignment: Alignment(0, -1),)
                ),
              ],),
            ),

            Row(children: <Widget>[
              Expanded(
                child: Column(children: <Widget>[
                  Text('Sets'),

                  TextFormField(
                    validator: (String value){}, //TODO: Implement the validator
                    onChanged: (value){ this.exercise.sets = value; },
                    initialValue: this.exercise.sets,
                    enabled: this.user is Trainer,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              ),

              Expanded(
                child: Column(children: <Widget>[
                  Text('Reps'),

                  TextFormField(
                    validator: (String value){}, //TODO: Implement the validator
                    onChanged: (value){ this.exercise.reps = value; },
                    initialValue: this.exercise.reps,
                    enabled: this.user is Trainer,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              ),

              Expanded(
                child: Column(children: <Widget>[
                  Text('Weight'),

                  TextFormField(
                    validator: (String value){}, //TODO: Implement the validator
                    onChanged: (value){ this.exercise.weight = value; },
                    initialValue: this.exercise.weight,
                    enabled: this.user is Trainer,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              ),

              Expanded(
                child: Column(children: <Widget>[
                  Text('Rest (Min)'),

                  TextFormField(
                    validator: (String value){}, //TODO: Implement the validator
                    onChanged: (value){ this.exercise.rest = value; },
                    initialValue: this.exercise.rest,
                    enabled: this.user is Trainer,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              ),

              Expanded(
                child: Column(children: <Widget>[
                  Text('RPE'),

                  TextFormField(
                    validator: (String value){}, //TODO: Implement the validator
                    onChanged: (value){ this.exercise.rpe = value; },
                    initialValue: this.exercise.rpe,
                    enabled: this.user is Trainer,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
                  )
                ],),
              )
            ],),

            Container(
                margin: EdgeInsets.only(top: 20),
                child: TextFormField(
                  validator: (String value){}, //TODO: Implement the validator
                  onChanged: (value){ this.exercise.notes = value; },
                  enabled: this.user is Trainer,
                  maxLines: 3,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      labelText: this.user is Trainer ? 'Notes' : null),
                  initialValue: this.exercise.notes,
                ),
                )
            ]),
      ),
    );
  }
}


class CircuitCard extends ExerciseCard {
  final Circuit circuit;
  final List<Widget> exerciseCards = [];
  final User user;
  int color = 0;

  CircuitCard({@required this.circuit, @required this.user}){
    for(Exercise exercise in circuit.exercises){

      this.exerciseCards.add(Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(5.0),
        child: ExerciseCard(exercise: exercise, user: this.user),
        color: (this.color/2) == 0 ? Colors.grey[700] : Colors.grey[500],
      ));

      this.color += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: this.exerciseCards,
    );
  }
}

