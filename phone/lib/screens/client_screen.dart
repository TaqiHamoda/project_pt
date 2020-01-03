import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';

class ClientPage extends StatefulWidget {
  Client client;

  ClientPage(this.client);

  @override
  _ClientPageState createState() => _ClientPageState(this.client);
}

class _ClientPageState extends State<ClientPage> {
  Client user;

  _ClientPageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
