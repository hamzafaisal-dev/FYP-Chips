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
