import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone/components/users.dart';

class NewMessagePage extends StatefulWidget {
  NewMessagePage({@required this.currentUser});

  final User currentUser;

  @override
  _NewMessagePageState createState() => _NewMessagePageState();
}

class _NewMessagePageState extends State<NewMessagePage> {

  @override
  void initState() {
    print(widget.currentUser.messageList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Messages'),
          actions: <Widget>[],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            User user = widget.currentUser.messageList[index];
            print(widget.currentUser.messageList);

            return MessageCard(
              user: user,
              lastDate: '2020',
              lastMessage: 'test',
            );
          },
          itemCount: widget.currentUser.messageList.length,
        ));
  }
}

class MessageCard extends StatelessWidget {
  MessageCard(
      {@required this.user,
      @required this.lastMessage,
      @required this.lastDate});

  final User user;
  final String lastMessage;
  final String lastDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.grey[200],
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: user.photo,
                radius: 35,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          user.firstName + ' ' + user.lastName,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Text(lastDate),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Flexible(
                      child: Text(
                        lastMessage,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
