import 'package:flutter/material.dart';
import 'director_details_card.dart';
import '../../components/users.dart';

class DirectorCard extends StatelessWidget {

  DirectorCard({@required this.director, @required this.name});

  final String name;
  final Director director;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    DirectorDetails(this.director, this.name, director.photo),
                ),
              );
            },

            child: Column(
              children: <Widget>[
                Image.asset(
                  director.photo,
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
