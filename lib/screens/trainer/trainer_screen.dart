import 'package:flutter/material.dart';
import 'package:phone/screens/main/messaging_screen.dart';
import 'package:phone/screens/main/message_list.dart';
import 'package:phone/screens/trainer/client_card.dart';
import 'package:phone/screens/main/dialog.dart';
import '../../components/users.dart';
import 'package:phone/screens/main/profile_button.dart';
import 'package:flutter/services.dart';

class TrainerPage extends StatefulWidget {
  final Trainer trainer;

  TrainerPage({@required this.trainer});

  @override
  _TrainerPageState createState() => _TrainerPageState(this.trainer);
}

class _TrainerPageState extends State<TrainerPage> {
  Trainer trainer;
  String search = '';

  _TrainerPageState(this.trainer);

  List<Widget> filterClients() {
    List<ClientCard> filteredClients = [];
    for (Client client in this.trainer.clients) {

      String clientName = client.firstName + ' ' + client.lastName;

      if (clientName.toLowerCase().contains(this.search.toLowerCase())) {
        filteredClients.add(ClientCard(
          trainer: this.trainer,
          client: client,
          name: clientName,
          delete: () {
            setState(() {
              this.trainer.clients.remove(client);
            });
          },
        )
        );
      }
    }

    return filteredClients;
  }

  void addClient() {
    String firstName;
    String lastName;
    String email;
    String phone;

    SpecialDialog(
      context: context,
        title: 'Create a client',
        onSubmit: () {
          setState(() {
            this
                .trainer
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
          leading: ProfileButton(user: this.trainer),
          centerTitle: true,
          title: Text(
            'Trainer ' + this.trainer.firstName,
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
                        builder: (context) => NewMessagePage(currentUser: trainer,))); //fix later
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
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
