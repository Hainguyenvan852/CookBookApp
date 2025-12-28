import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/main_theme.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.controller, required this.hintText, required this.title, required this.onChanged});
  final TextEditingController controller;
  final String hintText, title;
  final ValueChanged onChanged;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h,),
        Text(widget.title, style: const TextStyle(color: ColorThemes.textPrimary),),
        SizedBox(height: 10.h,),
        Container(
          height: 50.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: ColorThemes.inputFieldBackground
          ),
          child: Center(
            child: TextFormField(
              obscureText: _isObscure,
              controller: widget.controller,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                  color: ColorThemes.textSecondary,
                  fontSize: 15.sp
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    color: ColorThemes.textSecondary
                ),
                suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        _isObscure = _isObscure ? false : true;
                      });
                    },
                    style: IconButton.styleFrom(splashFactory: NoSplash.splashFactory),
                    icon: _isObscure ? Icon(Icons.visibility, color: ColorThemes.iconColor1,) : Icon(Icons.visibility_off, color: ColorThemes.iconColor1,)
                ),
                contentPadding: EdgeInsets.only(left: 10),
              ),
              onChanged: (value) => widget.onChanged(value),
            ),
          ),
        )
      ],
    );
  }
}
