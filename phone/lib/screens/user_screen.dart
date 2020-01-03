import 'package:flutter/material.dart';
import 'package:phone/screens/users.dart';

class UserPage extends StatefulWidget {
  Client client;

  UserPage(this.client);

  @override
  _UserPageState createState() => _UserPageState(this.client);
}

class _UserPageState extends State<UserPage> {
  Client user;

  _UserPageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
