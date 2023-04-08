import 'package:flutter/material.dart';
import 'package:recipe/Screens/Bookmark_Screen.dart';
import 'package:recipe/Screens/Home_Screen.dart';
import 'package:recipe/Screens/Settings_Screen.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class NavHomeScreen extends StatefulWidget {
  const NavHomeScreen({Key? key}) : super(key: key);

  @override
  State<NavHomeScreen> createState() => _NavHomeScreenState();
}

class _NavHomeScreenState extends State<NavHomeScreen> {
  late PageController _pageController;
  int selectedIndex = 0;
  bool _colorful = false;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _listOfWidget,
            ),
          ),
        ],
      ),
      bottomNavigationBar: _colorful
          ? SlidingClippedNavBar.colorful(
              backgroundColor: Colors.white,
              onButtonPressed: onButtonPressed,
              iconSize: 30,
              // activeColor: const Color(0xFF01579B),
              selectedIndex: selectedIndex,
              barItems: <BarItem>[
                BarItem(
                  icon: Icons.event,
                  title: 'Home',
                  activeColor: Colors.blue,
                  inactiveColor: Colors.orange,
                ),
                // BarItem(
                //   icon: Icons.search_rounded,
                //   title: 'Search',
                //   activeColor: Colors.yellow,
                //   inactiveColor: Colors.green,
                // ),
                BarItem(
                  icon: Icons.bolt_rounded,
                  title: 'BookMark',
                  activeColor: Colors.blue,
                  inactiveColor: Colors.red,
                ),
                BarItem(
                  icon: Icons.tune_rounded,
                  title: 'Settings',
                  activeColor: Colors.cyan,
                  inactiveColor: Colors.purple,
                ),
              ],
            )
          : SlidingClippedNavBar(
              backgroundColor: Colors.white,
              onButtonPressed: onButtonPressed,
              iconSize: 30,
              activeColor: const Color(0xFF01579B),
              selectedIndex: selectedIndex,
              barItems: <BarItem>[
                BarItem(
                  icon: Icons.home_filled,
                  title: 'Home',
                ),
                // BarItem(
                //   icon: Icons.search_rounded,
                //   title: 'Search',
                // ),
                BarItem(
                  icon: Icons.bookmark,
                  title: 'BookMark',
                ),
                BarItem(
                  icon: Icons.tune_rounded,
                  title: 'Settings',
                ),
              ],
            ),
    );
  }
}

List<Widget> _listOfWidget = <Widget>[
  HomeScreen(),
  // SearchScreen(),
  BookmarkScreen(),
  SettingScreen(),
];
