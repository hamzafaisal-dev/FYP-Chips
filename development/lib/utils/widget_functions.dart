import 'package:development/constants/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

class HelperWidgets {
  // custom snackbar fucntion
  static void showSnackbar(
      BuildContext context, String toastContent, String toastType) {
    ToastificationType type;
    Color primaryColor;
    IconData iconData;

    if (toastType.toLowerCase() == 'success') {
      type = ToastificationType.success;
      primaryColor = Colors.green;
      iconData = Icons.check;
    } else if (toastType.toLowerCase() == 'error') {
      type = ToastificationType.error;
      primaryColor = Colors.redAccent;
      iconData = Icons.error;
    } else if (toastType.toLowerCase() == 'info') {
      type = ToastificationType.info;
      primaryColor = Colors.blueAccent;
      iconData = Icons.info;
    } else {
      type = ToastificationType.error;
      primaryColor = Colors.redAccent;
      iconData = Icons.error;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 4, milliseconds: 320),
      title: Text(toastContent),
      alignment: Alignment.bottomCenter,
      animationDuration: const Duration(milliseconds: 180),
      icon: Icon(
        iconData,
        color: Colors.white,
      ),
      primaryColor: primaryColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      showProgressBar: false,
      borderRadius: BorderRadius.all(Radius.circular(12.r)),
    );
  }

  static void showAutofillDialog(BuildContext context, String dialogText) {
    showAdaptiveDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            // backgroundColor: Colors.transparent,
            // shadowColor: Colors.transparent,
            // surfaceTintColor: Colors.transparent,

            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      AssetPaths.womanSittingAnimationPath,
                      frameRate: FrameRate(420),
                    ),
                    Text(
                      dialogText,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
                const Positioned(
                  left: 0.8,
                  right: 0.8,
                  top: 50,
                  child: LinearProgressIndicator(minHeight: 30),
                ),
              ],
            ),
          );
        });
  }

  static void showProfanityDialog(BuildContext context) {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return Dialog(
            // backgroundColor: Colors.transparent,
            // shadowColor: Colors.transparent,
            // surfaceTintColor: Colors.transparent,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  AssetPaths.angryTomatoAnimationPath,
                  // repeat: false,
                  frameRate: FrameRate(200),
                ),
                Text(
                  'Profanity Detected',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Text(
                    "Our system has detected some profanity in your input. Please re-check and remove all such instances to create a safe space for all users.",
                    textAlign: TextAlign.center),
                SizedBox(height: 20.h),
              ],
            ),
          );
        });
  }
}
