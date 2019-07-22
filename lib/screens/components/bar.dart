import 'package:flutter/material.dart';
import 'package:myfreshword/constants/config.dart';

class BarView extends StatelessWidget {
  final IconData icon;

  BarView(this.icon);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(
          child: new Icon(icon, size: 25.0, color: Colors.red.shade400),
          margin: const EdgeInsets.only(right: 26.0),
        ),
        new Expanded(
          child: new TextField(
            autofocus: false,
            textAlign: TextAlign.center,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              prefixIcon: new Icon(
                Icons.search,
                size: 22.0,
                color: GlobalConfig.fontColor,
              ),
              hintText: "Keywords, episodes, preachings",
              hintStyle: new TextStyle(color: GlobalConfig.fontColor),
              fillColor: Colors.grey[200],
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
        new Container(
          child: new FlatButton(
            onPressed: () {
              print('now playing');
            },
            child: new Icon(
              Icons.equalizer,
              size: 25.0,
              color: Colors.red.shade400,
            ),
          ),
          width: 40.0,
          margin: const EdgeInsets.only(left: 16.0),
        ),
      ],
    );
  }
}
