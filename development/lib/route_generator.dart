import 'package:development/presentation/screens/login_screen.dart';
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
