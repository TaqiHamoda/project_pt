import 'package:flutter/material.dart';
import 'user_details_card.dart';

class UserCard extends StatelessWidget {

  UserCard({@required this.name, @required this.photo});

  final String name;
  final String photo; // photo location


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
                        UserDetails(this.name,this.photo)));
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
