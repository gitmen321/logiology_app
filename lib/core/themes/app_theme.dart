import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final ThemeData themeData = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 4, 9, 14),
    scaffoldBackgroundColor: const Color.fromARGB(255, 4, 9, 14),
  );

  final TextTheme textTheme = TextTheme(
    headlineSmall: GoogleFonts.lato(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: GoogleFonts.lato(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.lato(
      fontSize: 14,
      color: Colors.white,
    ),
  );
}