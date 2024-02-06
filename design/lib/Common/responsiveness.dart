import 'package:flutter/material.dart';

class Responsiveness {
  // screen width
  static double sw(context) {
    return MediaQuery.sizeOf(context).width;
  }

  // screen height
  static double sh(context) {
    return MediaQuery.sizeOf(context).height;
  }
}
