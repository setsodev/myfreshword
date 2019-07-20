import 'package:flutter/material.dart';

class BrowseView extends StatelessWidget {
  BrowseView({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return new Container(
      child: Center(
        child: new Text(
          'Browse Screen',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.red[500],
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
