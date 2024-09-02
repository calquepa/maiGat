import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF272727);

  static final TextTheme textTheme = GoogleFonts.openSansTextTheme().copyWith(
    bodyLarge: GoogleFonts.openSans(fontSize: 16.0, fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.w400),
    bodySmall: GoogleFonts.openSans(fontSize: 12.0, fontWeight: FontWeight.w400),
    headlineLarge: GoogleFonts.openSans(fontSize: 16.0, fontWeight: FontWeight.w600),
    headlineMedium: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.w600),
    headlineSmall: GoogleFonts.openSans(fontSize: 12.0, fontWeight: FontWeight.w600),
  );
}