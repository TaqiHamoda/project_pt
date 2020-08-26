import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'messaging_dates.dart';
import 'package:image_downloader/image_downloader.dart';

class EnlargePicture extends StatelessWidget {
  EnlargePicture(
      {@required this.image,
      @required this.sender,
      @required this.date,
      @required this.time});

  final NetworkImage image;
  final String sender;
  final DateTime date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              sender,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              getFullDateAsString(date) + ', ' + time,
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
        actions: <Widget>[
          Builder(
            builder: (context) {return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: IconButton(
                iconSize: 30,
                icon: Icon(Icons.file_download),
                onPressed: () async {
                  try {
                    await ImageDownloader.downloadImage(image.url);
                  } on PlatformException catch (error) {
                    print(error);
                  }

                  SnackBar snackbar = SnackBar(content: Text('Image saved to Downloads'),);

                  Scaffold.of(context).showSnackBar(snackbar);
                },
              ),
            );},
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(image: image),
        ),
      ),
    );
  }
}
