import 'package:flutter/material.dart';

class LibraryItem extends StatelessWidget {
  final String imgUrl;
  final String description;

  LibraryItem(this.imgUrl, this.description);

  Widget libraryImg() {
    return new Container(
        margin: EdgeInsets.only(bottom: 10),
        width: 400,
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          child: new Image.asset(
            imgUrl,
            fit: BoxFit.cover,
          ),
        ));
  }

  Widget libraryInfo() {
    return new Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
              flex: 1,
              child: new Text(
                description,
                textAlign: TextAlign.left,
                style: new TextStyle(fontSize: 18.0, color: Colors.black),
              )),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.cloud_download,
              color: Colors.red.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget libraryStatus() {
    return new Container(
      margin: EdgeInsets.only(top: 5.0),
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Expanded(
                flex: 1,
                child: new Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.fiber_new,
                        size: 25,
                        color: Colors.red.shade400,
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 0),
                      child: new FlatButton(
                        onPressed: () {
                          print('Details Pressed');
                        },
                        child: new Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            new Container(
              margin: EdgeInsets.only(right: 1),
              child: IconButton(
                icon: Icon(Icons.thumb_up, size: 22, color: Colors.grey[400]),
                onPressed: () {
                  print('Like pressed');
                },
              ),
            ),
            new Container(
              // margin: EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(Icons.more_vert, size: 22, color: Colors.grey[400]),
                onPressed: () {
                  print('More pressed');
                },
              ),
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 16.0),
        padding: new EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            libraryImg(),
            libraryInfo(),
            Divider(),
            libraryStatus()
          ],
        ));
  }
}
