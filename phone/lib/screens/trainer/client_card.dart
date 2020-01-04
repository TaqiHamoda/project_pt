import 'package:flutter/material.dart';
import 'client_details_card.dart';
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
            child: GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        ClientDetails(
                          client: this.client,
                          name: this.name,
                          photo: this.photo,
                        ),
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
