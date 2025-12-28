import 'package:flutter/material.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/pages/home_page.dart';
import 'package:recipe_finder_app/features/auth/presentation/pages/profile_page.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/pages/recipe_page.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key, required this.user});
  final UserModel user;

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {

  int _selectedPage = 0;
  late final List<Widget> items;

  @override
  void initState() {
    super.initState();

    items = <Widget>[
      HomePage(user: widget.user,),
      RecipePage(),
      const Center(child: Text('Saved', style: TextStyle(color: Colors.white),)),
      const ProfilePage(),
    ];
  }


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
