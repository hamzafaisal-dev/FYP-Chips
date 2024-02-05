import 'package:development/presentation/screens/add_chip_screen.dart';
import 'package:development/presentation/screens/home_screen.dart';
import 'package:development/presentation/screens/login_screen.dart';
import 'package:development/presentation/screens/reset_password_screen.dart';
import 'package:development/presentation/screens/user_profile_screen.dart';
import 'package:development/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
//
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    //

    switch (settings.name) {
      //
      case '/login':
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      case '/signup':
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );

      case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case '/add-chip':
        return MaterialPageRoute(
          builder: (context) => const AddChipScreen(),
        );

      case '/profile':
        return MaterialPageRoute(
          builder: (context) => const UserProfileScreen(),
        );

      case '/reset-password':
        return MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("Not found ${settings.name}"),
            ),
          ),
        );
    }
  }
}
