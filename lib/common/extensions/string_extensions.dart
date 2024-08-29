import 'package:class_cloud/common/utils/regex.dart';

extension StringX on String {
  String capitalize() {
    if (isNotEmpty) {
      return "${this[0].toUpperCase()}${substring(1)}";
    }
    return '';
  }

  String lastNChars(int n) {
    if (length < n) {
      return this;
    } else {
      return substring(length - n);
    }
  }

  /// Removes characters in the [regexFilter]
  String clear({required String regexFilter}) =>
      replaceAll(RegExp(regexFilter), '');

  /// Get the first number (floating point or int) from a string. Strips commas from the number.
  String getFirstNumber() =>
      RegExp(AppRegex.NUMBERS_REGEX_PATTERN, multiLine: true)
          .firstMatch(replaceAll(',', ''))
          ?.group(0) ??
      '';

  /// Simple function to extract a double from the string. Returns [defaultValue] if string is not valid.
  double toDouble({double defaultValue = 0.0}) =>
      double.tryParse(this) ?? defaultValue;

  bool caseInsensitiveContains(String otherString) =>
      toLowerCase().contains(otherString.toLowerCase());

  String get guidNum => '0x${toUpperCase().substring(4, 8)}';
}

extension NullableStringX on String? {
  bool get isNotEmptyOrNull {
    if (this == null) return false;
    return this!.isNotEmpty;
  }
}
