import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_finder_app/features/auth/presentation/widgets/submit_button.dart';

import '../../../../core/themes/main_theme.dart';
import '../widgets/sign_up/infomation_field.dart';
import '../widgets/sign_up/password_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

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
            _formSignUp(),
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
                    onTap: (){},
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

  Widget _formSignUp(){
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
            },
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
          SubmitButton(
              title: 'Sign Up',
              onPressed: () => _signupAction()
          ),
        ],
      ),
    );
  }

  void _signupAction() {
    final isValid = _validateKey.currentState!.validate();

    if(isValid){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text('Đang đăng nhập')),
            backgroundColor: ColorThemes.primaryAccent,
          )
      );
    } else{
      return;
    }
  }
}


