// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

/// A base TextStyle instance to start chaining from.
final TextStyle TS = TextStyle();

extension ExtTextStyle on TextStyle {
  // Weight shortcuts
  TextStyle get thin => w100;
  TextStyle get extraLight => w200;
  TextStyle get light => w300;
  TextStyle get regular => w400;
  TextStyle get medium => w500;
  TextStyle get semiBold => w600;
  TextStyle get bold => w700;
  TextStyle get extraBold => w800;
  TextStyle get black => w900;

  TextStyle get w100 => copyWith(fontWeight: FontWeight.w100);
  TextStyle get w200 => copyWith(fontWeight: FontWeight.w200);
  TextStyle get w300 => copyWith(fontWeight: FontWeight.w300);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
  TextStyle get w900 => copyWith(fontWeight: FontWeight.w900);

  /// Returns an italic version of the TextStyle.
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  /// Adds a text decoration (underline, lineThrough, overline)
  /// Optional [color] and [style] for the decoration.
  TextStyle decorate(
    TextDecoration decoration, {
    Color? color,
    TextDecorationStyle? style,
  }) => copyWith(
    decoration: decoration,
    decorationColor: color,
    decorationStyle: style,
  );

  /// Predefined decoration getters
  TextStyle get underline => decorate(TextDecoration.underline, color: color);
  TextStyle get lineThrough =>
      decorate(TextDecoration.lineThrough, color: color);
  TextStyle get overline => decorate(TextDecoration.overline, color: color);

  /// Sets the font size.
  TextStyle size(double value) => copyWith(fontSize: value);

  /// Sets the font family.
  TextStyle font(String family) => copyWith(fontFamily: family);

  /// Sets the text color.
  TextStyle col(Color c) => copyWith(color: c);

  /// Sets the background color.
  TextStyle bg(Color c) => copyWith(backgroundColor: c);

  /// Adds a shadow with optional [blur] and [offset].
  TextStyle shadow(
    Color c, {
    double blur = 2,
    Offset offset = const Offset(1, 1),
  }) => copyWith(shadows: [Shadow(color: c, blurRadius: blur, offset: offset)]);

  /// Sets letter spacing.
  TextStyle spaceLetter(double value) => copyWith(letterSpacing: value);

  /// Sets word spacing.
  TextStyle spaceWord(double value) => copyWith(wordSpacing: value);

  /// Sets the line height.
  TextStyle withHeight(double value) => copyWith(height: value);
  TextStyle hgt(double value) => withHeight(value); // alias
}
