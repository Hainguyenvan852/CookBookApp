import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/features/auth/presentation/views/sign_up_view.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_rounded, size: 22, color: ColorThemes.textPrimary,)),
          title: Text(
            'Create Account',
          ),
          centerTitle: true,
        ),
        body: SignUpView()
    );
  }
}
