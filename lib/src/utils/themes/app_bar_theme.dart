import 'package:admin_side/src/constants/colors.dart';
import 'package:flutter/material.dart';

class TAppBarTheme {
  static AppBarTheme lightAppBarTheme = const AppBarTheme(
    backgroundColor: tbgColor,
    centerTitle: true,
    elevation: 10,
    foregroundColor: ttextColor,
    titleTextStyle: TextStyle(
      fontSize: 20,
      color: ttextColor,
    ),
  );

  static AppBarTheme darkAppBarTheme = const AppBarTheme(
    backgroundColor: tbgDarkColor,
    centerTitle: true,
    elevation: 10,
    foregroundColor: ttextDarkColor,
    titleTextStyle: TextStyle(
      fontSize: 20,
      color: ttextDarkColor,
    ),
  );
}
