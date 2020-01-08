import 'package:flutter/material.dart';
import 'package:phone/screens/main/messages_screen.dart';
import 'package:phone/screens/trainer/client_card.dart';
import 'package:phone/screens/main/profile_edit.dart';
import 'package:phone/screens/main/custom_button.dart';
import 'typical_screen.dart';
import 'package:phone/screens/main/dialog.dart';
import 'package:phone/components/users.dart';
import 'package:flutter/services.dart';

class DirectorPage extends StatefulWidget {
  final Director user;

  DirectorPage(this.user);

  @override
  _DirectorPageState createState() => _DirectorPageState(this.user);
}

class _DirectorPageState extends State<DirectorPage> {
  Director user;
  String search = '';

  _DirectorPageState(this.user);

  List<Widget> filterClients(String filterText) {
    if (filterText == '') {
      return this.user.myClientCards();
    }
    List<Widget> filteredClients = [];
    for (ClientCard client in this.user.myClientCards()) {
      String clientName = client.name.toLowerCase();
      if (clientName.contains(filterText.toLowerCase())) {
        filteredClients.add(client);
      }
    }
    return filteredClients;
  }

  void addClient(BuildContext context) {
    String firstName;
    String lastName;
    String email;
    String phone;

    SpecialDialog(context, 'Create a client', () {
      setState(() {
        this.user.addClient(
            Client(firstName, lastName, email, 'Bebop', phone));
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
            addClient(context);
          },
        ),
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(0, 55),
            child: Container(
              margin: EdgeInsets.only(top: 5.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  contentPadding: EdgeInsets.only(left: 10.0),
                  labelText: 'Search by name',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                onChanged: (value){setState(() {
                  this.search = value;
                });},
              ),
            ),
          ),
          leading: Container(
            margin: EdgeInsets.only(left: 5.0, top: 5.0),
            child: InkWell(
              child: CircleAvatar(backgroundImage: this.user.photo,),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage(this.user)));
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            'Director ' + this.user.firstName,
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
            Row(
              children: <Widget>[
                Expanded(child: CustomButton((){Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserPage(this.user, 'Director', this.user.directorCards())));
                }, 'Directors')),

                Expanded(child: CustomButton((){Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserPage(this.user, 'Trainer', this.user.trainerCards())));
                }, 'Trainers')),

                Expanded(child: CustomButton((){Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserPage(this.user, 'Client', this.user.otherClientCards())));
                }, 'Other Clients'))

              ],
            ),

            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              children: this.filterClients(this.search),
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
            BottomNavigationBarItem(icon: Icon(Icons.insert_chart),
            title: Text('Analytics'))
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
