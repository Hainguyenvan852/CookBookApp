import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/features/auth/presentation/views/login_view.dart';

import '../../data/repositories/auth_repository_impl.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.authRepo});
  final AuthRepositoryImpl authRepo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72.h,
        leadingWidth: 52.w,
        leading: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorThemes.iconBackground
          ),
          child: SvgPicture.asset("lib/core/icons/chef-hat.svg"),
        ),
        title: Text(
          'CookBook',
          style: TextStyle(
            color: ColorThemes.textPrimary,
            fontSize: FontSizeThemes.mediumFont,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          Icon(Icons.help, color: ColorThemes.iconColor1, size: 22,)
        ],
        actionsPadding: EdgeInsets.only(right: 12),
      ),
      body: LoginView(authRepo: authRepo,)
    );
  }
}
