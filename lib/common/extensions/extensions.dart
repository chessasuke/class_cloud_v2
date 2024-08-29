import 'dart:core';
import 'package:class_cloud/common/extensions/number_extensions.dart';
import 'package:flutter/material.dart';

extension TextEditingControllerX on TextEditingController {
  void setTextAndPreserveCursorIndex(String incomingText) {
    final numberOfCharactersCleared = text.length - incomingText.length;
    final adjustedBaseOffset = selection.baseOffset - numberOfCharactersCleared;
    final adjustedBaseOffsetInRange =
        adjustedBaseOffset.toRange(0, incomingText.length);
    final textSelectionInRange = selection.copyWith(
      baseOffset: adjustedBaseOffsetInRange,
      extentOffset: adjustedBaseOffsetInRange,
    );
    text = incomingText;
    selection = textSelectionInRange;
  }
}

extension ListX on List? {
  bool get isNullOrEmpty {
    if (this == null) return true;
    return this!.isEmpty;
  }
}