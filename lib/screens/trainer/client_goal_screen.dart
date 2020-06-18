import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';
import 'package:phone/components/paperwork.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:phone/screens/main/graphs.dart';
import 'package:phone/screens/main/dialog.dart';

class GoalPage extends StatefulWidget {
  final Goal goal;
  final Client client;

  GoalPage({@required this.goal, @required this.client});

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  String timeInterval = "Monthly";
  Graph graph;

  void updateGoal() {
    double currentRecord;

    SpecialDialog(
        context: this.context,
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

  @override
  void initState() {
    print(widget.client.unit);
    graph = Graph(timeInterval, widget.client, widget.goal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Center(
            child: IconButton(
              icon: Icon(Icons.refresh, size: 30,),
              onPressed: () {
                updateGoal();
              },
            ),
          ),
          SizedBox(width: 15,),
          Center(
            child: IconButton(
              icon: Icon(Icons.create, size: 30,),
              onPressed: () {},
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
              percent: widget.goal.current <= widget.goal.load ? (widget.goal.current / widget.goal.load) : 1.0,
              progressColor: Colors.blue,
              backgroundColor: Colors.grey,
              lineWidth: 10.0,
              circularStrokeCap: CircularStrokeCap.round,
              center: Container(
                width: 190,
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
                          (100 * (widget.goal.current <= widget.goal.load ? (widget.goal.current / widget.goal.load) : 1.0))
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
                        'l',
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
                            'l',
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Text(
                          'Max: ' +
                              widget.goal.maximum.toString() +
                              ' ' +
                              'l',
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
                    child: graph, //TODO: graph moves up with keyboard
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

                          graph = Graph(timeInterval, widget.client, widget.goal);
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
