import 'package:flutter/material.dart';
import 'package:myfreshword/constants/config.dart';

class Nav {
  String text;
  IconData icon;

  Nav(this.text, this.icon);
}

List<Nav> navList = [
  new Nav('label', Icons.explore),
  new Nav('label', Icons.favorite_border),
  new Nav('label', Icons.subscriptions),
  new Nav('label', Icons.data_usage),
];

class NavView extends StatelessWidget {
  Widget item(item) {
    return Expanded(
        child: Column(
      children: <Widget>[
        new Container(
          width: 50,
          height: 50,
          child: new Icon(item.icon, color: Colors.white),
          margin: EdgeInsets.only(bottom: 8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: GlobalConfig.navColor,
          ),
        ),
        new Text(item.text)
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: navList.map((nav) => item(nav)).toList()),
    );
  }
}
