import 'package:admin_side/src/constants/colors.dart';
import 'package:flutter/material.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    prefixIconColor: tappColor,
    labelStyle: TextStyle(
      color: ttextColor.withOpacity(0.5),
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
    floatingLabelStyle: const TextStyle(color: tappColor),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: tappColor),
    ),
  );
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    prefixIconColor: tappDarkColor,
    labelStyle: TextStyle(
      color: ttextDarkColor.withOpacity(0.5),
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
    floatingLabelStyle: const TextStyle(color: tappDarkColor),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: tappDarkColor),
    ),
  );
}
