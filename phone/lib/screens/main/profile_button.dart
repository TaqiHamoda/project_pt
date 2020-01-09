import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';
import 'package:phone/screens/main/profile_edit.dart';

class ProfileButton extends StatelessWidget {
  final User user;

  ProfileButton(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 5.0, top: 5.0),
        child: InkWell(
            child: CircleAvatar(
              backgroundImage: this.user.photo,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPage(this.user)));}
            )
    );
  }
}
