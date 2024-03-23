import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Durations.short1, () {
      BlocProvider.of<AuthCubit>(context).checkIfUserAlreadySignedIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is AuthUserAlreadySignedIn) {
          HelperWidgets.showSnackbar(
            context,
            "Welcome back, ${state.user.name}!🎉",
            "success",
          );
          Future.delayed(Durations.extralong4, () {
            NavigationService.routeToReplacementNamed('/layout');
          });
        }
        if (state is AuthUserNotAlreadySignedIn) {
          Future.delayed(Durations.extralong4, () {
            NavigationService.routeToReplacementNamed('/login');
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Lottie.asset(
              AssetPaths.splashScreenAnimationPath,
              repeat: true,
              width: 270.w,
              frameRate: FrameRate.max,
            ),
          ),
        );
      },
    );
  }
}
