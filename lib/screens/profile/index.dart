import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return new Center(
      child: new Text(
        'Profile Screen',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.red[500],
          fontSize: 30.0,
        ),
      ),
    );
  }
}
