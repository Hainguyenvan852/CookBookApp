import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_finder_app/features/auth/presentation/widgets/login/background_img_and_title.dart';
import 'package:recipe_finder_app/features/auth/presentation/widgets/login/password_field.dart';
import 'package:recipe_finder_app/features/auth/presentation/widgets/submit_button.dart';

import '../../../../core/themes/main_theme.dart';
import '../widgets/login/email_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _canSubmit = false;

  void _checkSubmit(){
    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
      setState(() {
        _canSubmit = true;
      });
    } else{
      setState(() {
        _canSubmit = false;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => _checkSubmit());
    _passwordController.addListener(() => _checkSubmit());
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BackgroundImgAndTitle(),
            InformationField(
              controller: _emailController,
            ),
            PasswordField(
                controller: _passwordController,
                hintText: '********',
                title: 'Password',
            ),
            TextButton(
              onPressed: (){},
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory
              ),
              child: Text('Forgot Password?',
                style: TextStyle(
                  color: ColorThemes.textSecondary,
                ),
              ),
            ),
            SizedBox(height: 8.h,),
            SubmitButton(
                title: 'Log In',
                onPressed: _canSubmit ? (){
                  _loginAction(context);
                } : (){}
            ),
            SizedBox(height: 25.h,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 0.5,
                    color: ColorThemes.textSecondary,
                  ),
                  Text(
                    'OR CONTINUE WITH',
                    style: TextStyle(
                      fontSize: FontSizeThemes.smallFont,
                      color: ColorThemes.textSecondary
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: 100.w,
                    height: 0.5.h,
                    color: ColorThemes.textSecondary,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    onPressed: (){},
                    icon: Icon(FontAwesomeIcons.google, color: ColorThemes.textPrimary, size: 16,),
                    label: Text(
                      'Google',
                      style: TextStyle(
                          color: ColorThemes.textPrimary,
                          fontSize: FontSizeThemes.regularFont
                      ),
                    ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorThemes.iconBackground,
                    minimumSize: Size(180.w, 40.h),
                    maximumSize: Size(200.w, 50.h)
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: (){},
                  icon: Icon(FontAwesomeIcons.facebook, color: ColorThemes.textPrimary, size: 16,),
                  label: Text(
                    'Facebook',
                    style: TextStyle(
                        color: ColorThemes.textPrimary,
                        fontSize: FontSizeThemes.regularFont
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorThemes.iconBackground,
                      minimumSize: Size(180.w, 40.h),
                      maximumSize: Size(200.w, 50.h)
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New to the kitchen?',
                  style: TextStyle(
                    color: ColorThemes.textSecondary,
                  ),
                ),
                TextButton(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory
                    ),
                    child: Text(
                      'Create an account',
                      style: TextStyle(
                        color: ColorThemes.primaryAccent,
                        fontSize: FontSizeThemes.regularFont,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

void _loginAction(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(child: Text('Đang đăng nhập')),
        backgroundColor: ColorThemes.primaryAccent,
      )
  );
}
