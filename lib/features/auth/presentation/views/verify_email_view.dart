import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_form/auth_form_event.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_form/auth_form_state.dart';

import '../../../../core/themes/main_theme.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthFormBloc, AuthFormState>(
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Check your email',
                  style: TextStyle(
                      color: ColorThemes.textPrimary,
                      fontSize: FontSizeThemes.bigTitleFont,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 15.h,),
                RichText(
                  text: TextSpan(
                      text: 'We sent a code to ',
                      style: TextStyle(
                        color: ColorThemes.textSecondary,
                        fontSize: FontSizeThemes.regularFont,
                      ),
                      children: [
                        TextSpan(
                            text: 'user@gmail.com',
                            style: TextStyle(
                              color: ColorThemes.primaryAccent,
                              fontSize: FontSizeThemes.regularFont,
                            ),
                            children: [
                              TextSpan(
                                text: '. Enter it below to verify your account.',
                                style: TextStyle(
                                  color: ColorThemes.textSecondary,
                                  fontSize: FontSizeThemes.regularFont,
                                ),
                              )
                            ]
                        )
                      ]
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 30.h,),
                Builder(
                  builder: (context) {
                    return _buildPinput();
                  }
                ),
                SizedBox(height: 30.h,),
                Center(
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        color: ColorThemes.iconBackground,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time_filled_rounded, color: ColorThemes.primaryAccent, size: 15,),
                        SizedBox(width: 10.w,),
                        Text(
                          'Resend code in 00:30',
                          style: TextStyle(
                            color: ColorThemes.primaryAccent,
                            fontSize: FontSizeThemes.regularFont,
                            fontWeight: FontWeight.bold,

                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 150.h,),
                ElevatedButton(
                    onPressed: (){
                      if(state.otpCode != null){
                        context.read<AuthFormBloc>().add(VerifyEmailPressed());
                        Navigator.popUntil(context, (route) => route.isFirst);
                      }
                      else{
                        if (kDebugMode) {
                          print('Otp null');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorThemes.primaryAccent,
                        minimumSize: Size(double.infinity, 60)
                    ),
                    child: state.isSubmitting ? Center(child: LoadingAnimationWidget.waveDots(color: ColorThemes.primaryAccent, size: 30)) : Text('Verify', style: TextStyle(fontSize: FontSizeThemes.mediumFont, fontWeight: FontWeight.bold),)
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPinput(){
    final defaultPinTheme = PinTheme(
        width: 56,
        height: 72,
        textStyle: TextStyle(
            fontSize: FontSizeThemes.bigTitleFont,
            color: ColorThemes.textPrimary,
            fontWeight: FontWeight.bold
        ),
        decoration: BoxDecoration(
          color: ColorThemes.iconBackground,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.transparent),
        )
    );

    final focusedPinTheme = defaultPinTheme.copyBorderWith(
        border: Border.all(
          color: ColorThemes.primaryAccent,
        )
    );

    final submitPinTheme = defaultPinTheme.copyDecorationWith(
        color: const Color(0xFF1A3828)
    );

    return Pinput(
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submitPinTheme,
      autofocus: true,
      keyboardType: TextInputType.number,
      onCompleted: (value){
      },
      onChanged: (value){
        context.read<AuthFormBloc>().add(OtpCodeChanged(value));
      },
    );
  }
}
