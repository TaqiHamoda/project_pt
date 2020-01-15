import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phone/screens/trainer/trainer_program_screen.dart';
import 'dart:core';

class Program{
  List<Exercise> exercises = [];
  String warmup;
  String name;
  List<Goal> goals = [];

  Program({this.name, List<Goal> goals}) {
    this.goals.addAll(goals);
  }

  void addExercise(Exercise exercise) {
    this.exercises.add(exercise);
  }

}

class Exercise {
  String name = '';
  String sets = '';
  String reps = '';
  String rest = '';
  String weight = '';
  String rpe = '';
  String notes = '';
}


class Circuit extends Exercise {
  List<Exercise> exercises = [];

  void addExercise(Exercise exercise){
    exercises.add(exercise);
  }
}

class Goal{
  int load;
  String exercise;
  List<List<dynamic>> progress = [];
  String unit;
  double current;
  double minimum;
  double maximum;
  String date;

  Goal({this.exercise, this.load, this.date, this.unit='lbs', this.current}){
    this.record(this.current);
  }

  void record(double value) {
    this.current = value;
    this.progress.add([DateTime.now(), value]);

    if(this.maximum == null){
      this.maximum = value;
      this.minimum = value;
    }

    else if(value > this.maximum){
      this.maximum = value;
    }

    else if(value < this.minimum){
      this.minimum = value;
    }
  }


}
