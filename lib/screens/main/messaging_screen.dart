import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone/components/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone/screens/main/message_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:vibration/vibration.dart';
import 'messaging_dates.dart';

class MessagePage extends StatefulWidget {
  final User receiver;

  MessagePage({@required this.receiver});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  User receiver;
  String message = '';
  String _messageText;
  FirebaseUser currentUser;
  Stream<QuerySnapshot> _firebaseStream;
  List<File> _images = [];
  bool textIsHighlighted = false;

  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  final _controller = TextEditingController();

  void getUser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        currentUser = user;

        setState(() {
          _firebaseStream = _firestore
              .collection('users')
              .document(currentUser.email)
              .collection('userList')
              .document(receiver.email)
              .collection('messages')
              .orderBy('timestamp', descending: true)
              .snapshots();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future getImage() async {
    try {
      File image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
      );

      setState(() {
        if (image != null) {
          setState(() {
            _images.add(image);
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void sendMessage() async {
    if (message == '') {
      return;
    }

    _firestore
        .collection("users")
        .document(currentUser.email)
        .collection('userList')
        .document(receiver.email)
        .collection('messages')
        .add({
      'sender': currentUser.email,
      'text': message,
      'timestamp': FieldValue.serverTimestamp(),
      'time': DateTime.now().toString(),
      'type': 'text',
    });

    _firestore
        .collection("users")
        .document(receiver.email)
        .collection('userList')
        .document(currentUser.email)
        .collection('messages')
        .add({
      'sender': currentUser.email,
      'text': message,
      'timestamp': FieldValue.serverTimestamp(),
      'time': DateTime.now().toString(),
      'type': 'text',
    });

    _controller.clear(); //empty the text field

    setState(() {
      message = ''; //hide send button
    });

    FocusScope.of(context).requestFocus(new FocusNode()); //hide keyboard
  }

  void _sendImage(File image) async {
    try {
      const _chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random _rnd = Random();

      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(
              length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

      String fileName = getRandomString(40);
      StorageReference reference = FirebaseStorage.instance
          .ref()
          .child('users')
          .child(currentUser.email)
          .child(fileName);
      StorageUploadTask uploadTask = reference.putFile(image);

      String imageURL =
          await (await uploadTask.onComplete).ref.getDownloadURL();

      _firestore
          .collection("users")
          .document(currentUser.email)
          .collection('userList')
          .document(receiver.email)
          .collection('messages')
          .add({
        'sender': currentUser.email,
        'text': imageURL,
        'timestamp': FieldValue.serverTimestamp(),
        'time': DateTime.now().toString(),
        'type': 'image',
      });

      _firestore
          .collection("users")
          .document(receiver.email)
          .collection('userList')
          .document(currentUser.email)
          .collection('messages')
          .add({
        'sender': currentUser.email,
        'text': imageURL,
        'timestamp': FieldValue.serverTimestamp(),
        'time': DateTime.now().toString(),
        'type': 'image',
      });

      return;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    receiver = widget.receiver;
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: textIsHighlighted
          ? AppBar(
              leading: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    textIsHighlighted = false;
                  });
                },
              ),
              actions: <Widget>[
                Builder(builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(
                      Icons.content_copy,
                    ),
                    onPressed: () {
                      FlutterClipboardManager.copyToClipBoard(_messageText)
                          .then((result) {
                        final snackBar = SnackBar(
                          content: Text('Copied to Clipboard'),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                        setState(() {
                          textIsHighlighted = false;
                        });
                      });
                    },
                  );
                })
              ],
            )
          : AppBar(
              title: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: receiver.photo,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  Text(
                    receiver.firstName + ' ' + receiver.lastName,
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
            ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firebaseStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data.documents;
                  List<MessageText> messageWidgets = [];

                  for (var message in messages) {
                    if (message.data['sender'] != receiver.email &&
                        message.data['sender'] != currentUser.email) {
                      continue;
                    }

                    final time = message.data['time'];
                    DateTime date = DateTime.parse(time);
                    String fullEdit = processTime(time);

                    final messageText = message.data['text'];

                    final messageWidget = message.data['type'] == 'text'
                        ? MessageText(
                            onLongPress: () async {
                              if (await Vibration.hasVibrator()) {
                                Vibration.vibrate(duration: 30);
                              }
                              setState(() {
                                textIsHighlighted = true;
                                _messageText = messageText;
                              });
                            },
                            sender:
                                receiver.firstName + ' ' + receiver.lastName,
                            type: 'text',
                            date: date,
                            time: fullEdit,
                            text: messageText,
                            userIsSender:
                                message.data['sender'] == currentUser.email
                                    ? true
                                    : false)
                        : MessageText(
                            sender:
                                receiver.firstName + ' ' + receiver.lastName,
                            type: 'image',
                            text: messageText,
                            userIsSender:
                                message.data['sender'] == currentUser.email
                                    ? true
                                    : false,
                            time: fullEdit,
                            date: date,
                          );

                    messageWidgets.add(messageWidget);
                  }

                  List<Widget> completeList =
                      separateDate(messageWidgets.reversed.toList());

                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(
                          new FocusNode()); //hide keyboard when tapping on a message
                      setState(() {
                        textIsHighlighted = false;
                      });
                    },
                    child: ListView.builder(
                      reverse: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      itemCount: completeList.length,
                      itemBuilder: (context, index) {
                        return completeList[completeList.length - index - 1];
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          _images.isEmpty
              ? Row(
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: () {
                        getImage();
                      },
                      elevation: 2.0,
                      fillColor: Colors.lightBlue,
                      child: Icon(
                        Icons.photo_library,
                        size: 28.0,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(15),
                      shape: CircleBorder(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10),
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: _controller,
                          decoration: InputDecoration(
                              suffixIcon: message == ''
                                  ? null
                                  : IconButton(
                                      icon: Icon(Icons.send),
                                      onPressed: () {
                                        sendMessage();
                                      }),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              hintText: 'Type a message'),
                          onChanged: (value) {
                            setState(() {
                              message = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            getImage();
                          });
                        },
                        elevation: 2.0,
                        fillColor: Colors.lightBlue,
                        child: Icon(
                          Icons.add,
                          size: 28.0,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(15),
                        shape: CircleBorder(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.blueGrey, width: 2),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                            0.2 +
                                        10,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _images.length,
                                      itemBuilder: (context, index) {
                                        return BorderImage(
                                          onPressed: () {
                                            for (File im in _images) {
                                              if (im == _images[index]) {
                                                break;
                                              }
                                            }

                                            setState(() {
                                              _images.removeAt(index);
                                            });
                                          },
                                          image: _images[index],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        for (File image in _images) {
                                          _sendImage(image);
                                        }

                                        setState(() {
                                          _images = [];
                                        });
                                      });
                                    },
                                    icon: Icon(
                                      Icons.send,
                                      size: 28.0,
                                      color: Colors.lightBlue,
                                    ),
                                    padding: const EdgeInsets.all(15),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}

class BorderImage extends StatelessWidget {
  BorderImage({@required this.onPressed, @required this.image});

  final File image;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Container(
            height: MediaQuery.of(context).size.width * 0.2,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FittedBox(
                child: Image.file(
                  image,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
            right: -10,
            top: -10,
            child: IconButton(
              icon: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey),
                child: Icon(
                  Icons.cancel,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              onPressed: onPressed,
            )),
      ],
    );
  }
}
