import 'package:flutter/material.dart';
import 'client_details_screen.dart';
import '../../components/users.dart';

class ClientCard extends StatelessWidget {

  ClientCard({@required this.client, @required this.name, @required this.photo});

  final String name;
  final String photo; // photo location
  final Client client;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: FlatButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        ClientDetails(this.client, this.name, this.photo),
                    ),
                );
              },
              child: Image.asset(
                this.photo,
                height: 100.0,
                width: 100.0,
              ),
            ),
          ),
          Center(
            child: Text(
              this.name,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
