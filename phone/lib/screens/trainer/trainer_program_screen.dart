import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_extend/share_extend.dart';
import 'exercise_card.dart';
import 'program_card.dart';
import 'package:phone/components/paperwork.dart';
import 'package:phone/screens/main/custom_button.dart';
import 'package:phone/components/users.dart';
import 'package:phone/screens/main/dialog.dart';

class TrainerProgramPage extends StatefulWidget {
  final ProgramCard programCard;
  final Trainer trainer;

  TrainerProgramPage({@required this.programCard, @required this.trainer});

  @override
  _TrainerProgramPageState createState() =>
      _TrainerProgramPageState(this.programCard, this.trainer);
}

class _TrainerProgramPageState extends State<TrainerProgramPage> {
  final String rpe = "\n";
  final ProgramCard programCard;
  final Trainer trainer;
  IconButton currentButton;
  List<ExerciseCard> exerciseCards = [];

  _TrainerProgramPageState(this.programCard, this.trainer) {
    for (Exercise exercise in this.programCard.program.exercises) {
      this.exerciseCards.add(ExerciseCard(
            exercise: exercise,
            user: this.trainer,
            onChosen: () {},
          ));
    }

    IconButton firstButton;
    IconButton secondButton;

    firstButton = IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
//          setState(() {
//            this.type = 'Trainer';
//            this.exercises = this.program.getWorkout(this.type);
//            this.currentButton = secondButton;
//          });
        });

    secondButton = IconButton(
        icon: Icon(Icons.check),
        onPressed: () {
//          setState(() {
//            this.type = 'Client';
//            this.exercises = this.program.getWorkout(this.type);
//            this.currentButton = firstButton;
//          });
        });

    currentButton = firstButton;
  }

  void get share async {
    final directory = await getTemporaryDirectory();

    File testFile = new File('${directory.path}/flutter/test.pdf');

    if (!await testFile.exists()) {
      //Write the file to the temporary path first
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
            child: ListBody(children: <Widget>[
              Text(
                  'This concept is used to determine how difficult an exercise is.'),
              Text(''),
              Text(
                  'On a scale of 1-10, 1 being the easiest 10 being the hardest, how difficult was the exercise.')
            ]),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.programCard.program.name),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                ShareExtend.share('Hi', 'bye');
              }),
          this.currentButton
        ],
      ),
      body: ListView(
        children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8.0),
                child: FlatButton(
                    onPressed: rpeDialog,
                    child: Text(
                      'What is RPE?',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    )),
              )
            ] +
            this.programCard.goals +
            this.exerciseCards +
            [
              CustomButton(
                  onTap: () {
                    Exercise exercise = Exercise();
                    this.programCard.program.addExercise(exercise);

                    setState(() {
                      this.exerciseCards.add(ExerciseCard(
                            exercise: exercise,
                            user: this.trainer,
                            onChosen: () {},
                          ));
                    });
                  },
                  label: 'Add an Exercise'),
              SizedBox(
                height: 70.0,
              )
            ],
      ),
    );
  }
}
