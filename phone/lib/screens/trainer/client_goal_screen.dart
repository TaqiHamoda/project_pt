import 'package:flutter/material.dart';
import 'package:phone/components/paperwork.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GoalPage extends StatefulWidget {
  final Goal goal;

  GoalPage({@required this.goal});

  @override
  _GoalPageState createState() => _GoalPageState(this.goal);
}

class _GoalPageState extends State<GoalPage> {
  final Goal goal;

  _GoalPageState(this.goal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
              onPressed: (){},
              child: Text('Change Goal',
                style: TextStyle(color: Colors.white, fontSize: 17),))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        label: Text('Update Goal'),
        icon: Icon(Icons.golf_course,),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment(0, 0),
            child: CircularPercentIndicator(
              radius: 300,
              percent: (this.goal.current/this.goal.load),
              progressColor: Colors.blue,
              backgroundColor: Colors.grey,
              lineWidth: 10.0,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                this.goal.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35, fontWeight: FontWeight.w300),),
            ),
          ),

          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text('Current: ' + this.goal.current.toString() + ' ' + this.goal.unit,
                          style: TextStyle(fontSize: 17),)),
                    Expanded(
                        child: Text('Percentage Done: ' + (100 * (this.goal.current/this.goal.load)).toString().substring(0, 4) + ' %',
                        style: TextStyle(fontSize: 17),)),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text('Maximum: ' + this.goal.maximum.toString() + ' ' + this.goal.unit)),
                    Expanded(child: Text('Minimum: ' + this.goal.minimum.toString() + ' ' + this.goal.unit)),
                  ],
                ),
              ),

            ],
          )
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

