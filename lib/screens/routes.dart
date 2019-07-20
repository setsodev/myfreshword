import 'package:flutter/material.dart';
import 'package:myfreshword/screens/browse/index.dart';
import 'package:myfreshword/screens/library/index.dart';
import 'package:myfreshword/screens/profile/index.dart';

final routes = {
  '/library': (BuildContext context) => new LibraryView(),
  '/browse': (BuildContext context) => new BrowseView(),
  '/profile': (BuildContext context) => new ProfileView(),
};
