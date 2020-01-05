import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_extend/share_extend.dart';
import 'package:phone/components/paperwork.dart';


class ProgramPage extends StatefulWidget {
  final Program program;

  ProgramPage(this.program);

  @override
  _ProgramPageState createState() => _ProgramPageState(this.program);
}

class _ProgramPageState extends State<ProgramPage> {
  Program program;
  final String rpe = "\n";

  _ProgramPageState(this.program);

  void get share async {
    final directory = await getTemporaryDirectory();

    File testFile = new File('${directory.path}/flutter/test.pdf');

    if (!await testFile.exists()) {
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

  void addWorkout(BuildContext context) {
    int rows;
    String name;

    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: const Text('Create a new workout'),
          children: <Widget>[

            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                labelText: 'Rows',
              ),

              onChanged: (value){ rows = int.parse(value); },
            ),

            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                labelText: 'Workout Name',
              ),

              onChanged: (value){ name = value; },
            ),


            Row(children: <Widget>[
              Container(
                alignment: Alignment(-1.0, 0.0),
                child: FlatButton(
                  child: new Text('Ok',
                    style: TextStyle(color: Colors.blue),),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      this.program.addWorkout(Workout(rows, name));
                    });
                  },
                ),
              ),

              Container(
                alignment: Alignment(1.0, 0.0),
                child: FlatButton(
                  child: new Text('Cancel',
                    style: TextStyle(color: Colors.blue),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ])
          ],
        );
      },
    );
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
                    onPressed: (){},
                    child: Text('Warm-up',
                      style: TextStyle(fontSize: 20.0,
                          color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          )
        ] + this.program.workouts,
      ),
    );
  }
}


enum Choices{delete}
