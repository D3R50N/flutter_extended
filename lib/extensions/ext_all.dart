import 'package:flutter/material.dart';

extension ExtAll<T> on T {
  /// Returns `true` if this value exists in the given [list].
  ///
  /// Example:
  /// ```dart
  /// 3.isIn([1, 2, 3]); // true
  /// ```
  bool isIn(List<T> list) {
    return list.contains(this);
  }

  /// Returns `true` if this value does NOT exist in the given [list].
  ///
  /// Example:
  /// ```dart
  /// 4.isNotIn([1, 2, 3]); // true
  /// ```
  bool isNotIn(List<T> list) {
    return !list.contains(this);
  }

  /// Safely casts this value to type [R].
  ///
  /// Returns `null` if the cast is not possible instead of throwing an error.
  ///
  /// Example:
  /// ```dart
  /// final value = 'hello'.asOrNull<String>(); // 'hello'
  /// final number = 'hello'.asOrNull<int>(); // null
  /// ```
  R? asOrNull<R>() => this is R ? this as R : null;

  /// Prints this value to the debug console with an optional [tag].
  ///
  /// The output is colorized (white) for better readability in logs.
  ///
  /// Example:
  /// ```dart
  /// user.debug('UserState');
  /// ```
  void debug([String? tag]) {
    debugPrint('\x1B[37m[${tag ?? runtimeType}] $this\x1B[0m');
  }
}
