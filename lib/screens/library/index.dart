import 'package:flutter/material.dart';
import 'package:myfreshword/screens/components/library-item.dart';
import 'package:myfreshword/screens/library/library.model.dart';

class LibraryView extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.grey[100],
      child: new Column(
        children: videoModel
            .map(
              (Library v) => new LibraryItem(v.imgUrl, v.description),
            )
            .toList(),
      ),
    );
  }
}
