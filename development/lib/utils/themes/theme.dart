import 'package:development/utils/themes/custom_themes/text_themes.dart';
import 'package:flutter/material.dart';

// For instructions on how to use color scehem, refer to: https://m3.material.io/styles/color/roles

class CustomAppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    colorScheme: const ColorScheme(
      //
      brightness: Brightness.light,

      surface: Color(0XFFFFF3E9),
      onSurface: Color(0XFF573353),

      primary: Color(0XFFFFBA7C),
      onPrimary: Color(0XFF573353),
      primaryContainer: Color(0XFFFFF3E9),
      onPrimaryContainer: Color(0XFFFFBA7C),

      secondary: Color(0XFFEFE0DA),
      onSecondary: Color(0XFF573353),

      error: Color(0XFFFEEFEE),
      onError: Color(0XFFF65B4E),

      background: Colors.grey, // to be decided
      onBackground: Colors.grey, // to be decided
    ),
    scaffoldBackgroundColor: const Color(0XFFFFF3E9),
    textTheme: CustomTextTheme.lightTextTheme,
  );

  // to be implemented in the future
  // static ThemeData darkTheme = ThemeData();
}
