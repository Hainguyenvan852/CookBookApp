import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:recipe_finder_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_form/auth_form_event.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_form/auth_form_state.dart';
import 'package:recipe_finder_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:recipe_finder_app/features/auth/presentation/widgets/login/background_img_and_title.dart';
import 'package:recipe_finder_app/features/auth/presentation/widgets/login/password_field.dart';

import '../../../../core/themes/main_theme.dart';
import '../widgets/login/email_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.authRepo});
  final AuthRepositoryImpl authRepo;

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
    return BlocProvider(
      create: (context) => AuthFormBloc(widget.authRepo),
      child: BlocConsumer<AuthFormBloc, AuthFormState>(
          //listenWhen: (b, c) => b.runtimeType != c.runtimeType,
          listener: (context, state){
            state.authFailureOrSuccessOption.fold(
                (){},
                (either) => either.fold(
                    (failure) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message), backgroundColor: ColorThemes.primaryAccent,)),
                    (_) => (){}
                )
            );
          },
          builder: (context, state){
            return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BackgroundImgAndTitle(),
                    InformationField(
                      onChanged: (value){
                        context.read<AuthFormBloc>().add(EmailChanged(value));
                      },
                      controller: _emailController,
                    ),
                    PasswordField(
                      onChanged: (value){
                        context.read<AuthFormBloc>().add(PasswordChanged(value));
                      },
                      controller: _passwordController,
                      hintText: '********',
                      title: 'Password',
                    ),
                    TextButton(
                      onPressed: (){

                      },
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
                    Center(
                      child: ElevatedButton(
                          onPressed: _canSubmit ? (){
                            _loginAction(context);
                          } : (){},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorThemes.primaryAccent,
                              minimumSize: Size(double.infinity, 50.h),
                              maximumSize: Size(double.infinity, 50.h)
                          ),
                          child: state.isSubmitting ? Center(child: LoadingAnimationWidget.progressiveDots(color: Colors.black, size: 30)) :
                          Text(
                            'Log In',
                            style: TextStyle(
                                fontSize: FontSizeThemes.mediumFont,
                                fontWeight: FontWeight.bold
                            ),
                          )
                      ),
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
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(authRepo: widget.authRepo)));
                            },
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
          },
      )
    );
  }
}

void _loginAction(BuildContext context) {
  context.read<AuthFormBloc>().add(SignInPressed());
}
