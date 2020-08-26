import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';
import 'package:phone/components/paperwork.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:phone/screens/main/graphs.dart';
import 'package:phone/screens/main/dialog.dart';
import 'package:phone/screens/trainer/client_details_screen.dart';
import 'package:phone/screens/trainer/client_screen.dart';

class GoalPage extends StatefulWidget {
  final Goal goal;
  final Client client;
  final bool userIsClient;

  GoalPage(
      {@required this.goal,
      @required this.client,
      @required this.userIsClient});

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  String selectedUnit;
  String exerciseName;
  int targetValue;
  String date;
  double currentRecord;

  String timeInterval = "Monthly";
  Graph graph;

  void updateGoal() {
    double currentRecord;

    SpecialDialog(
        context: context,
        title: 'Update Goal',
        onSubmit: () {
          setState(() {
            widget.goal.current = currentRecord;

            if (currentRecord < widget.goal.minimum) {
              widget.goal.minimum = currentRecord;
            }

            if (currentRecord > widget.goal.maximum) {
              widget.goal.maximum = currentRecord;
            }

            double nextMonth = graph.getLastMonth(widget.goal) + 1;
            graph.addSpot(nextMonth, currentRecord);
            graph = Graph(timeInterval, widget.client, widget.goal);
          });
        },
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10.0),
              labelText: 'New Record',
            ),
            onChanged: (value) {
              currentRecord = double.parse(value);
            },
          ),
        ]);
  }

  void changeGoal() {
    SpecialDialog(
        context: context,
        title: 'Change Goal',
        onSubmit: () {
          setState(() {
            Goal goal = Goal(
                exercise: exerciseName,
                date: date,
                load: targetValue,
                current: currentRecord,
                unit: selectedUnit);

            int index = widget.client.goals.indexOf(widget.goal);
            widget.client.goals[index] = goal;

            Navigator.pop(context);

            if (widget.userIsClient) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClientPage(
                            client: widget.client,
                          )));
            } else {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClientDetails(
                          client: widget.client,
                          trainer: widget.client.trainer,
                          name: widget.client.firstName +
                              ' ' +
                              widget.client.lastName,
                          delete: () {
                            setState(() {
                              widget.client.trainer.clients
                                  .remove(widget.client);
                            });
                          })));
            }
          });
        },

        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10.0),
              labelText: 'Exercise/Action (e.g. Bench Press, Run, Lose, etc.)',
            ),
            onChanged: (value) {
              exerciseName = value;
            },
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.0),
                    labelText: 'Target Value',
                  ),
                  onChanged: (value) {
                    targetValue = int.parse(value);
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              DropdownButton<String>(
                hint: selectedUnit == null ? Text('Unit') : Text(selectedUnit),
                items: <String>[
                  'lbs',
                  'kgs',
                  'sec',
                  'min',
                  'hr',
                  'miles',
                  'km',
                  'm',
                  'ft',
                  'other'
                ].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    if (newValue == 'other') {
                      addNewUnit();
                    } else {
                      selectedUnit = newValue;
                      Navigator.pop(context);
                      changeGoal();
                    }
                  });
                },
                underline: Container(),
              ),
            ],
          ),
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10.0),
              labelText: 'Deadline (Month Year)',
            ),
            onChanged: (value) {
              date = value;
            },
          ),
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10.0),
              labelText: 'Current Record',
            ),
            onChanged: (value) {
              currentRecord = double.parse(value);
            },
          ),
        ]);
  }

  void addNewUnit() {
    String newUnit;

    SpecialDialog(
      context: context,
      title: 'Input unit',
      onSubmit: () {
        setState(() {
          selectedUnit = newUnit;
          Navigator.pop(context);
          changeGoal();
        });
      },
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.0),
            labelText: 'Unit (e.g. stones, weeks, pushups, etc.)',
          ),
          onChanged: (value) {
            newUnit = value;
          },
        ),
      ],
    );
  }

  void editGoal() {
    int newTarget;

    SpecialDialog(
      context: context,
      title: 'Edit Goal',
      onSubmit: () {
        setState(() {
          widget.goal.load = newTarget;
        });
      },
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.0),
            labelText: 'New Target',
          ),
          onChanged: (value) {
            newTarget = int.parse(value);
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    graph = Graph(timeInterval, widget.client, widget.goal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              items: <String>['Change Goal', 'Update Goal', 'Edit Goal']
                  .map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              underline: Container(),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == 'Update Goal') {
                    updateGoal();
                  } else if (newValue == 'Change Goal') {
                    changeGoal();
                  } else if (newValue == 'Edit Goal') {
                    editGoal();
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 5),
            alignment: Alignment(0, 0),
            child: CircularPercentIndicator(
              radius: 200,
              percent: widget.goal.current <= widget.goal.load
                  ? (widget.goal.current / widget.goal.load)
                  : 1.0,
              progressColor: Colors.blue,
              backgroundColor: Colors.grey,
              lineWidth: 10.0,
              circularStrokeCap: CircularStrokeCap.round,
              center: Container(
                width: 178,
                child: Text(
                  widget.goal.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Divider(
                  thickness: 2.5,
                  height: 7,
                ),
                ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.done,
                      color: Colors.black,
                      size: 32,
                    ),
                    title: Text(
                      'Percentage Done: ' +
                          (100 *
                                  (widget.goal.current <= widget.goal.load
                                      ? (widget.goal.current / widget.goal.load)
                                      : 1.0))
                              .toStringAsFixed(1) +
                          ' %',
                      style: TextStyle(fontSize: 18),
                    )),
                Divider(
                  thickness: 2.5,
                  height: 7,
                ),
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.access_time,
                    color: Colors.black,
                    size: 32,
                  ),
                  title: Text(
                    'Current: ' +
                        widget.goal.current.toString() +
                        ' ' +
                        widget.goal.unit,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Divider(
                  thickness: 2.5,
                  height: 7,
                ),
                ListTile(
                  leading: Icon(
                    Icons.timeline,
                    color: Colors.black,
                    size: 32,
                  ),
                  dense: true,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Min: ' +
                            widget.goal.minimum.toString() +
                            ' ' +
                            widget.goal.unit,
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Text(
                          'Max: ' +
                              widget.goal.maximum.toString() +
                              ' ' +
                              widget.goal.unit,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2.5,
                  height: 7,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 23,
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 355,
                    child: graph,
                  ),
                ),
                Container(
                    alignment: Alignment(0.97, -1.15),
                    child: RawMaterialButton(
                      onPressed: () {
                        setState(() {
                          if (timeInterval == 'Monthly') {
                            timeInterval = '3 Month';
                          } else if (timeInterval == '3 Month') {
                            timeInterval = 'Yearly';
                          } else {
                            timeInterval = 'Monthly';
                          }

                          graph =
                              Graph(timeInterval, widget.client, widget.goal);
                        });
                      },
                      elevation: 5.0,
                      fillColor: Colors.lightBlueAccent,
                      child: Icon(
                        Icons.swap_horiz,
                        size: 20.0,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    )),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('Schedule'),
            icon: Icon(
              Icons.calendar_today,
            ),
          ),
        ],
      ),
    );
  }
}
