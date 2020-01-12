import 'package:flutter/material.dart';
import 'package:phone/screens/main/messages_screen.dart';
import 'package:phone/screens/trainer/client_card.dart';
import 'package:phone/screens/main/profile_edit.dart';
import 'package:phone/screens/main/custom_button.dart';
import 'typical_screen.dart';
import 'package:phone/screens/main/dialog.dart';
import 'package:phone/components/users.dart';
import 'package:flutter/services.dart';
import 'package:phone/screens/main/profile_button.dart';


class DirectorPage extends StatefulWidget {
  final Director user;

  DirectorPage(this.user);

  @override
  _DirectorPageState createState() => _DirectorPageState(this.user);
}

class _DirectorPageState extends State<DirectorPage> {
  Director user;
  String search = '';
  String dropdownValue = 'Sort by';


  _DirectorPageState(this.user);

  List<Widget> filterClients(String filterText, String dropValue) {

      List<ClientCard> filteredClients = [];
      if(dropValue == 'Sort by' || dropValue == 'Most Recent'){
        if(filterText == ''){
          return this.user.myClientCards().reversed.toList();
        }
      for (ClientCard client in this.user.myClientCards()) {
        String clientName = client.name.toLowerCase();
        if (clientName.contains(filterText.toLowerCase())) {
          filteredClients.add(client);
        }
      }
      return filteredClients.reversed.toList();

      }
      else if(dropValue == 'First Name (A-Z)'){
        Comparator<ClientCard> firstNameComparator = (a, b) => a.name.split(' ')[0].compareTo(b.name.split(' ')[0]);
        if(filterText == ''){
          filteredClients = this.user.myClientCards();
          filteredClients.sort(firstNameComparator);
          return filteredClients;
        }

        for (ClientCard client in this.user.myClientCards()) {
          String clientName = client.name.toLowerCase();
          if (clientName.contains(filterText.toLowerCase())) {
            filteredClients.add(client);
          }
        }
        filteredClients.sort(firstNameComparator);
        return filteredClients;

      }

      else if(dropValue == 'Last Name (A-Z)'){
        Comparator<ClientCard> lastNameComparator = (a, b) => a.name.split(' ')[1].compareTo(b.name.split(' ')[1]);
        if(filterText == ''){
          filteredClients = this.user.myClientCards();
          filteredClients.sort(lastNameComparator);
          return filteredClients;
        }
        for (ClientCard client in this.user.myClientCards()) {
          String clientName = client.name.toLowerCase();
          if (clientName.contains(filterText.toLowerCase())) {
            filteredClients.add(client);
          }
        }
        filteredClients.sort(lastNameComparator);
        return filteredClients;
      }

      // below is the original implementation, i'll keep it till I have the sorting stuff implemented in all classes.

//    if (filterText == '') {
//      return this.user.myClientCards().reversed.toList();
//    }
//    List<Widget> filteredClients = [];
//    for (ClientCard client in this.user.myClientCards()) {
//      String clientName = client.name.toLowerCase();
//      if (clientName.contains(filterText.toLowerCase())) {
//        filteredClients.add(client);
//      }
//    }
//    return filteredClients;
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
            child: Row(
              children: <Widget>[
                Expanded(
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
                DropdownButton<String>(
                  value: dropdownValue,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (String value){
                    setState(() {
                      dropdownValue = value;
                    });
                  },
                  items: <String>['Sort by', 'Most Recent', 'First Name (A-Z)', 'Last Name (A-Z)']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                      .toList(),
                ),
              ],
            ),
          ),
          leading: ProfileButton(this.user),
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
              children: this.filterClients(this.search, this.dropdownValue),
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
