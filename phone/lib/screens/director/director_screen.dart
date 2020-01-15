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
  final Director director;

  DirectorPage({@required this.director});

  @override
  _DirectorPageState createState() => _DirectorPageState(this.director);
}

class _DirectorPageState extends State<DirectorPage> {
  Director director;
  String search = '';
  String dropdownValue = 'Sort by';

  _DirectorPageState(this.director);

  List<Widget> filterClients() {
    List<ClientCard> filteredClients = [];

    for (Client client in this.director.getClients(director)) {
      String clientName = client.firstName + ' ' + client.lastName;
      if (clientName.toLowerCase().contains(this.search)) {
        filteredClients.add(ClientCard(
          client: client,
          name: clientName,
          onLongPress: (){setState(() {
            this.filterClients();
          });},));
      }
    }

    if (this.dropdownValue == 'Sort by' || this.dropdownValue == 'Most Recent') {
      filteredClients = filteredClients.reversed.toList();
    }

    else if (this.dropdownValue == 'First Name (A-Z)') {
      Comparator<ClientCard> firstNameComparator =
          (a, b) => a.name.split(' ')[0].compareTo(b.name.split(' ')[0]);

      filteredClients.sort(firstNameComparator);
    }

    else if (this.dropdownValue == 'Last Name (A-Z)') {
      Comparator<ClientCard> lastNameComparator =
          (a, b) => a.name.split(' ')[1].compareTo(b.name.split(' ')[1]);

      filteredClients.sort(lastNameComparator);
    }

    return filteredClients;

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

  void addClient() {
    String firstName;
    String lastName;
    String email;
    String phone;

    SpecialDialog(
        context: this.context,
        title: 'Create a client',
        onSubmit: () {
          setState(() {
            this
                .director
                .addClient(Client(firstName, lastName, email, 'Bebop', phone));
          });
        },
        children: <Widget>[
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
            addClient();
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
                      onChanged: (value) {
                        setState(() {
                          this.search = value;
                        });
                      },
                    ),
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      dropdownValue = value;
                    });
                  },
                  items: <String>[
                    'Sort by',
                    'Most Recent',
                    'First Name (A-Z)',
                    'Last Name (A-Z)'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          leading: ProfileButton(this.director),
          centerTitle: true,
          title: Text(
            'Director ' + this.director.firstName,
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
                        builder: (context) => MessagePage(this.director)));
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: CustomButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPage(this.director,
                                      'Director')));
                        },
                        label: 'Directors')),
                Expanded(
                    child: CustomButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPage(this.director,
                                      'Trainer')));
                        },
                        label: 'Trainers')),
                Expanded(
                    child: CustomButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPage(this.director,
                                      'Client')));
                        },
                        label: 'Other Clients'))
              ],
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              children: this.filterClients(),
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
            BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart), title: Text('Analytics'))
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
