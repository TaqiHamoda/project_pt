import 'package:flutter/material.dart';
import 'trainer_details_card.dart';
import '../../components/users.dart';

class TrainerCard extends StatelessWidget {

  TrainerCard({@required this.trainer, @required this.name});

  final String name;
  final Trainer trainer;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    TrainerDetails(this.trainer, this.name, trainer.photo),
                ),
              );
            },

            child: Column(
              children: <Widget>[
                Image.asset(
                  trainer.photo,
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


