import 'dart:async';

import 'package:flutter/material.dart';

import 'ext_string.dart';

extension ExtTextController on TextEditingController {
  /// Calls [callback] after the user stops typing for [duration].
  ///
  /// This is a simple debounce mechanism for text input.
  /// Example:
  /// ```dart
  /// controller.debounce((text) {
  ///   print("User typed: $text");
  /// }, Duration(milliseconds: 500));
  /// ```
  void debounce(
    void Function(String text) callback, [
    Duration duration = const Duration(seconds: 1),
  ]) {
    Timer? timer;
    addListener(() {
      timer?.cancel();
      timer = Timer(duration, () {
        callback(text.trim());
      });
    });
  }

  /// Converts the current text value of the controller to a [DateTime] object.
  ///
  /// Returns null if the text is blank or cannot be parsed as a date.
  DateTime? toDate() {
    return text.toDate();
  }
}
