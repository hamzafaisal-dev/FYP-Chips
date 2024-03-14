import 'package:development/business%20logic/blocs/autofill/autofill_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/presentation/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/firebase_options.dart';
import 'package:development/presentation/themes/theme.dart';
import 'package:development/route_generator.dart';
import 'package:development/services/navigation_service.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ChipBloc()),
        BlocProvider(create: (context) => AutofillBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => MaterialApp(
          title: 'Chips',
          debugShowCheckedModeBanner: false,
          theme: CustomAppTheme.lightTheme,
          themeMode: ThemeMode.system,
          onGenerateRoute: RouteGenerator.generateRoutes,
          navigatorKey: NavigationService.navigatorKey,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
