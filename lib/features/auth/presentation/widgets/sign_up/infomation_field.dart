import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';

class InformationField extends StatelessWidget {
  const InformationField({super.key, required this.controller, required this.hintText, required this.icon,required this.validate, required this.inputType, required this.onChanged,});
  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  final TextInputType inputType;
  final String? Function(String?)? validate;
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
          color: ColorThemes.textSecondary,
          fontSize: 15.sp
      ),
      keyboardType: inputType,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: ColorThemes.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: ColorThemes.border, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: ColorThemes.border, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: ColorThemes.border, width: 1),
        ),
        errorStyle: TextStyle(
          color: Colors.red
        ),
        fillColor: ColorThemes.inputFieldBackground2,
        filled: true,
        errorMaxLines: 1,
        helperText: ' ',
        hintText: hintText,
        hintStyle: TextStyle(
            color: ColorThemes.textSecondary
        ),
        prefixIcon: icon,
      ),
      validator: validate,
      onChanged: (value) => onChanged(value),
    );
  }
}
