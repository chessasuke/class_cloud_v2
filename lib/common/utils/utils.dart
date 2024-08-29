import 'package:flutter/widgets.dart';

class Utils {
  static Size calculateTextSize(
    String text,
    TextStyle style,
    TextScaler textScaler,
  ) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
    )..layout();
    return textPainter.size;
  }

  static double? getNumFromObject(Object? number) {
    if (number is num) {
      return number.toDouble();
    }
    return null;
  }

  static int? getIntFromNum(Object? number) {
    if (number is num) {
      return number.round();
    }
    return null;
  }
}
