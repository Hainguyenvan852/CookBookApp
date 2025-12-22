import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';

class InformationField extends StatelessWidget {
  const InformationField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.h,),
        Text('Chef@example.com', style: TextStyle(color: ColorThemes.textPrimary),),
        SizedBox(height: 10.h,),
        Container(
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorThemes.inputFieldBackground
          ),
          child: Center(
            child: TextFormField(
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                color: ColorThemes.textSecondary,
                fontSize: 15.sp
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Email Address',
                hintStyle: TextStyle(
                    color: ColorThemes.textSecondary
                ),
                suffixIcon: Icon(Icons.email, color: ColorThemes.iconColor1,),
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
