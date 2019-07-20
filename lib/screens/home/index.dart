import 'package:flutter/material.dart';
import 'package:myfreshword/screens/components/title-bar.dart';
import 'package:myfreshword/screens/home/banner.dart';
import 'package:myfreshword/screens/home/nav.dart';
import 'package:myfreshword/screens/home/podcast-list.dart';

class HomeView extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(16),
      child: new Column(
        children: <Widget>[
          SwiperView(),
          NavView(),
          Divider(),
          TitleBar('Recently Played', 'View All'),
          PodcastLists(),
        ],
      ),
    );
  }
}
