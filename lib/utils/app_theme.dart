import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  static const String fontFamilyPoppins = "Poppins";
  static ColorScheme colorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    primaryColorDark: Colors.blue.shade800,
    accentColor: Colors.red.shade800,
  );
  static LinearGradient gradientTBContactUs = LinearGradient(
    colors: [
      HexColor("#ffcbb8"),
      HexColor("#ff807e"),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [0.0, 1.0],
    tileMode: TileMode.clamp,
  );

  static LinearGradient gradientLR = LinearGradient(
    colors: [
      HexColor("#ff343f"),
      HexColor("#167bc3"),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: const [0.0, 1.0],
    tileMode: TileMode.clamp,
  );
  static LinearGradient gradientTB = LinearGradient(
    colors: [
      HexColor("#ff343f"),
      HexColor("#167bc3"),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [0.0, 1.0],
    tileMode: TileMode.clamp,
  );
  static BoxDecoration backgroundGradient = BoxDecoration(
    gradient: gradientTB,
  );
}
