import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';
import 'typical_trainers_details.dart';
import 'typical_client_details.dart';

class UserCard extends StatelessWidget {
  final String name;
  final User user;

  UserCard({@required this.user, @required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: (){
              if(this.user is Trainer){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      TypicalTrainerDetails(this.user, this.name),
                  ),
                );
              } else{
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      TypicalClientDetails(this.user, this.name),
                  ),
                );
              }
            },

            child: Column(
              children: <Widget>[
                Image.asset(
                  user.photo,
                  height: 100.0,
                  width: 100.0,
                ),
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


