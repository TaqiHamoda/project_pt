import 'package:flutter/material.dart';
import 'login_screen.dart';

class SubmitInfoPage extends StatefulWidget {

  final String titleText;
  final String labelText;
  final Icon icon;

  SubmitInfoPage(this.titleText, this.labelText, this.icon);


  @override
  _SubmitInfoPageState createState() => _SubmitInfoPageState(this.titleText, this.labelText, this.icon);
}

class _SubmitInfoPageState extends State<SubmitInfoPage> {

  String titleText;
  String labelText;
  Icon icon;

  _SubmitInfoPageState(this.titleText, this.labelText, this.icon);

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('An email has been sent to you for further instructions'),
          actions: <Widget>[
            FlatButton(
              child: Text('Return to login page'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.titleText
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                icon: this.icon,
                labelText: this.labelText,
              ),
            ),
            FlatButton(
              color: Colors.lightBlue,
              onPressed: (){
                setState(() {
                  _showDialog();
                });
              },
              child: Text(
                'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
