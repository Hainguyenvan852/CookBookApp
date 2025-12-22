import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {

  int _selectedPage = 0;

  final items = <Widget>[
    const Center(child: Text('Home'),),
    const Center(child: Text('Search'),),
    const Center(child: Text('Saved'),),
    const Center(child: Text('Profile'),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedPage,
        children: items,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorThemes.backgroundColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedPage,
          onTap: (index){
            setState(() {
              _selectedPage = index;
            });
          },
          selectedItemColor: ColorThemes.primaryAccent,
          unselectedItemColor: ColorThemes.iconColor2,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Icon(Icons.home_filled),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Icon(Icons.search_rounded),
              ),
              label: 'Search'
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Icon(Icons.bookmark),
              ),
              label: 'Saved'
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Icon(Icons.person),
              ),
              label: 'Profile'
            )
          ]
      ),
    );
  }
}
