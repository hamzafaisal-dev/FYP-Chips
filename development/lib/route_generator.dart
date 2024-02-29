import 'package:development/presentation/screens/add_chip_screen_1.dart';
import 'package:development/presentation/screens/add_chip_screen_2.dart';
import 'package:development/presentation/screens/app_layout.dart';
import 'package:development/presentation/screens/home_screen.dart';
import 'package:development/presentation/screens/login_screen.dart';
import 'package:development/presentation/screens/profile_screen.dart';
import 'package:development/presentation/screens/reset_password_screen.dart';
import 'package:development/presentation/screens/settings_screen.dart';
import 'package:development/presentation/screens/signup_screen.dart';
import 'package:development/presentation/screens/view_chip_details_screen.dart';
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

      case '/layout':
        return MaterialPageRoute(
          builder: (context) => const AppLayout(),
        );

      case '/home':
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case '/add-chip1':
        return MaterialPageRoute(
          builder: (context) => const AddChipScreen1(),
        );

      case '/add-chip2':
        {
          // extracts the arguments from the current AddResourceScreen settings and cast them as a Map.
          Map<String, dynamic>? receivedArguments =
              settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) => AddChipScreen2(arguments: receivedArguments),
          );
        }

      case '/view-chip':
        {
          Map<String, dynamic>? receivedArguments =
              settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) =>
                ChipDetailsScreen(arguments: receivedArguments),
          );
        }

      case '/settings':
        return MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        );

      case '/profile':
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
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
