import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/main_theme.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.controller, required this.hintText, required this.icon, required this.validate});
  final TextEditingController controller;
  final String? Function(String?)? validate;
  final String hintText;
  final Icon icon;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      style: TextStyle(
          color: ColorThemes.textSecondary,
          fontSize: 15.sp
      ),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: ColorThemes.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
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
        hintText: widget.hintText,
        hintStyle: TextStyle(
            color: ColorThemes.textSecondary
        ),
        prefixIcon: widget.icon,
        suffixIcon: GestureDetector(
            onTap: (){
              setState(() {
                _isObscure = _isObscure ? false : true;
              });
            },
            child: _isObscure ? Icon(Icons.visibility, color: ColorThemes.iconColor2,) : Icon(Icons.visibility_off, color: ColorThemes.iconColor2,)
        ),
      ),
      validator: widget.validate,
    );
  }
}



