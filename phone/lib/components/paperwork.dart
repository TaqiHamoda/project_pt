import 'package:flutter/material.dart';
import 'package:phone/components/goals.dart';


class Program {
  List<Workout> workouts = [];
  String warmup;
  String name;
  List<Goal> goals = [];
  final String rpe = "Rate of percieved exertion. This concept is used to "
      + "determine how difficult an exercise is. On a scale of 1-10, 1 being "
      + "the easiest 10 being the hardest, how difficult was the exercise.";

  Program(this.name, this.warmup, List<Goal> goals){
    for(Goal goal in goals){
      this.goals.add(goal);
    }
  }

  void addWorkout(Workout workout){
    this.workouts.add(workout);
  }

}



class Workout extends StatefulWidget {
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


