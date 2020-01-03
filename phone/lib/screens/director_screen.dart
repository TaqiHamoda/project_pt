import 'package:flutter/material.dart';
import '../components/users.dart';

class DirectorPage extends StatefulWidget {
  Director user;

  DirectorPage(this.user);

  @override
  _DirectorPageState createState() => _DirectorPageState(this.user);
}

class _DirectorPageState extends State<DirectorPage> {
  Director user;

  _DirectorPageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
