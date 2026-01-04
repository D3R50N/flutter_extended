import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension ExtNum on num {
  /// Converts this number into a vertical or horizontal gap widget.
  ///
  /// Example:
  /// ```dart
  /// 16.gap; // Equivalent to Gap(16.0)
  /// ```
  Widget get gap => Gap(toDouble());

  /// Creates a circular [BorderRadius] or a uniform [Border] with this number as radius or width.
  BorderRadius get radius => BorderRadius.circular(toDouble());

  /// Creates a uniform [Border] with this number as width.
  Border border({Color color = Colors.black}) =>
      Border.all(color: color, width: toDouble());

  

  /// Returns this number clamped to a minimum value [min].
  num clampMin(num min) => this < min ? min : this;

  /// Returns this number clamped to a maximum value [max].
  num clampMax(num max) => this > max ? max : this;

  /// Returns an integer if this number is whole, otherwise returns itself.
  ///
  /// Example:
  /// ```dart
  /// 5.0.value; // 5
  /// 5.2.value; // 5.2
  /// ```
  num get value => this == round() ? round() : this;

  /// Alias for [value].
  num get v => value;

  /// Pads the number with a leading zero if it is less than 10.
  ///
  /// Example:
  /// ```dart
  /// 5.padZero; // "05"
  /// 12.padZero; // "12"
  /// ```
  String get padZero => v.toString().padLeft(2, "0");

  /// Checks if this number is within the interval [a, b].
  ///
  /// Use [excludeA] or [excludeB] to make the interval open at either end.
  bool isInInterval(
    num a,
    num b, {
    bool excludeA = false,
    bool excludeB = false,
  }) {
    if (excludeA && this == a) return false;
    if (excludeB && this == b) return false;
    return this >= a && this <= b;
  }

  /// Converts this number to a [Duration] in days.
  Duration get durD => Duration(days: toInt());

  /// Converts this number to a [Duration] in hours.
  Duration get durH => Duration(hours: toInt());

  /// Converts this number to a [Duration] in minutes.
  Duration get durMin => Duration(minutes: toInt());

  /// Converts this number to a [Duration] in seconds.
  Duration get durS => Duration(seconds: toInt());

  /// Converts this number to a [Duration] in milliseconds.
  Duration get durMs => Duration(milliseconds: toInt());

  /// Rounds this number to [decimals] decimal places.
  ///
  /// Example:
  /// ```dart
  /// 3.14159.roundTo(2); // 3.14
  /// ```
  double roundTo(int decimals) {
    final f = pow(10, decimals);
    return (this * f).round() / f;
  }
}
