import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_extend/share_extend.dart';
import 'exercise_card.dart';
import 'program_card.dart';
import 'package:phone/components/paperwork.dart';
import 'package:phone/screens/main/custom_button.dart';
import 'package:phone/components/users.dart';

class TrainerProgramPage extends StatefulWidget {
  final ProgramCard programCard;
  final User user;

  TrainerProgramPage({@required this.programCard, @required this.user});

  @override
  _TrainerProgramPageState createState() => _TrainerProgramPageState();
}

class _TrainerProgramPageState extends State<TrainerProgramPage> {
  final String rpe = "\n";
  Widget circuitButton = SizedBox();
  Map<Key, Widget> exerciseCards;

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
  void initState() {
    exerciseCards = {};

    for (Exercise exercise in widget.programCard.program.exercises) {
      Key key = UniqueKey();

      exerciseCards[key] = widget.user is Trainer ? Dismissible(
        key: key,
        child: ExerciseCard(
          exercise: exercise,
          user: widget.user,
        ),
        background: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Card(
            color: Colors.red.withOpacity(0.8),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60.0),
                child: Icon(
                  Icons.delete,
                  size: 45,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        onDismissed: (DismissDirection direction) {
          setState(() {
            if (this.mounted) {
              widget.programCard.program.exercises.remove(exercise);
              exerciseCards.remove(key);
            }
          });
        },
      ) : ExerciseCard(
        exercise: exercise,
        user: widget.user,
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.programCard.program.name),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                ShareExtend.share('Hi', 'bye');
              }),
          this.circuitButton
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
            exerciseCards.values.toList() +
            [widget.user is Trainer ?
              CustomButton(
                  onTap: () {
                    Exercise exercise = Exercise();

                    setState(() {
                      widget.programCard.program.addExercise(exercise);
                    });

                    Key key = UniqueKey();

                    Widget newCard = Dismissible(
                      key: key,
                      child: ExerciseCard(
                        exercise: exercise,
                        user: widget.user,
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Card(
                          color: Colors.red.withOpacity(0.8),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 60.0),
                              child: Icon(
                                Icons.delete,
                                size: 45,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          if (this.mounted) {
                            widget.programCard.program.exercises
                                .remove(exercise);
                            exerciseCards.remove(key);
                          }
                        });
                      },
                    );

                    setState(() {
                      exerciseCards[key] = newCard;
                    });
                  },
                  label: 'Add an Exercise') : Container(),
              SizedBox(
                height: 70.0,
              ),
            ],
      ),
    );
  }
}
