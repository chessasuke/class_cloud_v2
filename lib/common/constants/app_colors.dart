import 'dart:ui';

class AppColors {
  static const primaryColor = Color(0xFF3A2A6A);
  static const primaryLight = Color.fromRGBO(84, 64, 171, 1);
  static const lightGray = Color.fromRGBO(225, 226, 226, 1);
  static const appGreen = Color.fromRGBO(117, 207, 153, 1);
  static const appBrown = Color.fromRGBO(192, 84, 107, 1);
  static const appYellow = Color.fromRGBO(255, 177, 86, 1);

  static const black100 = Color(0xff000000);
  static const black2 = Color(0xff222222);
  static const blackOverlay2 = Color.fromRGBO(0, 0, 0, 0.6);
  static const blackSnackbarShadow = Color.fromRGBO(0, 0, 0, 0.32);
  static const blackOverlay = Color.fromRGBO(0, 0, 0, 0.75);

  static const white100 = Color(0xffffffff);

  static const completeColor = Color(0xff5e6172);
  static const inProgressColor = Color(0xff5ec792);
  static const todoColor = Color(0xffd1d2d7);

  /// grey
  static const grayNeutral50 = Color(0xfff8f8f8);
  static const grayNeutral100 = Color(0xfff1f1f1);
  static const grayNeutral200 = Color(0xffe1e1e1);
  static const grayNeutral300 = Color(0xffa1a1a1);
  static const grayNeutral400 = Color(0xff6a6a6a);
  static const grayNeutral500 = Color(0xff454545);
  static const gray2light = Color(0x80eaeaea);

  static const gray1 = Color(0xff7a7a7a);
  static const gray4 = Color(0xffababab);
  static const gray5 = Color(0xff3a3a3a);
  static const gray7 = Color(0xffd0d8dd);
  static const gray8 = Color(0xfff5f6f9);

  /// green
  static const lighterGreen = Color(0xffbadfe0);
  static const lightGreen = Color(0xff52e3c2);
  static const lightGreenSuccess100 = Color(0xffe7f6f0);
  static const lightGreenSuccess300 = Color(0xffa0dcc2);
  static const lightGreenSuccess500 = Color(0xff61C49A);

  /// yellow
  static const yellowWarning100 = Color(0xfffdf9e3);
  static const yellowWarning300 = Color(0xfffcf2bc);
  static const yellowWarning500 = Color(0xfff5d941);
  static const yeslloStrong = Color(0xfff6d016);

  /// red
  static const redError100 = Color(0xffffe6e9);
  static const redError300 = Color(0xffffc4cb);
  static const redError500 = Color(0xfffe566a);
  static const redLight = Color(0xfff27362);
  static const redDark = Color(0xffeb4d3d);
  static const redStrong = Color(0xffff2f0a);

  /// blue
  static const blue = Color(0xff0c75f1);
  static const blueLighter = Color(0xffb1eeeb);
  static const blueLight = Color(0xff6eaef9);
  static const bluePurple = Color(0xff5260fa);
  static const blueFrozen = Color(0xffa8e7f4);
  static const blueLink = Color(0xff4992a2);
  static const blueDark = Color(0xff272e79);

  /// random colors
  static const neon = Color(0xffdefa70);
  static const orange = Color(0xffFF8000);
  static const brown = Color(0xff93464d);
  static const pink = Color(0xfffcbcb6);
  static const cream = Color(0xfffaf7f4);
  static const purple1 = Color(0xff26064e);
  static const purple2 = Color(0xff675183);

  static const gradients1 = [
    Color(0xffb9f8e1),
    Color(0xffdbedd7),
    Color(0xfff1e1d7),
    Color(0xffe8f0d6),
    Color(0xff83f8f4),
    Color(0xff7ba3f8),
    Color(0xffc4bae4),
  ];

  static const gradients2 = [
    Color(0xffc4bae4),
    Color(0xffb9f8e1),
    Color(0xff83f8f4),
    Color(0xff7ba3f8),
    Color(0xffc4bae4),
  ];

  static final glassmorphismLight = [
    const Color(0xffffffff).withOpacity(0.855),
    const Color(0xffffffff).withOpacity(0.45),
  ];

  static final glassmorphismDark = [
    const Color(0xff000000).withOpacity(0.63),
    const Color(0xff000000).withOpacity(0.45),
  ];
}
