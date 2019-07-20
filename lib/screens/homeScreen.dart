import 'package:flutter/material.dart';
import 'package:myfreshword/constants/config.dart';
import 'package:myfreshword/screens/browse/index.dart';
import 'package:myfreshword/screens/library/index.dart';
import 'package:myfreshword/screens/profile/index.dart';

import 'components/bar.dart';
import 'home/index.dart';

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myFreshWord',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyHomePage(title: 'Cloud Podcast'),
      // routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<StatelessWidget> _pageList = [
    new HomeView(),
    new LibraryView(),
    new BrowseView(),
    new ProfileView(),
  ];

  List<StatelessWidget> _barList = [
    new BarView(Icons.notifications_none),
    new BarView(Icons.notifications_none),
    new BarView(Icons.notifications_none),
    new BarView(Icons.notifications_none),
    new BarView(Icons.notifications_none),
  ];

  StatelessWidget _currentPage;
  StatelessWidget _currentBar;

  @override
  void initState() {
    super.initState();
    _currentPage = _pageList[_selectedIndex];
    _currentBar = _barList[_selectedIndex];
  }

  void _onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
      _currentPage = _pageList[index];
      _currentBar = _barList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: _currentBar,
        backgroundColor: Colors.white,
      ),
      body: new SingleChildScrollView(
        child: _currentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Bottom navigation
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_outline), title: Text('Listen Now')),
          BottomNavigationBarItem(
              icon: Icon(Icons.move_to_inbox), title: Text('Library')),
          BottomNavigationBarItem(
              icon: Icon(Icons.track_changes), title: Text('Browse')),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity), title: Text('Profile')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: GlobalConfig.navColor,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}

void main() => runApp(MyHomeScreen());
