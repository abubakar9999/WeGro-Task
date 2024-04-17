import 'package:flutter/material.dart' as mat;
import 'package:flutter/material.dart';

class App {
  double? _height;
  double? _width;
  double? _originalWidth;
  double? _heightPadding;
  double? _widthPadding;

  App(context) {
    mat.MediaQueryData _queryData = mat.MediaQuery.of(context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _originalWidth = _queryData.size.width;
    _heightPadding = _height! - ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding = _width! - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height! * v;
  }

  double appWidth(double v) {
    return _width! * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding! * v;
  }

  double appHorizontalPadding(double v) {
    return _widthPadding! * v;
  }

  double aspectRatioValue(double v) {
    return _originalWidth! / v;
  }
}

class ConfigColors {
  static Color secondColor = const Color(0xFF344968);
  static Color mainPrimaryColor = const Color(0xFF24338A);
  static Color scaffoldDarkColor = const Color(0xFF2C2C2C);
  static Color secondDarkColor = const Color(0xFFccccdd);
  static Color whiteGrey = const Color(0xFFEEEEEE);
  static Color accentDarkColor = const Color(0xFF9999aa);
  static Color lightGrey = const Color(0xFF686868);
  static Color scaffoldColor = const Color(0xFFFAFAFA);
  static Color accentColor = const Color(0xFF8C98A8);
  static Color greenColor = const Color(0xFF0EAC9F);
  static Color yellow = const Color(0xFFFFA200);
  static Color grayWhite = const Color(0xFFEEEEEE);
  static Color iconColor = const Color(0xFF2B2B2B);
  static Color placeholderColor = const Color(0xFFCACACA);
  static Color containerBgColor = const Color(0xFFF7F6FB);
  static Color selectedItemColor = const Color(0xFF24338A);

  static Color mainColor = mat.Colors.white;
  static Color errorColor = const Color.fromARGB(255, 173, 48, 48);
}

class AppAssets {
  static const demoUser = "assets/img/user_demo.jpg";
}
