import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFED801);
const Color onPrimaryColor = Color(0xFFFADB06);
const Color secondaryColor = Color(0x0f060000);
const Color shimmerBaseColor = Color(0xFFE0E0E0);
const Color shimmerHighligtColor = Color(0xFFF5F5F5);
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
const int itemsPerPage = 3;

ThemeData feedMeThemeData(BuildContext context) => ThemeData(
      colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: primaryColor,
            onPrimary: onPrimaryColor,
            secondary: secondaryColor,
          ),
      scaffoldBackgroundColor: Colors.white70,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        color: Colors.amber[400],
        elevation: 0,
      ),
      textTheme: feedMeTextTheme,
      elevatedButtonTheme: feedMeElevatedButtonThemeData,
    );

final TextTheme feedMeTextTheme = TextTheme(
  displayLarge: GoogleFonts.lobsterTwo(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.lobsterTwo(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall:
      GoogleFonts.lobsterTwo(fontSize: 46, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.lobsterTwo(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall:
      GoogleFonts.lobsterTwo(fontSize: 23, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.lobsterTwo(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.lobsterTwo(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.lobsterTwo(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.ebGaramond(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.ebGaramond(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.ebGaramond(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.ebGaramond(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.ebGaramond(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
final ElevatedButtonThemeData feedMeElevatedButtonThemeData =
    ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: blackColor,
    textStyle: const TextStyle(),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
  ),
);
