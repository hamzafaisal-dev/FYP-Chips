import 'dart:io';
import 'dart:ui';
import 'package:development/constants/network_urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class Helpers {
  // Get the brightness of the status bar icon
  static Brightness getStatusBarIconBrightness(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? Brightness.dark : Brightness.light;
  }

  // Get the brightness of the status bar
  static Brightness getStatusBarBrightness(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? Brightness.light : Brightness.dark;
  }

  static String formatTimeAgo(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else {
      return 'on ${dateTime.day}-${dateTime.month}-${dateTime.year}';
    }
  }

  static String addLeadingZero(int number) {
    return number.toString().padLeft(2, '0');
  }

  // formats given String to yyyy-mm-dd format
  static DateTime? formatDate(String dateString) {
    try {
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parseStrict(dateString);
      String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
      return DateTime.parse(formattedDate);
    } catch (e) {
      return null;
    }
  }

  static String formatDateTimeString(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat formatter =
        DateFormat('MMMM d, yyyy'); // Change format as needed
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  static String formatExpiryDateString(String dateString) {
    DateTime expiryDate = DateTime.parse(dateString);
    DateTime now = DateTime.now();

    if (now.year >= expiryDate.year &&
        now.month >= expiryDate.month &&
        now.day > expiryDate.day) {
      return 'Already expired 😔';
    } else if (expiryDate.year == now.year &&
        expiryDate.month == now.month &&
        expiryDate.day == now.day) {
      return 'Expires today';
    } else if (expiryDate.year == now.year &&
        expiryDate.month == now.month &&
        expiryDate.day == now.day + 1) {
      return 'Expires tomorrow';
    } else {
      String formattedDate = DateFormat.yMMMMd().format(expiryDate);
      return 'Expires on $formattedDate';
    }
  }

  static String formatCommentTime(String createdAt) {
    DateTime createdDateTime = DateTime.parse(createdAt);
    DateTime currentDateTime = DateTime.now();
    Duration difference = currentDateTime.difference(createdDateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '${months}mon';
    } else {
      int years = (difference.inDays / 365).floor();
      return '${years}y';
    }
  }

  // checks if deadline is expiring in 3 days or less
  static bool expiringInThreeDays(DateTime deadline) {
    String dateString = deadline.toString();
    DateTime date = DateTime.parse(dateString);
    DateTime currentDate = DateTime.now();
    Duration difference = date.difference(currentDate);

    return difference.inDays <= 3;
  }

  static String getMimeType(File file) {
    const Map<String, String> mimeTypes = {
      'png': 'image/png',
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
    };

    // get the file extension
    final List<String> parts = file.path.split('.');
    final String extension = parts.isNotEmpty ? parts.last : '';

    // wil find the MIME type using the file extension
    final String mimeType =
        mimeTypes[extension.toLowerCase()] ?? 'application/octet-stream';

    return mimeType;
  }

  // log event
  static void logEvent(
    String userId,
    String eventType,
    List<dynamic> parameters,
  ) async {
    var eventPayload = {
      "userId": userId,
      "timestamp": DateTime.now().toIso8601String(),
      "eventType": eventType,
      "eventParameters": parameters,
    };

    try {
      http.post(
        Uri.parse(NetworkURLS.logEventUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(eventPayload),
      );
    } catch (error) {
      print('Error logging event: $error');
    }
  }
}
