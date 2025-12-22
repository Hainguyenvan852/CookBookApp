import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/main_theme.dart';

class BackgroundImgAndTitle extends StatelessWidget {
  const BackgroundImgAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h,),
        SizedBox(
          width: double.infinity,
          height: 200.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (rect) {
                return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black,
                      Colors.transparent
                    ],
                    stops: [0.6, 1]
                ).createShader(rect);
              },
              child: Image.asset('lib/core/images/login-image-2.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          'Welcome Back, Chef',
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
          'Log in to access your saved recipes and\n continue your culinary journey.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorThemes.textSecondary,
            fontSize: FontSizeThemes.smallFont,
          ),
        ),
      ],
    );
  }
}
