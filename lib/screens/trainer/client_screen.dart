import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phone/screens/main/messages_screen.dart';
import '../../components/users.dart';
import 'package:phone/screens/main/profile_button.dart';
import 'package:phone/screens/trainer/program_card.dart';
import 'package:flutter/services.dart';
import 'package:phone/screens/trainer/goal_card.dart';
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
  List<GoalCard> goalCards = [];
  List<ProgramCard> programCards = [];

  _ClientPageState(this.client){
    for(Goal goal in this.client.goals){
      this.goalCards.add(GoalCard(goal: goal, client: client),);
    }

    for (Program program in this.client.programs) {
      this.programCards.add(ProgramCard(
        program: program,
        user: this.client,
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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(preferredSize: Size(0, 5), child: SizedBox(),),
          leading: ProfileButton(user: this.client),
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
            children: <Widget>[SizedBox(height: 10,)] + this.goalCards + this.programCards
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
