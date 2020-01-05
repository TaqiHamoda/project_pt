import 'package:flutter/material.dart';
import 'package:phone/screens/main/messages_screen.dart';
import 'package:phone/screens/director/trainer_card.dart';
import 'package:phone/screens/main/profile_edit.dart';
import 'package:phone/screens/main/dialog.dart';
import '../../components/users.dart';
import 'package:flutter/services.dart';

class TrainersPage extends StatefulWidget {

  final Director user;
  TrainersPage(this.user);

  @override
  _TrainersPageState createState() => _TrainersPageState(this.user);
}

class _TrainersPageState extends State<TrainersPage> {

  Director user;
  String search = '';

  _TrainersPageState(this.user);

  List<Widget> filterTrainers(String filterText) {
    if (filterText == '') {
      return this.user.trainerCards();
    }
    List<Widget> filteredTrainers = [];
    for (TrainerCard trainer in this.user.trainerCards()) {
      String trainerName = trainer.name.toLowerCase();
      if (trainerName.contains(filterText.toLowerCase())) {
        filteredTrainers.add(trainer);
      }
    }
    return filteredTrainers;
  }

  void addTrainer(BuildContext context) {
    String firstName;
    String lastName;
    String email;
    String phone;

    SpecialDialog(context, 'Create a trainer', () {
      setState(() {
        this.user.addTrainer(
            Trainer(firstName, lastName, email, 'Bebop', phone));
      });
    }, <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                labelText: 'First Name',
              ),
              onChanged: (value) {
                firstName = value;
              },
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                labelText: 'Last Name',
              ),
              onChanged: (value) {
                lastName = value;
              },
            ),
          ),
        ],
      ),
      TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10.0),
          labelText: 'Email',
        ),
        onChanged: (value) {
          email = value;
        },
      ),
      TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10.0),
          labelText: 'Phone Number',
        ),
        onChanged: (value) {
          phone = value;
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            addTrainer(context);
          },
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset('images/profile.png'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPage(this.user)));
            },
          ),
          centerTitle: true,
          title: Text(
            'Trainers',
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
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10.0),
                  labelText: 'Search by name',
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    this.search = value;
                  });
                },
              ),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              children: this.filterTrainers(this.search),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index){
            if (index == 0){
              Navigator.pop(context);
            }
          },
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