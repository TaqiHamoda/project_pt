import 'package:flutter/material.dart';
import 'package:phone/screens/main/messages_screen.dart';
import 'package:phone/screens/main/custom_button.dart';
import 'package:phone/screens/trainer/goal_card.dart';
import '../../components/users.dart';
import 'package:phone/screens/main/profile_button.dart';
import 'package:flutter/services.dart';
import 'package:phone/screens/main/graphs.dart';
import 'package:phone/components/paperwork.dart';
import 'goal_card.dart';

class ClientPage extends StatefulWidget {
  final Client client;

  ClientPage({@required this.client});

  @override
  _ClientPageState createState() => _ClientPageState(this.client);
}

class _ClientPageState extends State<ClientPage> {
  Client client;
  String search = '';
  String timeInterval = 'Monthly';
  String whichGoal = 'Goal 1';
  Goal currGoal;
  List<GoalCard> goalCards = [];

  _ClientPageState(this.client){
    for(Goal goal in this.client.goals){
      this.goalCards.add(GoalCard(goal: goal));
    }
    
    this.currGoal = this.client.goals[1];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(preferredSize: Size(0, 5), child: SizedBox(),),
          leading: ProfileButton(this.client),
          centerTitle: true,
          title: Text(this.client.firstName,
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
                        builder: (context) => MessagePage(this.client)));
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[SizedBox(height: 10,)] + this.goalCards + <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: CustomButton(onTap: (){}, label: 'Programs')),
                  Expanded(child: CustomButton(onTap: (){}, label: 'Par-Q'))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      setState(() {
                        if(timeInterval == 'Monthly'){
                          timeInterval = '3 Month';
                        }
                        else if(timeInterval == '3 Month'){
                          timeInterval = 'Yearly';
                        }
                        else{
                          timeInterval = 'Monthly';
                        }

                      });
                    },
                    child: Text(
                      this.timeInterval,
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      setState(() { // can prob be cleaned up but allow it for now
                        if(whichGoal == 'Goal 1'){
                          this.currGoal = this.client.goals[1]; // index 1 for testing purposes
                          whichGoal = 'Goal 2';
                        }
                        else if(whichGoal == 'Goal 2'){
                          this.currGoal = this.client.goals[1];
                          whichGoal = 'Goal 3';
                        }
                        else{
                          this.currGoal = this.client.goals[1];
                          whichGoal = 'Goal 1';
                        }
                      });
                    },
                    child: Text(
                      whichGoal,
                    ),
                  ),
                ],
              ),
              Expanded(child: Graph(this.timeInterval, this.client, this.currGoal)),
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
