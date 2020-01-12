import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phone/screens/main/messages_screen.dart';
import 'package:phone/screens/main/custom_button.dart';
import '../../components/users.dart';
import 'package:phone/screens/main/profile_button.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';

class ClientPage extends StatefulWidget {
  final Client user;

  ClientPage(this.user);

  @override
  _ClientPageState createState() => _ClientPageState(this.user);
}

class _ClientPageState extends State<ClientPage> {
  Client user;
  String search = '';
  int rotations = 0;
  int touchedIndex;
  String goal = 'Be able to do five push-ups';

  _ClientPageState(this.user);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(preferredSize: Size(0, 5), child: SizedBox(),),
          leading: ProfileButton(this.user),
          centerTitle: true,
          title: Text(this.user.firstName,
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.near_me,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MessagePage(this.user)));
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              CircularPercentIndicator(
                radius: 250.0,
                startAngle: 0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: 0.33,
                center: CircularPercentIndicator(
                  radius: 250.0,
                  startAngle: 120,
                  animation: true,
                  animationDuration: 1200,
                  lineWidth: 15.0,
                  percent: 0.33,
                  center: CircularPercentIndicator(
                    radius: 250.0,
                    startAngle: 240,
                    animation: true,
                    animationDuration: 1200,
                    lineWidth: 15.0,
                    percent: 0.33,
                    center: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: (){},
                        child: SizedBox(
                          width: 135,
                            height: 135,
                            child: Center(
                                child: Text(this.goal, textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 25),)),
                        )
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Colors.transparent,
                    progressColor: Colors.red,
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.transparent,
                  progressColor: Colors.green,
                ),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              ),

              Row(
                children: <Widget>[
                  Expanded(child: CustomButton((){}, 'Programs')),
                  Expanded(child: CustomButton((){}, 'Par-Q'))
                ],
              ),
            ],
          ),
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
      ),
    );
  }
}


Future<bool> _onWillPop() async {
  //await showDialog or Show add banners or whatever
  // then
  await SystemNavigator.pop(animated: true);
  return false; // return true if the route to be popped
}
