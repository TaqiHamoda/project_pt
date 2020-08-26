import 'package:flutter/material.dart';
import 'enlarge_picture_screen.dart';

class MessageText extends StatelessWidget {
  MessageText(
      {@required this.type,
      @required this.text,
      @required this.userIsSender,
      @required this.time,
      @required this.date,
      @required this.sender,
      this.onLongPress});

  final String type;
  final String sender;
  final String text;
  final DateTime date;
  final String time;
  final bool userIsSender;
  final Function onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: this.userIsSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: <Widget>[
          (this.type == 'text')
              ? InkWell(
                  onLongPress: onLongPress,
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 4,
                    color: this.userIsSender
                        ? Colors.lightBlue
                        : Colors.blueGrey[800],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.5, horizontal: 20),
                      child: Text(
                        this.text,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                )
              : (this.type == 'image')
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EnlargePicture(
                                    image: NetworkImage(this.text),
                                    date: date,
                                    time: time,
                                    sender: sender,
                                  )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 400,
                            width: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(this.text),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
          SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              this.time,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          )
        ],
      ),
    );
  }
}
