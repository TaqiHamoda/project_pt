import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_extend/share_extend.dart';
import 'package:phone/components/paperwork.dart';
import 'package:phone/screens/main/dialog.dart';


class TrainerProgramPage extends StatefulWidget {
  final Program program;

  TrainerProgramPage(this.program);

  @override
  _TrainerProgramPageState createState() => _TrainerProgramPageState(this.program);
}

class _TrainerProgramPageState extends State<TrainerProgramPage> {
  Program program;
  final String rpe = "\n";


  _TrainerProgramPageState(this.program);


  void get share async {
    final directory = await getTemporaryDirectory();

    File testFile = new File('${directory.path}/flutter/test.pdf');

    if (!await testFile.exists()) { //Write the file to the temporary path first
      await testFile.create(recursive: true);
      testFile.writeAsStringSync('test for share documents file');
    }

    ShareExtend.share(testFile.path, 'file');
  }


  void delete(){}


  Future<void> rpeDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('RPE (Rate of Percieved Exertion)'),
          content: SingleChildScrollView(
            child: ListBody(
                children: <Widget>[
                  Text('This concept is used to determine how difficult an exercise is.'),
                  Text(''),
                  Text('On a scale of 1-10, 1 being the easiest 10 being the hardest, how difficult was the exercise.')
                ]
            ),
          ),

          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Future<void> warmupDialog() async {
    String warmup;

    SpecialDialog(context, 'Create Warmup',
            (){ this.program.warmup = warmup;
            print(this.program.warmup);},
        [TextField(
          onChanged: (value){ warmup = value; },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            labelText: 'Warmup'
          ),
        )]);
  }


  void addWorkout(BuildContext context) {
    int rows;
    String name;

    SpecialDialog(context, 'Create a Workout',
            (){ setState(() {
              this.program.addWorkout(Workout(name, rows));
            });},
        [TextField(
          onChanged: (value){ name = value; },
          decoration: InputDecoration(
            labelText: 'Workout Name',
            contentPadding: EdgeInsets.all(10.0),
          ),
        ),

          TextField(
            onChanged: (value){ rows = int.parse(value); },
            decoration: InputDecoration(
                labelText: 'Rows',
                contentPadding: EdgeInsets.all(10.0)
            ),
          )
        ]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){ this.addWorkout(context); },
    ),

      appBar: AppBar(
        title: Text(this.program.name),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: (){ ShareExtend.share('Hi', 'bye'); }
          ),

          PopupMenuButton<Choices>(
            onSelected: (Choices result) { setState(() { this.delete(); }); },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choices>>[
              PopupMenuItem<Choices>(
                value: Choices.delete,
                child: Text('Delete'),
              ),
            ],
          )
        ],
      ),

      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                    child: FlatButton(
                        onPressed: rpeDialog,
                        child: Text('What is RPE?',
                          style: TextStyle(fontSize: 20.0,
                              color: Colors.blue),
                        ),
                    ),
                ),
              ),

              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  child: FlatButton(
                    onPressed: warmupDialog,
                    child: Text('Warm-up',
                      style: TextStyle(fontSize: 20.0,
                          color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ] + this.program.goals + this.program.workouts,
      ),
    );
  }
}


enum Choices{delete}
