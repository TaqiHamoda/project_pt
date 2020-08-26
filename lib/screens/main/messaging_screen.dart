import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone/screens/main/new_message_screen.dart';
import 'package:phone/components/users.dart';
import 'message_card.dart';

class ClientMessagePage extends StatefulWidget {
  final Client client;

  ClientMessagePage(this.client);

  @override
  _ClientMessagePageState createState() => _ClientMessagePageState(this.client);
}

class _ClientMessagePageState extends State<ClientMessagePage> {
  Client client;
  String message;

  _ClientMessagePageState(this.client);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          client.trainer.firstName + ' ' + client.trainer.lastName,
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: Container()),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        hintText: 'Type a message'),
                    onChanged: (value) {
                      message = value;
                    },
                  ),
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                elevation: 2.0,
                fillColor: Colors.lightBlue,
                child: Icon(
                  Icons.send,
                  size: 28.0,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                shape: CircleBorder(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
