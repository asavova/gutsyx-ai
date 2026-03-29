import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color electricBlue = Color(0xFF007AFF);
  static const Color metallicPurple = Color(0xFF6C5CE7);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color surfaceWhite = Color(0xFFF2F2F7);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: electricBlue,
        primary: electricBlue,
        secondary: metallicPurple,
        surface: backgroundWhite,
      ),
      scaffoldBackgroundColor: surfaceWhite,
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -1.0),
          titleLarge: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundWhite,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: electricBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: backgroundWhite,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
