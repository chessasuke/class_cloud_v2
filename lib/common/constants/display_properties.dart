import 'package:class_cloud/common/constants/app_colors.dart';
import 'package:class_cloud/core/design_system/text_style.dart';
import 'package:flutter/material.dart';

class DisplayProperties {
  /// Deafult Main Content Values
  static const radius8 = 8.0;
  static const radius16 = 16.0;
  static const bodyFontSize = 16.0;
  static const bodyFontSizeSmall = 14.0;
  static const titleFontSize = 18.0;
  static const textFieldFullHeight = 50.0;
  static const defaultPaddingValue = 16.0;
  static const mainContentHorizontalPadding = 20.0;
  static const mainContentVerticalPadding = 20.0;

  static const mainBottomPadding = 48.0;
  static const mainTopPadding = 32.0;
  static const defaultBorderRadius = 8.0;
  static const defaultBorderWidth = 0.33;
  static const iconSize = 35.0;
  static const bottomNavigationBarHeight = 58.0;
  static const elevation = 8;

  // Text Fields
  static final OutlineInputBorder baseBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(defaultBorderRadius),
  );

  static final OutlineInputBorder errorBorder = baseBorder.copyWith(
    borderSide: const BorderSide(
      color: AppColors.redStrong,
      width: 1.5,
    ),
  );
  static final OutlineInputBorder unfocusedBorder = baseBorder.copyWith(
    borderSide: const BorderSide(width: defaultBorderWidth),
  );
  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    gapPadding: 1,
    borderSide: const BorderSide(color: AppColors.black100),
    borderRadius: BorderRadius.circular(8),
  );

  // static const defaultPaddingValue = 10.0;

  /// Applies a padding of horizontal: 16.0, vertical: 8.0
  static const defaultPadding =
      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);

  static const profileAvatarRadius = 35.0;

  static const cardsBoxShadow = BoxShadow(
    color: AppColors.grayNeutral300,
    blurRadius: 2.0,
    spreadRadius: 1.0,
  );

  static final ratingInputDecoration = InputDecoration(
    hintStyle: TextStyles.heading03,
    fillColor: Colors.white,
    filled: true,
    focusColor: AppColors.grayNeutral300,
    contentPadding: EdgeInsets.zero,
  );

  static final pagesPadding = const EdgeInsets.only(
    top: DisplayProperties.mainBottomPadding,
    bottom: DisplayProperties.mainBottomPadding,
  ).add(
    const EdgeInsets.symmetric(
      horizontal: DisplayProperties.mainContentHorizontalPadding,
    ),
  );
}
