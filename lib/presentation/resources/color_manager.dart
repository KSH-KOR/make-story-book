import 'package:flutter/material.dart';

class ColorManager {
  static Color black = HexColor.fromHex("#000000");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color shadowColor = HexColor.fromHex("#000000");
  static Color darkGrey = HexColor.fromHex("#636363");
  static Color lightGrey = HexColor.fromHex("#A1A1A1");
  static Color primary = HexColor.fromHex("#03B4C3");
  static Color primaryDark = HexColor.fromHex("#058B97");
  static Color primaryVeryDark = HexColor.fromHex("#03545B");
  static Color secondary = HexColor.fromHex("#E7FEC9");

  static Color point = HexColor.fromHex("#EA6F29");

  static Color backgroundColor = HexColor.fromHex("#FFFFFF");
  static Color textFieldbackgroundColor = HexColor.fromHex("#FFFFFF");

  static Color error = HexColor.fromHex("#EA6F29");

  static Color buttonDisable = HexColor.fromHex("#F4B794");
  static Color gray1 = HexColor.fromHex("#F1F1F1");
  static Color gray2 = HexColor.fromHex("#B9B9B9");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
