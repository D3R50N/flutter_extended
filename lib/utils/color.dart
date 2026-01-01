import 'package:flutter/material.dart';

/// A utility class to create a [Color] from a hex string.
class ColorHex extends Color {
  /// Creates a Color from a hex string, e.g. "#FF0000" or "FF0000".
  ColorHex(String hex) : super(_getColorFromHex(hex));

  /// Converts a hex string to a 32-bit integer for [Color].
  static int _getColorFromHex(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 3) {
      hex = hex.split('').map((c) => '$c$c').join(); // RGB -> RRGGBB
    }

    if (hex.length == 6) {
      // If RGB, prepend full opacity (FF)
      hex = 'FF$hex';
    } else if (hex.length == 8) {
      // If ARGB provided, rearrange to match Flutter's format (AARRGGBB)
      hex = hex.substring(6, 8) + hex.substring(0, 6);
    } else {
      throw FormatException("Invalid hex color: $hex");
    }
    return int.parse(hex, radix: 16);
  }
}

/// Common predefined colors
final Color red = ColorHex("#FF0000");
final Color green = ColorHex("#00FF00");
final Color blue = ColorHex("#0000FF");
final Color black = ColorHex("#000000");
final Color white = ColorHex("#FFFFFF");
final Color transparent = ColorHex("#00000000");
final Color gray = ColorHex("#A9A9A9");
final Color lightGray = ColorHex("#D3D3D3");
final Color darkGray = ColorHex("#808080");
final Color yellow = ColorHex("#FFFF00");
final Color cyan = ColorHex("#00FFFF");
final Color magenta = ColorHex("#FF00FF");
final Color orange = ColorHex("#FFA500");
final Color purple = ColorHex("#800080");
final Color brown = ColorHex("#A52A2A");
