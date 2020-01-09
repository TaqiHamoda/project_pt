import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_extend/share_extend.dart';
import 'package:phone/components/paperwork.dart';
import 'package:phone/screens/main/custom_button.dart';
import 'package:phone/screens/main/dialog.dart';


class TrainerProgramPage extends StatefulWidget {
  final Program program;

  TrainerProgramPage(this.program);

  @override
  _TrainerProgramPageState createState() => _TrainerProgramPageState(this.program);
}

class _TrainerProgramPageState extends State<TrainerProgramPage> {
  final Program program;
  final String rpe = "\n";
  IconButton currentButton;
  List<Widget> exercises;
  String type = 'Client';


  _TrainerProgramPageState(this.program){
    this.exercises = this.program.getWorkout('Client');

    IconButton firstButton;
    IconButton secondButton;

    firstButton = IconButton(icon: Icon(Icons.edit),
        onPressed: (){
          setState(() {
            this.type = 'Trainer';
            this.exercises = this.program.getWorkout(this.type);
            this.currentButton = secondButton;
          });
        });

    secondButton = IconButton(icon: Icon(Icons.check),
        onPressed: (){
          setState(() {
            this.type = 'Client';
            this.exercises = this.program.getWorkout(this.type);
            this.currentButton = firstButton;
          });
        });

    currentButton = firstButton;
  }


  void get share async {
    final directory = await getTemporaryDirectory();

    File testFile = new File('${directory.path}/flutter/test.pdf');

    if (!await testFile.exists()) { //Write the file to the temporary path first
      await testFile.create(recursive: true);
      testFile.writeAsStringSync('test for share documents file');
    }

    ShareExtend.share(testFile.path, 'file');
  }

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
        [SizedBox(
          child: TextField(
            controller: TextEditingController(text: this.program.warmup),
            onChanged: (value){ warmup = value; },
            maxLines: 3,
            autofocus: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              labelText: 'Warmup'
            ),
          ),
        )]);
  }


  void addWorkout(BuildContext context) {
    int rows;

    SpecialDialog(context, 'Create a new Exercise',
            (){ setState(() {
              this.program.addExercise(Exercise());
            });},
        [TextField(
            onChanged: (value){ rows = int.parse(value); },
          autofocus: true,
            decoration: InputDecoration(
                labelText: 'Rows',
                contentPadding: EdgeInsets.all(10.0)
            ),
          )
        ]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.program.name),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: (){ ShareExtend.share('Hi', 'bye'); }
          ),
          
          this.currentButton
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
        ] + this.program.goals + this.exercises + [CustomButton((){setState(() {
          this.program.addExercise(Exercise());
          this.exercises = this.program.getWorkout(this.type);
        });}, 'Add an Exercise'), SizedBox(height: 70.0,)],
      ),
    );
  }
}
