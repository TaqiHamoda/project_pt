import 'package:flutter/material.dart';
import 'client_details_screen.dart';
import '../../components/users.dart';

class ClientCard extends StatelessWidget {

  ClientCard({@required this.client, @required this.name});

  final String name;
  final Client client;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      ClientDetails(this.client, this.name),
                  ),
              );
            },

            child: Column(
              children: <Widget>[
                SizedBox(width: 100, height: 100, child: this.client.photo),
                Text(
                  this.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
