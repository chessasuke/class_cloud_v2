// ignore_for_file: constant_identifier_names

class AppRegex {
  static const decimalNum4Digits = r'^(?=\D*(?:\d\D*){1,4}$)\d+(?:\.\d{1})?$';

  static const EMAIL_REGEX_PATTERN =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const NAME_REGEX_PATTERN = r'^[a-zA-Z\s-]+$';
  static const NUMBER_REGEX_PATTERN = r'^[0-9]+$';

  /// Matches floats or ints. Number must not contain commas (e.g., "1,234.56" matches ["1", "234.56"])
  static const NUMBERS_REGEX_PATTERN = r'[-+]?(?:\d*\.\d+|\d+)';

  static const EMAIL_REGEX_INVALID_CHARS = '[^0-9a-zA-Z@._\\+-]';
  static const PASSWORD_ALLOW_CHAR = r"[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{}'"
      r';:"\\|,.<>\/?]';
  static const PASSWORD_REGEX_PATTERN =
      r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+\=\[\]{};:'\\|,.<>\/?"
      r'"]).{8,}$';
}
