import 'dart:io';

import 'package:intl/intl.dart';

class Helpers {
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

  static String formatExpiryDateString(String dateString) {
    DateTime expiryDate = DateTime.parse(dateString);
    DateTime now = DateTime.now();

    if (expiryDate.year == now.year &&
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
}
