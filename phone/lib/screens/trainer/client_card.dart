import 'package:flutter/material.dart';
import 'client_details_screen.dart';
import '../../components/users.dart';

class ClientCard extends StatelessWidget {

  ClientCard({@required this.client, @required this.name});

  final String name;
  final Client client;
  bool selected = false;


  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                ClientDetails(client: this.client, name: this.name),
            ),
        );
      },

      child: Column(
        children: <Widget>[
          CircleAvatar(backgroundImage: this.client.photo, radius: 50,),
          Text(
            this.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
