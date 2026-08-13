import 'package:flutter/services.dart';
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

  /// Checks if the string matches a valid email pattern.
  bool get isEmail {
    final emailPattern = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailPattern.hasMatch(trim());
  }

  /// Checks if the string matches a valid phone number pattern.
  bool get isPhone {
    final phonePattern = RegExp(r'^\+?[0-9\s\-()]{7,20}$');
    return phonePattern.hasMatch(trim());
  }

  /// Copies this string to the system clipboard.
  Future<void> copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: this));
  }

  /// Extracts initials from words in this string (e.g. "John Doe" -> "JD").
  String get initials {
    if (isBlank) return '';
    final words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';
    if (words.length == 1) {
      return words.first.substring(0, words.first.length.clamp(0, 2)).toUpperCase();
    }
    return '${words.first[0]}${words.last[0]}'.toUpperCase();
  }

  /// Converts the string to an integer.
  int get toInt => int.parse(this);

  /// Parses this string as an integer, or returns `null` if invalid.
  int? get toIntOrNull => int.tryParse(trim());

  /// Converts the string to a double.
  double get toDouble => double.parse(this);

  /// Parses this string as a double, or returns `null` if invalid.
  double? get toDoubleOrNull => double.tryParse(trim());

  /// Masks characters from [start] to [end] with [maskChar].
  ///
  /// Example:
  /// ```dart
  /// "123456789".mask(start: 2, end: 7); // "12*****89"
  /// ```
  String mask({int start = 0, int? end, String maskChar = '*'}) {
    if (isEmpty) return '';
    final actualEnd = (end ?? length).clamp(0, length);
    final actualStart = start.clamp(0, actualEnd);
    final prefix = substring(0, actualStart);
    final masked = maskChar * (actualEnd - actualStart);
    final suffix = substring(actualEnd);
    return '$prefix$masked$suffix';
  }

  /// Converts string to Title Case (e.g. "hello world" -> "Hello World").
  String get toTitleCase {
    if (isBlank) return '';
    return trim()
        .split(RegExp(r'\s+'))
        .map(
          (word) =>
              word.isEmpty
                  ? ''
                  : word[0].toUpperCase() + word.substring(1).toLowerCase(),
        )
        .join(' ');
  }

  /// Converts string to camelCase (e.g. "hello_world" -> "helloWorld").
  String get toCamelCase {
    if (isBlank) return '';
    final words = trim().split(RegExp(r'[\s_\-]+'));
    if (words.isEmpty) return '';
    final first = words.first.toLowerCase();
    final rest =
        words
            .skip(1)
            .map(
              (w) =>
                  w.isEmpty
                      ? ''
                      : w[0].toUpperCase() + w.substring(1).toLowerCase(),
            )
            .join();
    return '$first$rest';
  }

  /// Converts string to snake_case (e.g. "helloWorld" -> "hello_world").
  String get toSnakeCase {
    if (isBlank) return '';
    return trim()
        .replaceAllMapped(
          RegExp(r'([a-z0-9])([A-Z])'),
          (m) => '${m[1]}_${m[2]}',
        )
        .replaceAll(RegExp(r'[\s\-]+'), '_')
        .toLowerCase();
  }

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
