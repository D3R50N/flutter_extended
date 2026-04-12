import 'package:flutter/material.dart';
import 'package:flutter_extended/utils/color.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

import 'ext_date.dart';

extension ExtString on String {
  /// Truncates the string to a maximum of [max] characters and adds "..." if needed.
  String trunc([int max = 20]) {
    String out = this;
    return out.length > max ? "${out.substring(0, max - 3)}..." : out;
  }

  /// Converts the string to a normalized ID (lowercase, underscores, no spaces or special chars)
  String get asId => trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_');

  /// Converts the string to a URL-friendly slug.
  ///
  /// Removes accents, trims, replaces non-word characters with "-", removes duplicate hyphens.
  String get asSlug => noAccent
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'[^\w]+'), '-')
      .replaceAll(RegExp(r'-+'), '-')
      .replaceAll(RegExp(r'^-|-$'), '');

  /// Converts the string to an integer.
  int get toInt => int.parse(this);

  /// Converts the string to a double.
  double get toDouble => double.parse(this);

  /// Removes accents from the string.
  String get noAccent {
    final withAccent = this;
    final accents = 'áàâãäåçéèêëíìîïñóòôõöúùûüýÿÁÀÂÃÄÅÇÉÈÊËÍÌÎÏÑÓÒÔÕÖÚÙÛÜÝ';
    final without = 'aaaaaaceeeeiiiinooooouuuuyyAAAAAACEEEEIIIINOOOOOUUUUY';

    var result = withAccent;
    for (var i = 0; i < accents.length; i++) {
      result = result.replaceAll(accents[i], without[i]);
    }

    return result;
  }

  /// Checks if the string matches a URL pattern.
  bool get isUrl {
    final urlPattern = RegExp(
      r'^(https?:\/\/)?' // optional scheme
      r'([a-zA-Z0-9.-]+(\.[a-zA-Z]{2,})+)' // domain
      r'(:\d+)?' // optional port
      r'(\/[^\s]*)?$', // optional path
      caseSensitive: false,
    );
    return urlPattern.hasMatch(this);
  }

  /// Converts the string to a [Uri], adding "https://" if missing.
  Uri get uri {
    String v = this;
    if (!v.contains("://")) v = "https://$v";
    return Uri.parse(v);
  }

  /// Returns the value of a query parameter [key] from the string URL.
  String? uriQuery(String key) => uri.queryParameters[key];

  /// Opens the string URL in an external browser application.
  Future<bool> openUrl() async {
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  /// Attempts to detect the date format of the string.
  String get dateFormat {
    final formats = {
      r'^\d{2}/\d{2}/\d{4}$': 'dd/MM/yyyy',
      r'^\d{2}-\d{2}-\d{4}$': 'dd-MM-yyyy',
      r'^\d{4}-\d{2}-\d{2}$': 'yyyy-MM-dd',
      r'^\d{2}/\d{4}$': 'MM/yyyy',
      r'^\d{4}/\d{2}$': 'yyyy/MM',
      r'^\d{4}$': 'yyyy',
      r'^\d{2}-\d{4}$': 'MM-yyyy',
      r'^\d{4}-\d{2}$': 'yyyy-MM',
      r'^\d{2} \w+ \d{4}$': 'dd MMMM yyyy',
      r'^[A-Za-zéèêëîïôöûüàäçÉÈÊËÎÏÔÖÛÜÀÂÄÇ]+ \d{4}$': 'MMMM yyyy',
      r'^[A-Za-zéèêëîïôöûüàäçÉÈÊËÎÏÔÖÛÜÀÂÄÇ]{3,}\.? \d{4}$': 'MMM yyyy',
    };

    for (final entry in formats.entries) {
      if (RegExp(entry.key).hasMatch(this)) {
        return entry.value;
      }
    }
    return '';
  }

  /// Returns `true` if the string is blank or contains only whitespace.
  bool get isBlank => trim().isEmpty;

  /// Returns `true` if the string is not blank.
  bool get isNotBlank => trim().isNotEmpty;

  /// Converts the string to a [DateTime] object, using auto-detected or standard formats.
  DateTime? toDate() {
    if (isBlank) return null;

    return DateTime.tryParse(this) ??
        intl.DateFormat(dateFormat).tryParse(this);
  }

  /// Returns the string formatted as a date using [format].
  String? toDateFormat([String format = "dd MMM yyyy"]) {
    return toDate()?.format(pattern: format);
  }

  /// Converts a hex string to a [Color].
  Color get color => ColorHex(this);

  /// Converts the string into a list of strings, assuming it is a stringified list.
  ///
  /// Example: `"[a, b, c]"` → `["a", "b", "c"]`
  List<String> get listString {
    final str = this;
    if (str.isBlank) return [];
    return str
        .substring(1, str.length - 1)
        .split(',')
        .map((e) => e.replaceAll("\"", "").trim())
        .toList();
  }

  /// Returns a pluralized version of the string based on [length].
  ///
  /// If [showLength] is true, prepends the number.
  String toPlural(int length, [bool showLength = true]) {
    return '${showLength ? "$length" : ""} $this${length > 1 && !endsWith("s")
        ? endsWith("y")
            ? "ies"
            : "s"
        : ""}';
  }

  /// Capitalizes the first letter of the string.
  String get cap {
    if (isBlank) return "";
    final trimmed = trim();
    return trimmed[0].toUpperCase() + trimmed.substring(1);
  }

  /// Makes the first letter of the string lowercase.
  String get uncap {
    if (isBlank) return "";
    final trimmed = trim();
    return trimmed[0].toLowerCase() + trimmed.substring(1);
  }

  /// Returns a lowercase version of this string.
  ///
  /// Example:
  /// ```dart
  /// "Hello".lower; // "hello"
  /// ```
  String get lower => toLowerCase();

  /// Returns an uppercase version of this string.
  ///
  /// Example:
  /// ```dart
  /// "hello".upper; // "HELLO"
  /// ```
  String get upper => toUpperCase();

  /// Returns a random character from this string.
  ///
  /// The string is split into characters, shuffled, then the first one is returned.
  ///
  /// Example:
  /// ```dart
  /// "hello".random(); // could return "h", "e", "l", etc.
  /// ```
  String random() {
    final splitted = split('');
    splitted.shuffle();
    return splitted.first;
  }
}
