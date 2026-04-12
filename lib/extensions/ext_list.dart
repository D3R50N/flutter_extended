import 'dart:math';

import 'package:flutter/material.dart';

import 'ext_string.dart';

extension ExtList<T> on List<T> {
  /// Repeats this list [count] times.
  ///
  /// Example:
  /// ```dart
  /// [1, 2] * 3; // [1, 2, 1, 2, 1, 2]
  /// ```
  List<T> operator *(int count) {
    final List<T> out = [];
    for (var i = 0; i < count; i++) {
      out.addAll(this);
    }
    return out;
  }

  /// Performs a text-based search on the list.
  ///
  /// Items that **start with** the search text are returned first,
  /// followed by items that **contain** the text.
  ///
  /// A custom [mapper] can be provided to control how items
  /// are converted to searchable strings.
  List<T> searchText(String text, [String Function(T)? mapper]) {
    final map = this.map(mapper ?? (e) => e.toString()).toList();

    text = text.toLowerCase().trim().noAccent;

    final List<T> start = [];
    final List<T> contains = [];

    for (var i = 0; i < map.length; i++) {
      final v = map[i].toLowerCase().trim().noAccent;

      if (v.startsWith(text)) {
        start.add(this[i]);
      } else if (v.contains(text)) {
        contains.add(this[i]);
      }
    }

    return [...start, ...contains];
  }

  /// Adds [value] to the list only if it does not already exist.
  void addToSet(T value) {
    if (!contains(value)) add(value);
  }

  /// Adds [value] to the list only if it is not null.
  void addIfNotNull(T? value) {
    if (value != null) add(value);
  }

  /// Converts the list into a human-readable sentence.
  ///
  /// Supports truncation with a remaining count suffix.
  ///
  /// Example:
  /// ```dart
  /// ['A', 'B', 'C', 'D'].toSentence(maxToShow: 2);
  /// // "A, B & 2 others"
  /// ```
  String toSentence({
    int? maxToShow,
    String separator = ",",
    String lastSeparator = "&",
    String suffix = "others",
  }) {
    maxToShow ??= length;

    if (isEmpty || maxToShow <= 0) return "";
    if (length == 1) return first.toString();

    final show = min(maxToShow, length);
    final remaining = length - show;

    if (remaining <= 0) {
      var out = "";
      for (var i = 0; i < show; i++) {
        out += this[i].toString();

        if (i < show - 2) {
          out += "$separator ";
        } else if (i == show - 2) {
          out += " $lastSeparator ";
        }
      }
      return out;
    }

    var out = "";
    for (var i = 0; i < show; i++) {
      out += this[i].toString();
      if (i <= show - 2) {
        out += "$separator ";
      }
    }

    if (out.isNotEmpty) {
      out += " $lastSeparator ";
    }

    out += "$remaining $suffix";
    return out;
  }
}

extension IterableExt<T> on Iterable<T> {
  /// Returns the first element that matches [test],
  /// or `null` if none match.
  T? find(bool Function(T e) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }

  /// Maps elements with access to their index.
  ///
  /// Example:
  /// ```dart
  /// list.mapIndexed((i, e) => '$i: $e');
  /// ```
  List<R> mapIndexed<R>(R Function(int i, T e) fn) {
    var i = 0;
    return map((e) => fn(i++, e)).toList();
  }

  /// Groups elements by a computed key.
  ///
  /// Example:
  /// ```dart
  /// users.groupBy((u) => u.role);
  /// ```
  Map<K, List<T>> groupBy<K>(K Function(T e) key) {
    final map = <K, List<T>>{};
    for (final e in this) {
      map.putIfAbsent(key(e), () => []).add(e);
    }
    return map;
  }

  /// Returns a sorted iterable based on a computed key.
  ///
  /// Set [desc] to `true` for descending order.
  Iterable<T> sortedBy(Comparable Function(T e) key, {bool desc = false}) {
    final list =
        toList()..sort((a, b) => key(a).compareTo(key(b)) * (desc ? -1 : 1));
    return list;
  }

  /// Returns the shuffled list
  List<T> get shuffled {
    final list = toList();
    list.shuffle();
    return list;
  }

  /// Returns a random element
  T random() {
    return shuffled.first;
  }

  /// Converts this iterable to a [Set].
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 2, 3].toSet(); // {1, 2, 3}
  /// ```
  List<T> toUnique() => Set<T>.from(this).toList();
}

extension ExtListBool on List<bool> {
  /// Returns `true` if all values are `true`.
  bool allTrue() {
    for (final v in this) {
      if (v == false) return false;
    }
    return true;
  }

  /// Returns `true` if at least one value is `true`.
  bool anyTrue() {
    for (final v in this) {
      if (v == true) return true;
    }
    return false;
  }

  /// Returns `true` if all values are `false`.
  bool allFalse() {
    for (final v in this) {
      if (v == true) return false;
    }
    return true;
  }

  /// Returns `true` if at least one value is `false`.
  bool anyFalse() {
    for (final v in this) {
      if (v == false) return true;
    }
    return false;
  }
}

extension ExtListWidget on List<Widget> {
  /// Wraps this widget list into a [Column].
  Widget column({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    double spacing = 0.0,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      spacing: spacing,
      children: this,
    );
  }

  /// Wraps this widget list into a [Row].
  Widget row({
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    double spacing = 0.0,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      spacing: spacing,
      children: this,
    );
  }

  /// Wraps this widget list into a [Stack].
  Widget stack({
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return Stack(
      alignment: alignment,
      fit: fit,
      clipBehavior: clipBehavior,
      children: this,
    );
  }

  /// Builds a [Column] with a separator widget between items.
  Widget columnSeparated(Widget separator) {
    return Column(
      children: [
        for (var i = 0; i < length; i++) ...[if (i > 0) separator, this[i]],
      ],
    );
  }

  /// Builds a [Row] with a separator widget between items.
  Widget rowSeparated(
    Widget separator, {
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    double spacing = 0.0,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      spacing: spacing,
      children: [
        for (var i = 0; i < length; i++) ...[if (i > 0) separator, this[i]],
      ],
    );
  }
}

extension ExtItNum<T extends num> on Iterable<T> {
  /// Returns the sum of all elements in the iterable.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].sum(); // 6
  /// ```
  num sum() {
    return fold(0, (prev, el) => prev + el);
  }

  /// Returns the maximum value in the iterable.
  ///
  /// Throws a [StateError] if the iterable is empty.
  ///
  /// Example:
  /// ```dart
  /// [1, 5, 3].max(); // 5
  /// ```
  T max() {
    if (isEmpty) {
      throw StateError('Cannot get max of an empty iterable');
    }
    return reduce((a, b) => a > b ? a : b);
  }

  /// Returns the minimum value in the iterable.
  ///
  /// Throws a [StateError] if the iterable is empty.
  ///
  /// Example:
  /// ```dart
  /// [1, 5, 3].min(); // 1
  /// ```
  T min() {
    if (isEmpty) {
      throw StateError('Cannot get min of an empty iterable');
    }
    return reduce((a, b) => a < b ? a : b);
  }
}
