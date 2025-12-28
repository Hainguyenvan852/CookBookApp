import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/features/auth/presentation/views/sign_up_view.dart';

import '../../data/repositories/auth_repository_impl.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key, required this.authRepo});
  final AuthRepositoryImpl authRepo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios_rounded, size: 22, color: ColorThemes.textPrimary,)),
          title: Text(
            'Create Account',
          ),
          centerTitle: true,
        ),
        body: SignUpView(authRepo: authRepo,)
    );
  }
}
