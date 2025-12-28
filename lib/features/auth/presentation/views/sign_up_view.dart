import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_form/auth_form_event.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_form/auth_form_state.dart';

import '../../../../core/themes/main_theme.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../pages/verify_email_page.dart';
import '../widgets/sign_up/infomation_field.dart';
import '../widgets/sign_up/password_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key, required this.authRepo});
  final AuthRepositoryImpl authRepo;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();

  final _validateKey = GlobalKey<FormState>();

  bool _isChecked = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthFormBloc(widget.authRepo),
      child: BlocConsumer<AuthFormBloc, AuthFormState>(
          listener: (context, state){
            if(state.signUpStepSuccess){
              _navigateToVerifyPage(context);
            }
            state.authFailureOrSuccessOption.fold(
                    (){},
                    (either) => either.fold(
                        (failure) {
                          if(failure.message == 'verify_email'){
                            _navigateToVerifyPage(context);
                            context.read<AuthFormBloc>().add(ResendOtp(state.email));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message), backgroundColor: ColorThemes.primaryAccent,));
                          }
                        },
                        (_) => (){}
                )
            );
          },
          builder: (context, state){
            return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    _titleSignUp(),
                    SizedBox(height: 30.h,),
                    _formSignUp(state),
                    SizedBox(height: 35.h,),
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
                            'Or continue with',
                            style: TextStyle(
                                fontSize: FontSizeThemes.regularFont,
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
                    SizedBox(height: 30.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorThemes.inputFieldBackground2
                            ),
                            padding: EdgeInsets.all(20),
                            child: Icon(FontAwesomeIcons.google, size: 22, color: ColorThemes.textPrimary,),
                          ),
                        ),
                        SizedBox(width: 30.w,),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorThemes.inputFieldBackground2
                            ),
                            padding: EdgeInsets.all(20),
                            child: Icon(FontAwesomeIcons.facebook, size: 22, color: ColorThemes.textPrimary,),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a member?',
                          style: TextStyle(
                              color: ColorThemes.textSecondary,
                              fontSize: FontSizeThemes.regularFont
                          ),
                        ),
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text(' Log in', style: TextStyle(
                                color: ColorThemes.primaryAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSizeThemes.regularFont
                            ),)
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
      ),
    );
  }

  Widget _titleSignUp(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome, Chef!',
          style: TextStyle(
              color: ColorThemes.textPrimary,
              fontSize: FontSizeThemes.bigTitleFont,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          'Sign up to discover and save delicious recipes',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorThemes.textSecondary,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }

  Widget _formSignUp(AuthFormState state){
    return Builder(
      builder: (context) {
        return Form(
          key: _validateKey,
          child: Column(
            children: [
              InformationField(
                controller: _nameCtrl,
                hintText: 'Full Name',
                icon: Icon(Icons.person, color: ColorThemes.iconColor2,),
                inputType: TextInputType.text,
                validate: (value) {
                  if(value == null || value.isEmpty){
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  context.read<AuthFormBloc>().add(NameChanged(value));
                },
              ),
              SizedBox(height: 5.h,),
              InformationField(
                controller: _emailCtrl,
                hintText: 'Email Address',
                icon: Icon(Icons.email_rounded, color: ColorThemes.iconColor2,),
                inputType: TextInputType.emailAddress,
                validate: (value) {
                  if(value == null || value.isEmpty){
                    return 'Please enter your email';
                  }
                  else if(!RegExp(r'^\w+@gmail\.com').hasMatch(value)){
                    return 'Invalid email';
                  }
                  return null;
                },
                onChanged: (value) {
                  context.read<AuthFormBloc>().add(EmailChanged(value));
                },
              ),
              SizedBox(height: 5.h,),
              PasswordField(
                controller: _passwordCtrl,
                hintText: 'Password',
                icon: Icon(Icons.lock, color: ColorThemes.iconColor2,),
                validate: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter password';
                  } else if(_passwordCtrl.text != _confirmPasswordCtrl.text){
                    return 'Password and confirm password do not match';
                  }
                  return null;
                },
                onChanged: (value) {
                  context.read<AuthFormBloc>().add(PasswordChanged(value));
                },
              ),
              SizedBox(height: 5.h,),
              PasswordField(
                controller: _confirmPasswordCtrl,
                hintText: 'Confirm Password',
                icon: Icon(Icons.lock_reset_rounded, color: ColorThemes.iconColor2,),
                validate: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter confirm password';
                  } else if(_passwordCtrl.text != _confirmPasswordCtrl.text){
                    return 'Password and confirm password do not match';
                  }
                  return null;
                }, onChanged: (value) {  },
              ),
              FormField(
                initialValue: _isChecked,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value){
                  if(value == false){
                    return 'Please accept the terms and policies';
                  }
                  return null;
                },
                builder: (state){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: state.value,
                            onChanged: (newValue){
                              state.didChange(newValue);
                              setState(() {
                                _isChecked = newValue!;
                              });
                            },
                            activeColor: ColorThemes.primaryAccent,
                            side: BorderSide(
                                color: ColorThemes.border,
                                width: 1.5
                            ),
                          ),
                          RichText(
                              text: TextSpan(
                                  text: 'I agree to the ',
                                  style: TextStyle(
                                      color: ColorThemes.textSecondary,
                                      fontSize: FontSizeThemes.regularFont
                                  ),
                                  children: [
                                    TextSpan(
                                        text: 'Terms of Service ',
                                        style: TextStyle(
                                            color: ColorThemes.primaryAccent
                                        ),
                                        children: [
                                          TextSpan(
                                              text: 'and ',
                                              style: TextStyle(
                                                  color: ColorThemes.textSecondary
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Privacy Policy',
                                                  style: TextStyle(
                                                      color: ColorThemes.primaryAccent
                                                  ),
                                                )
                                              ]
                                          )
                                        ]
                                    ),
                                  ]
                              )
                          )
                        ],
                      ),
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            state.errorText!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '',
                            style: const TextStyle(fontSize: 12),
                          ),
                        )
                    ],
                  );
                }
              ),
              SizedBox(height: 20.h,),
              Builder(
                builder: (context) {
                  return Center(
                    child: ElevatedButton(
                        onPressed: () => _signupAction(context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorThemes.primaryAccent,
                            minimumSize: Size(double.infinity, 50.h),
                            maximumSize: Size(double.infinity, 50.h)
                        ),
                        child: state.isSubmitting ? Center(child: LoadingAnimationWidget.waveDots(color: Colors.black, size: 30)) :
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: FontSizeThemes.mediumFont,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                  );
                }
              ),
            ],
          ),
        );
      }
    );
  }

  void _signupAction(BuildContext context) {
    final isValid = _validateKey.currentState!.validate();

    if(isValid){
      context.read<AuthFormBloc>().add(SignUpPressed());
    } else{
      return;
    }
  }

  void _navigateToVerifyPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider.value(
              value: context.read<AuthFormBloc>(),
              child: VerifyEmailPage(),
            ),
      ),
    );
  }
}


