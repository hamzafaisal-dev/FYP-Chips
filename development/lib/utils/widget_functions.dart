import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class HelperWidgets {
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
      // Default to error type if the provided toast type is not recognized
      type = ToastificationType.error;
      primaryColor = Colors.redAccent;
      iconData = Icons.error;
    }

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
}
