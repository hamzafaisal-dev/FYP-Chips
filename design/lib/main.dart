import 'package:design/pages/add_chip_form.dart';
import 'package:design/pages/settings/alert_settings.dart';
import 'package:design/pages/bin.dart';
import 'package:design/pages/main_pages.dart';
import 'package:design/pages/settings.dart';
import 'package:design/pages/edit_profile.dart';
import 'package:design/pages/settings/about_us.dart';
import 'package:design/pages/settings/change_password_settings.dart';
import 'package:design/pages/settings/preferences_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Color(0xff1c485f),
          primaryContainer: Color(0xff113142),
          secondary: Color(0xfffeffff),
          secondaryContainer: Color(0xfffeffff),
          surface: Color(0xff86c7e0),
          surfaceTint: Color(0xff86c7e0),
          background: Color(0xfffeffff),
        ),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Color(0xfffeffff),
          surfaceTintColor: Color(0xfffeffff),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xfffeffff),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Color(0xfffeffff),
        ),
      ),

      title: 'design',
      debugShowCheckedModeBanner: false,
      // home: const ExperimentingPage(),
      initialRoute: '/mainPages',
      routes: {
        '/mainPages': (context) => const MainPages(),
        '/settings': (context) => const Settings(),
        '/bin': (context) => const BinPage(),
        '/alertSettings': (context) => const AlertSettings(),
        '/addChipForm': (context) => const AddChipFormPage(),
        '/editProfile': (context) => const EditProfile(),
        '/preferences': (context) => const PreferencesSettings(),
        '/changePassword': (context) => const ChangePasswordSettings(),
        '/aboutUs': (context) => const AboutUs(),
      },
    );
  }
}
