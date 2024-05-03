import 'package:development/presentation/screens/about_us_screen.dart';
import 'package:development/presentation/screens/add_chip_screen_1.dart';
import 'package:development/presentation/screens/add_chip_screen_2.dart';
import 'package:development/presentation/screens/change_password_screen.dart';
import 'package:development/presentation/screens/likes_screen.dart';
import 'package:development/presentation/screens/notifications_screen.dart';
import 'package:development/presentation/screens/app_layout.dart';
import 'package:development/presentation/screens/applied_chips_screen.dart';
import 'package:development/presentation/screens/edit_profile_screen.dart';
import 'package:development/presentation/screens/favorite_chips_screen.dart';
import 'package:development/presentation/screens/home_screen.dart';
import 'package:development/presentation/screens/posted_chips_screen.dart';
import 'package:development/presentation/screens/preferences_screen.dart';
import 'package:development/presentation/screens/sign_in_screen.dart';
import 'package:development/presentation/screens/otp_screen.dart';
import 'package:development/presentation/screens/user_chips_scree.dart';
import 'package:development/presentation/screens/user_profile_screen.dart';
import 'package:development/presentation/screens/reset_password_screen.dart';
import 'package:development/presentation/screens/settings_screen.dart';
import 'package:development/presentation/screens/sign_up_screen.dart';
import 'package:development/presentation/screens/splash_screen.dart';
import 'package:development/presentation/screens/view_chip_details_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
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

      case '/about-us':
        return MaterialPageRoute(
          builder: (context) => const AboutUsScreen(),
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

      case '/change-password':
        Map<String, dynamic>? receivedArguments =
            settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(
            arguments: receivedArguments,
          ),
        );

      case '/settings':
        return MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        );

      case '/notifications':
        {
          Map<String, dynamic>? receivedArguments =
              settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) =>
                NotificationsScreen(arguments: receivedArguments),
          );
        }

      case '/otp':
        {
          Map<String, dynamic>? receivedArguments =
              settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) => OtpScreen(arguments: receivedArguments),
          );
        }

      case '/edit-profile':
        {
          Map<String, dynamic>? receivedArguments =
              settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) =>
                EditProfileScreen(arguments: receivedArguments),
          );
        }

      case '/user_profile':
        {
          Map<String, dynamic>? receivedArguments =
              settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) =>
                UserProfileScreen(arguments: receivedArguments),
          );
        }

      case '/prefences':
        return MaterialPageRoute(
          builder: (context) => const PreferencesScreen(),
        );

      case '/reset-password':
        return MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
        );

      case '/favorite-chip':
        return MaterialPageRoute(
          builder: (context) => const FavoriteChipScreen(),
        );

      case '/posted-chip':
        return MaterialPageRoute(
          builder: (context) => const PostedChipScreen(),
        );

      case '/applied-chip':
        return MaterialPageRoute(
          builder: (context) => const AppliedChipScreen(),
        );

      case '/likes-screen':
        {
          Map<String, dynamic>? receivedArguments =
              settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) => LikeScreen(arguments: receivedArguments),
          );
        }

      case '/user-chips-screen':
        {
          // Map<String, dynamic>? receivedArguments =
          //     settings.arguments as Map<String, dynamic>?;

          return MaterialPageRoute(
            builder: (context) => const UserChipsScreen(),
          );
        }

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
