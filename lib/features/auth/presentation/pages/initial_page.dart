import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  
  final fieldKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("lib/core/icons/chef-hat.svg", width: 150,),
            SizedBox(height: 40,),
            Text(
              'Recipe Finder',
              style: TextStyle(color: ColorThemes.textPrimary, fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5,),
            Text(
              'Discover. Cook. Enjoy.',
              style: TextStyle(color: ColorThemes.textSecondary, fontSize: 16),
            ),
            SizedBox(height: 100,),
            LoadingAnimationWidget.horizontalRotatingDots(color: Colors.white, size: 50)
          ],
        ),
      ),
    );
  }
}
