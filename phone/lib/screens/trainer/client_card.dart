import 'package:flutter/material.dart';
import 'client_details_screen.dart';
import '../../components/users.dart';

class ClientCard extends StatelessWidget {

  ClientCard({@required this.client, @required this.name, this.onLongPress});

  final String name;
  final Client client;
  final Function onLongPress;
  bool selected = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.selected ? Colors.blue.withOpacity(0.6) : Colors.transparent,
      child: Column(
        children: <Widget>[
          FlatButton(
            onLongPress: (){ this.onLongPress();
            this.selected = !this.selected; },
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      ClientDetails(this.client, this.name),
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
          ),

        ],
      ),
    );
  }
}
