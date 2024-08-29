import 'package:flutter/cupertino.dart';

class BottomSheetContentKeys {
  static const String _prefix = '__BottomSheetContentKeys__';

  static const contentWidget = ValueKey('${_prefix}contentWidget');
  static const backButton = ValueKey('${_prefix}backButton');
  static const title = ValueKey('${_prefix}title');
  static const description = ValueKey('${_prefix}description');
  static const primaryButton = ValueKey('${_prefix}primaryButton');
  static const secondaryButton = ValueKey('${_prefix}secondaryButton');
  static const trailingWidget = ValueKey('${_prefix}trailingWidget');
}
