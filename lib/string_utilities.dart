import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StringUtils {
  static RichText getBoldPortionMessage(
      String normal0, String bold, String normal1,
      {double? textSize = 14.0, Color? textColor = Colors.black}) {
    return RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: textSize,
            color: textColor,
          ),
          children: <TextSpan>[
            TextSpan(text: normal0),
            TextSpan(
                text: ' $bold ',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: normal1),
          ]),
    );
  }

  static RichText getBoldPortionMessageNoSpaces(
      String normal0, String bold, String normal1,
      {double? textSize = 14.0, Color? textColor = Colors.black}) {
    return RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: textSize,
            color: textColor,
          ),
          children: <TextSpan>[
            TextSpan(text: normal0),
            TextSpan(
                text: bold,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: normal1),
          ]),
    );
  }

  static String getSpaces(int count) {
    return ' ' * count;
  }

  static String formatDateMdyy(String date) {
    return DateFormat('M/d/yy').format(DateTime.parse(date));
  }
}
