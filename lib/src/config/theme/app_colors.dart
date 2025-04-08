// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

abstract class AppColors {
  static const _paleSky = Color(0xff657685);
  static const greenLatern = Color(0xff5eb837);
  static Color borderGrey = _paleSky.withOpacity(.4);
  static const white = Color(0xffFFFFFF);
  static Color boxGrey = white.withOpacity(.4);
  static const forestGreen = Color(0xff228B22);
  static const orange = Color(0xffFFA500);
  static Color orangeWithOpacity = const Color(0xffFFA500).withOpacity(0.8);
  static Color gold = const Color(0xffFFD700).withOpacity(0.8);
  static Color itemGreen = const Color(0xff4CAF50).withOpacity(0.7);
  static Color blueIndigo = const Color(0xff3F51B5).withOpacity(0.7);
  static Color purple = const Color(0xff9C27B0).withOpacity(0.7);
  static Color cian = const Color(0xff00BCD4).withOpacity(0.7);
  static const grey = Color(0xff808080);
  static Color greyWithOpacityV4 = const Color(0xff808080).withOpacity(.4);
  // static const Color _terciaryColor = Color(0xffFF5722);
  static Color whiteWithOpacity14 = white.withOpacity(0.14);
  static const _greenEsmerald = Color(0xff45ada2);
  static const _greyLider = Color(0xff898989);
  static const _blackComponent = Colors.black;
  static Color lightGray = const Color(0xffF1F1F1);
  static Color red = Colors.red;
  static Color getPrimaryColor() {
    return greenLatern;
  }

  static Color getSecondaryColor() {
    return _greenEsmerald;
  }

  static Color getTerciaryColor() {
    return _greyLider;
  }

  static Color getFourthgColor() {
    return _blackComponent;
  }

  static Color getFourthgColorWithOpacity() {
    return _blackComponent.withOpacity(0.8);
  }

  static Color primaryColorWithOpacity() {
    return _greenEsmerald.withOpacity(0.8);
  }
}

extension Colorss on BuildContext {
  ThemeData get _theme {
    return Theme.of(this);
  }

  Color primaryColor() {
    return _theme.primaryColor;
  }
}
