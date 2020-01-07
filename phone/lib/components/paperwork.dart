import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phone/screens/trainer/trainer_program_screen.dart';


class Program extends StatelessWidget {
  List<Workout> workouts = [];
  String warmup;
  String name;
  List<Goal> goals = [];
  
  Program(this.name, List<Goal> goals){
    this.goals.addAll(goals);
  }

  List<Widget> getWorkout(String user){
    List<Widget> workoutWidgets = [];

    if(user == 'Trainer'){

      for(Workout workout in this.workouts){
        workoutWidgets.add(workout.trainer());
      }

    } else{

      for(Workout workout in this.workouts){
        workoutWidgets.add(workout.client());
      }

    }

    return workoutWidgets;
  }
  
  void addWorkout(Workout workout){
    this.workouts.add(workout);
  }

  void changeAccess(bool access){
    for(Workout workout in this.workouts){
      workout.edit = access;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.table_chart),
        trailing: IconButton(
          onPressed: (){},
          icon: Icon(Icons.delete, color: Colors.red,),
        ),
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TrainerProgramPage(this)));
        },

        title: Text(this.name, textAlign: TextAlign.left,)
    );
  }
}


class Workout{
  List<List<String>> datas = [];
  int rows;
  bool edit = true;
  String name;

  Workout(this.rows){
    for (int row = 0; row < this.rows; row++) {
      List<String> data = [];

      for (int i = 0; i < 6; i++) {
        data.add('');
      }
    }
  }


  Widget client(){
    List<DataRow> rowsData = [];
    List<DataCell> cells = [];
    DataRow rowData = DataRow(cells: cells);

    for (int row = 0; row < this.rows; row++) {
      for (int i = 0; i < 6; i++) {
        cells.add(DataCell(Text(this.datas[row][i])));
      }

      rowsData.add(rowData);
      cells = [];
      rowData = DataRow(cells: cells);
    }

    return Container(
      margin: EdgeInsets.only(top: 25.0, bottom: 25.0, left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 25.0),
              child: Text(this.name, style: TextStyle(fontSize: 20.0))
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Exercise')),
                DataColumn(label: Text('Reps')),
                DataColumn(label: Text('Sets')),
                DataColumn(label: Text('Rest (Mins)')),
                DataColumn(label: Text('RPE')),
                DataColumn(label: Text('Notes'))
              ],

              rows: rowsData,
            ),
          )
        ],
      ),
    );
  }


  Widget trainer(){
    List<DataRow> rowsData = [];
    List<DataCell> cells = [];
    DataRow rowData = DataRow(cells: cells);

    for (int row = 0; row < this.rows; row++) {
      for (int i = 0; i < 6; i++) {
        cells.add(DataCell(TextField(onChanged: (value){ this.datas[row][i] = value; },)));
      }

      rowsData.add(rowData);
      cells = [];
      rowData = DataRow(cells: cells);
    }

    return Container(
      margin: EdgeInsets.only(top: 25.0, bottom: 25.0, left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 25.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Workout Title',
                  labelStyle: TextStyle(fontSize: 20)),
                style: TextStyle(fontSize: 20),
                onChanged: (value){ this.name = value; },)
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Exercise')),
                DataColumn(label: Text('Reps')),
                DataColumn(label: Text('Sets')),
                DataColumn(label: Text('Rest (Mins)')),
                DataColumn(label: Text('RPE')),
                DataColumn(label: Text('Notes'))
              ],

              rows: rowsData,
            ),
          )
        ],
      ),
    );
  }

}


class Goal extends StatelessWidget {
  String goal;
  bool reached = false;

  Goal(this.goal);

  void reachedGoal(){
    this.reached = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.trip_origin,
            color: reached ? Colors.green : null,),
          title: Text('Goal: ' + this.goal),
        ),
        Divider(thickness: 1.5,)
      ],
    );
  }
}
