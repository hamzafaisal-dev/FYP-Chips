import 'package:design/Presentation/Screens/add_chip_screen.dart';
import 'package:design/Presentation/Screens/chip_details_screen.dart';
import 'package:design/Presentation/Screens/Settings%20Screens/alert_settings_screen.dart';
import 'package:design/Presentation/Screens/bin_screen.dart';
import 'package:design/Presentation/Screens/main_screen.dart';
import 'package:design/Presentation/Screens/settings_screen.dart';
import 'package:design/Presentation/Screens/edit_profile_screen.dart';
import 'package:design/Presentation/Screens/Settings%20Screens/about_us_screen.dart';
import 'package:design/Presentation/Screens/Settings%20Screens/change_password_screen.dart';
import 'package:design/Presentation/Screens/Settings%20Screens/preferences_screen.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
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
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: const ColorScheme.light(
      //     primary: Color(0xff1c485f),
      //     primaryContainer: Color(0xff113142),
      //     secondary: Color(0xfffeffff),
      //     secondaryContainer: Color(0xfffeffff),
      //     surface: Color(0xff86c7e0),
      //     surfaceTint: Color(0xff86c7e0),
      //     background: Color(0xfffeffff),
      //   ),
      //   appBarTheme: const AppBarTheme(
      //     systemOverlayStyle: SystemUiOverlayStyle.dark,
      //     backgroundColor: Color(0xfffeffff),
      //     surfaceTintColor: Color(0xfffeffff),
      //   ),
      //   bottomSheetTheme: const BottomSheetThemeData(
      //     backgroundColor: Color(0xfffeffff),
      //   ),
      //   popupMenuTheme: const PopupMenuThemeData(
      //     color: Color(0xfffeffff),
      //   ),
      // ),

      theme: FlexThemeData.light(
        scheme: FlexScheme.bigStone,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.bigStone,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
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
        '/chipDetails': (context) => const ChipDetails(),
      },
    );
  }
}
