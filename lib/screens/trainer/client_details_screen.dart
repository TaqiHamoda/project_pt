import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../main/messaging_screen.dart';
import 'program_card.dart';
import 'goal_card.dart';
import 'package:phone/components/users.dart';
import 'package:phone/screens/main/custom_button.dart';
import 'package:phone/screens/main/dialog.dart';
import 'package:phone/components/paperwork.dart';
import 'package:phone/screens/main/pressable_info.dart';

class ClientDetails extends StatefulWidget {
  final Client client;
  final String name;
  final Trainer trainer;
  final Function delete;

  ClientDetails(
      {@required this.client,
      @required this.trainer,
      @required this.name,
      @required this.delete});

  @override
  _ClientDetails createState() =>
      _ClientDetails(this.client, this.name, this.trainer);
}

class _ClientDetails extends State<ClientDetails> {
  final Trainer trainer;
  final String name;
  final Client client;
  List<ProgramCard> programCards = [];
  List<GoalCard> goalCards = [];

  _ClientDetails(this.client, this.name, this.trainer) {
    for (Program program in this.client.programs) {
      this.programCards.add(ProgramCard(
            program: program,
            user: this.trainer,
            delete: () {
              this.client.programs.remove(program);

              for (ProgramCard programCard in this.programCards) {
                if (programCard.program == program) {
                  setState(() {
                    this.programCards.remove(programCard);
                  });
                  break;
                }
              }
            },
          ));
    }

    for (Goal goal in this.client.goals) {
      this.goalCards.add(GoalCard(goal: goal, client: this.client, userIsClient: false,));
    }
  }

  void addProgram() {
    String programName = '';

    SpecialDialog(
      context: context,
        title: 'Create a new workout',
        onSubmit: () {
          Program program = Program(
            name: programName,
            goals: this.client.goals,
          );

          this.client.addProgram(program);

          setState(() {
            this.programCards.add(
                  ProgramCard(
                    program: program,
                    user: this.trainer,
                    delete: () {
                      this.client.programs.remove(program);

                      for (ProgramCard programCard in this.programCards) {
                        if (programCard.program == program) {
                          setState(() {
                            this.programCards.remove(programCard);
                          });
                          break;
                        }
                      }
                    },
                  ),
                );
          });
        },
        children: <Widget>[
          TextField(
            autofocus: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10.0),
              labelText: 'Program Name',
            ),
            onChanged: (value) {
              programName = value;
            },
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.near_me), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MessagePage(
              receiver: client,
            )));
          }),
          PopupMenuButton<Choices>(
            onSelected: (Choices result) {
              Navigator.of(context).pop();
              widget.delete();
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choices>>[
              PopupMenuItem<Choices>(
                value: Choices.delete,
                child: Text('Delete ' + this.client.firstName),
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
                        margin: EdgeInsets.only(top: 5.0, left: 5.0),
                        child: CircleAvatar(
                          backgroundImage: this.client.photo,
                          radius: 65,
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 2.0, left: 5.0),
                          child: Text(
                            this.client.firstName + " " + this.client.lastName,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment(-1, 0),
                        ),
                        PressableInfo(
                            label: 'Email: ',
                            info: this.client.email,
                            ext: 'mailto:'),
                        PressableInfo(
                            label: 'Phone Number: ',
                            info: this.client.phoneNum,
                            ext: 'tel:'),
                        PressableInfo(
                            label: 'Sessions Remaining: ' +
                                this.client.sessions.toString(),
                            info: '',
                            ext: '')
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(child: CustomButton(onTap: () {}, label: 'Par-Q')),
                  Expanded(
                      child: CustomButton(onTap: () {}, label: 'Assessment'))
                ],
              )
            ] +
            this.goalCards +
            this.programCards +
            [
              CustomButton(
                  onTap: () {
                    this.addProgram();
                  },
                  label: 'Create Program')
            ],
      ),
    );
  }
}

enum Choices { delete }
