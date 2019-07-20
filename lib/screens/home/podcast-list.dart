import 'package:flutter/material.dart';
import 'package:myfreshword/screens/components/item.dart';

class Podcast {
  String imgUrl;
  String description;

  Podcast(this.imgUrl, this.description);
}

List<Podcast> podcastListOne = [
  new Podcast('assets/images/song_1.jpg', 'Christain Heritage'),
  new Podcast('assets/images/song_2.jpg', 'Kingdom Driven Entrepreneur'),
  new Podcast('assets/images/song_3.jpg', 'What The Church Is For'),
];

List<Podcast> podcastListTwo = [
  new Podcast('assets/images/song_4.jpg', 'Proverbs 31 Ministries'),
  new Podcast('assets/images/song_5.jpg', 'Christian Living'),
  new Podcast('assets/images/song_6.jpg', 'Renewing Your Mind'),
];

class PodcastLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: podcastListOne
            .map((Podcast podcast) => Item(podcast.imgUrl, podcast.description))
            .toList(),
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: podcastListTwo
              .map((Podcast podcast) =>
                  Item(podcast.imgUrl, podcast.description))
              .toList()),
    ]);
  }
}
