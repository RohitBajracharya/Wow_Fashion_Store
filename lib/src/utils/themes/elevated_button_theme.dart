import 'package:admin_side/src/constants/colors.dart';
import 'package:admin_side/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      foregroundColor: ttextDarkColor,
      backgroundColor: tbuttonColor,
      side: const BorderSide(color: tbuttonColor),
      padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
    ),
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      foregroundColor: ttextDarkColor,
      backgroundColor: tbuttonDarkColor,
      side: const BorderSide(color: tbuttonDarkColor),
      padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
    ),
  );
}
