import 'package:flutter/material.dart';
import 'package:phone/screens/main/messages_screen.dart';
import 'package:phone/screens/trainer/client_card.dart';
import 'package:phone/screens/main/profile_edit.dart';
import 'client_card.dart';
import '../../components/users.dart';

class TrainerPage extends StatefulWidget {
  final Trainer user;

  TrainerPage(this.user);

  @override
  _TrainerPageState createState() => _TrainerPageState(this.user);
}

class _TrainerPageState extends State<TrainerPage> {
  Trainer user;
  String search = '';

  _TrainerPageState(this.user);

  List<Widget> filterClients(String filterText){
    if(filterText == ''){
      return this.user.cards();
    }
    List<Widget> filteredClients = [];
    for(ClientCard client in this.user.cards()){
      String clientName = client.name.toLowerCase();
      if(clientName.contains(filterText.toLowerCase())){
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

    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: const Text('Create a new client'),
          children: <Widget>[

            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10.0),
                      labelText: 'First Name',
                    ),

                    onChanged: (value){ firstName = value; },
                  ),
                ),

                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10.0),
                      labelText: 'Last Name',
                    ),

                    onChanged: (value){ lastName = value; },
                  ),
                ),
              ],
            ),

            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                labelText: 'Email',
              ),

              onChanged: (value){ email = value; },
            ),

            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                labelText: 'Phone Number',
              ),

              onChanged: (value){ phone = value; },
            ),


            Row(children: <Widget>[
              Container(
                alignment: Alignment(-1.0, 0.0),
                child: FlatButton(
                  child: new Text('Ok',
                    style: TextStyle(color: Colors.blue),),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      this.user.addClient(Client(firstName, lastName, email, 'Bebop', phone, this.user));
                    });
                  },
                ),
              ),

              Container(
                alignment: Alignment(1.0, 0.0),
                child: FlatButton(
                  child: new Text('Cancel',
                    style: TextStyle(color: Colors.blue),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ])
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () { addClient(context); },
      ),

      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('images/profile.png'),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsPage(this.user)));
          },
        ),
        centerTitle: true,
        title: Text(
          'Trainer ' + this.user.firstName,
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessagePage(this.user)));
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
              onChanged: (value){
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
        ],
      ),
    );
  }
}
