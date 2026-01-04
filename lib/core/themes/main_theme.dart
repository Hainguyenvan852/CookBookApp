import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorThemes{
  static const Color backgroundColor = Color(0xFF0C1C13);
  static const Color inputFieldBackground = Color(0xFF223C2E);
  static const Color iconBackground = Color(0xFF1C3126);
  static const Color cardBackground = Color(0xFF162921);
  static const Color primaryAccent = Color(0xFF34E87C);
  static const Color iconColor1 = Color(0xFF7CA289);
  static const Color iconColor2 = Color(0xFFA5A3C8);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8FB79F);
  static const Color border = Color(0xFF2D4E3B);
  static const Color inputFieldBackground2 = Color(0xFF1A2E24);
}

class FontSizeThemes{
  static double smallFont = 12.sp;
  static double regularFont = 14.sp;
  static double mediumFont = 18.sp;
  static double bigTitleFont = 28.sp;
}


class AppThemes{
  static ThemeData mainTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorThemes.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorThemes.backgroundColor,
      // titleTextStyle: TextStyle(
      //     color: ColorThemes.textPrimary,
      //     fontSize: FontSizeThemes.mediumFont,
      //     fontWeight: FontWeight.bold
      // ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorThemes.primaryAccent,
        foregroundColor: Colors.black
      )
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android : SlideRightToLeftTransitionBuilder()
      }
    )
  );
}

class SlideRightToLeftTransitionBuilder extends PageTransitionsBuilder {
  const SlideRightToLeftTransitionBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;

    const curve = Curves.easeInOutCubic;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}