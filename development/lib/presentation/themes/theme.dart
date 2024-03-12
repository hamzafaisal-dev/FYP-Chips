import 'package:development/constants/custom_colors.dart';
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
      onSurface: CustomColors.darkPurple,

      primary: CustomColors.lightOrange,
      onPrimary: CustomColors.darkPurple,
      primaryContainer: CustomColors.weirdWhite, //0XFFFDA758
      onPrimaryContainer: CustomColors.lightOrange,

      secondary: Color(0XFFEFE0DA),
      onSecondary: CustomColors.darkPurple,
      secondaryContainer: Color(0XFFAA98A8),

      error: CustomColors.errorRed,
      onError: CustomColors.onErrorRed,

      background: Colors.grey, // to be decided
      onBackground: Colors.grey, // to be decided
    ),

    scaffoldBackgroundColor: CustomColors.weirdWhite,

    appBarTheme: CustomAppbarTheme.lightAppbarTheme,

    textTheme: CustomTextTheme.lightTextTheme,

    filledButtonTheme: CustomFilledButtonTheme.lightFilledButtonTheme,

    dividerTheme: CustomDividerTheme.lightDividerTheme,

    dialogTheme: const DialogTheme(
      shadowColor: CustomColors.weirdWhite,
      backgroundColor: Colors.white,
    ),

    dialogBackgroundColor: Colors.white,
  );

  // to be implemented
  // static ThemeData darkTheme = ThemeData();
}
