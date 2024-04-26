import 'package:development/business%20logic/blocs/autofill/autofill_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/cubits/comment/comment_cubit.dart';
import 'package:development/business%20logic/cubits/contact_us/contact_us_cubit.dart';
import 'package:development/business%20logic/cubits/notification/notification_cubit.dart';
import 'package:development/business%20logic/cubits/shared_pref_cubit/cubit/shared_pref_cubit.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/presentation/screens/splash_screen.dart';
import 'package:development/utils/helper_functions.dart';
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
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'chips_notification_channel',
        channelName: 'Chips',
        channelDescription: 'Chips notification channel',
        playSound: true,
      ),
    ],
    debug: true,
  );

  await FlutterBranchSdk.init(
      useTestKey: false, enableLogging: false, disableTracking: false);

  // FlutterBranchSdk.validateSDKIntegration();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => ChipBloc()),
        BlocProvider(create: (context) => AutofillBloc()),
        BlocProvider(create: (context) => ContactUsCubit()),
        BlocProvider(create: (context) => SharedPrefCubit()),
        BlocProvider(create: (context) => CommentCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                Helpers.getStatusBarIconBrightness(context),
            statusBarBrightness: Helpers.getStatusBarBrightness(context),
          ),
          child: MaterialApp(
            title: 'Chips',
            debugShowCheckedModeBanner: false,
            theme: CustomAppTheme.lightTheme,
            themeMode: ThemeMode.light,
            onGenerateRoute: RouteGenerator.generateRoutes,
            navigatorKey: NavigationService.navigatorKey,
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
