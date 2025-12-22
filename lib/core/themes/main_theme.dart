import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorThemes{
  static const Color backgroundColor = Color(0xFF0D1712);
  static const Color inputFieldBackground = Color(0xFF223C2E);
  static const Color iconBackground = Color(0xFF1C3126);
  static const Color primaryAccent = Color(0xFF34E87C); //Nút bấm, link
  static const Color iconColor1 = Color(0xFF7CA289);
  static const Color iconColor2 = Color(0xFFA5A3C8);
  static const Color textPrimary = Color(0xFFFFFFFF); // Tiêu đề, chữ trên nút
  static const Color textSecondary = Color(0xFF97B3A0); // Mô tả, text phụ
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
    scaffoldBackgroundColor: ColorThemes.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorThemes.backgroundColor,
      titleTextStyle: TextStyle(
          color: ColorThemes.textPrimary,
          fontSize: FontSizeThemes.mediumFont,
          fontWeight: FontWeight.bold
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorThemes.primaryAccent,
        foregroundColor: Colors.black
      )
    ),
  );
}