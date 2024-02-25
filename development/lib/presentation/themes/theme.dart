import 'package:development/presentation/themes/custom_themes/app_bar_theme.dart';
import 'package:development/presentation/themes/custom_themes/divider_theme.dart';
import 'package:development/presentation/themes/custom_themes/filled_button_theme.dart';
import 'package:development/presentation/themes/custom_themes/text_themes.dart';
import 'package:flutter/material.dart';

// For instructions on how to use color scehem, refer to: https://m3.material.io/styles/color/roles

class CustomAppTheme {
  static ThemeData lightTheme = ThemeData(
    //
    useMaterial3: true,

    colorScheme: const ColorScheme(
      //
      brightness: Brightness.light,

      surface: Colors.white,
      onSurface: Color(0XFF573353),

      primary: Color(0XFFFFBA7C),
      onPrimary: Color(0XFF573353),
      primaryContainer: Color(0XFFFFF3E9), //0XFFFDA758
      onPrimaryContainer: Color(0XFFFFBA7C),

      secondary: Color(0XFFEFE0DA),
      onSecondary: Color(0XFF573353),
      secondaryContainer: Color(0XFFAA98A8),

      error: Color(0XFFF65B4E),
      onError: Color(0XFFFEEFEE),

      background: Colors.grey, // to be decided
      onBackground: Colors.grey, // to be decided
    ),

    scaffoldBackgroundColor: const Color(0XFFFFF3E9),

    appBarTheme: CustomAppbarTheme.lightAppbarTheme,

    textTheme: CustomTextTheme.lightTextTheme,

    filledButtonTheme: CustomFilledButtonTheme.lightFilledButtonTheme,

    dividerTheme: CustomDividerTheme.lightDividerTheme,
  );

  // to be implemented
  // static ThemeData darkTheme = ThemeData();
}
