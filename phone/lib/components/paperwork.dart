import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone/components/goals.dart';
import 'package:phone/screens/trainer/program_screen.dart';


class Program extends StatefulWidget {
  List<Workout> workouts = [];
  String warmup;
  String name;
  List<Goal> goals = [];
  
  Program(this.name, List<Goal> goals){
    this.goals.addAll(goals);
  }
  
  void addWorkout(Workout workout){
    this.workouts.add(workout);
  }

  void createWarmup(String warmup){
    this.warmup = warmup;
  }

  void changeName(String name){
    this.name = name;
  }
  
  @override
  _ProgramState createState() => _ProgramState(this);
}


class _ProgramState extends State<Program> {
  Program program;


  _ProgramState(this.program);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.table_chart),
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProgramPage(this.program)));
        },

        title: Text(this.program.name, textAlign: TextAlign.left,)
    );
  }
}


class Workout extends StatefulWidget {
  int rows;
  String name;

  Workout(this.rows, this.name);

  @override
  _WorkoutState createState() => _WorkoutState(this.rows, this.name);
}

class _WorkoutState extends State<Workout> {
  List<DataRow> rowsData = [];
  String name;

  _WorkoutState(int rows, name) {
    this.name = name;

    List<DataCell> cells = [];

    for (int row = 0; row < rows; row++) {
      cells.clear();

      for (int i = 0; i < 6; i++) {
        cells.add(DataCell(Text('')));
      }

      this.rowsData.add(DataRow(cells: cells));
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.only(bottom: 25.0, left: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(this.name, textAlign: TextAlign.left,),

            DataTable(
              columns: [
                DataColumn(label: Text('Exercise')),
                DataColumn(label: Text('Reps')),
                DataColumn(label: Text('Sets')),
                DataColumn(label: Text('Rest (Mins)')),
                DataColumn(label: Text('RPE')),
                DataColumn(label: Text('Notes'))
              ],

              rows: this.rowsData,
            )
          ],
        ),
      ),
    );
  }
}


