import 'package:admin_side/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  //light text theme
  static TextTheme lightTextTheme = TextTheme(
    titleLarge: GoogleFonts.montserrat(
      color: ttextColor,
      fontWeight: FontWeight.bold,
      fontSize: 32,
    ),
    titleMedium: GoogleFonts.montserrat(
      color: ttextColor,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    titleSmall: GoogleFonts.montserrat(
      color: ttextColor,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    bodyLarge: GoogleFonts.openSans(
      color: ttextColor,
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.openSans(
      color: ttextColor,
      fontSize: 14,
    ),
    bodySmall: GoogleFonts.openSans(
      color: ttextColor,
      fontSize: 12,
    ),
  );

  //dark text theme
  static TextTheme darkTextTheme = TextTheme(
    titleLarge: GoogleFonts.montserrat(
      color: ttextDarkColor,
      fontWeight: FontWeight.bold,
      fontSize: 32,
    ),
    titleMedium: GoogleFonts.montserrat(
      color: ttextDarkColor,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    titleSmall: GoogleFonts.montserrat(
      color: ttextDarkColor,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    bodyLarge: GoogleFonts.openSans(
      color: ttextDarkColor,
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.openSans(
      color: ttextDarkColor,
      fontSize: 14,
    ),
    bodySmall: GoogleFonts.openSans(
      color: ttextDarkColor,
      fontSize: 12,
    ),
  );
}
