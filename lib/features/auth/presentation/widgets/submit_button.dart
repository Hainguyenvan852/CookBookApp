import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.title, required this.onPressed});
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorThemes.primaryAccent,
          minimumSize: Size(double.infinity, 50.h),
          maximumSize: Size(double.infinity, 100.h)
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: FontSizeThemes.mediumFont,
            fontWeight: FontWeight.bold
          ),
        )
      ),
    );
  }
}
