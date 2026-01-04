import 'package:flutter/material.dart';
import 'package:flutter_extended/utils/color.dart';
import 'package:flutter_extended/widgets/styled_text.dart';
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

  /// Wraps the string in a standard [Text] widget.
  Text text({
    Key? key,
    TextStyle? style,
    TextAlign? align,
    TextOverflow? overflow,
    int? maxLines,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    StrutStyle? strutStyle,
  }) {
    return Text(
      this,
      key: key,
      style: style,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      strutStyle: strutStyle,
    );
  }

  /// Returns an [AnimatedSwitcher] that animates text changes.
  AnimatedSwitcher animatedText({
    TextStyle? style,
    TextAlign? align,
    TextOverflow? overflow,
    int? maxLines,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    StrutStyle? strutStyle,
    Duration duration = const Duration(milliseconds: 100),
    Curve switchInCurve = Curves.easeIn,
    Curve switchOutCurve = Curves.easeOut,
    bool fade = true,
    bool scale = true,
    bool slide = false,
  }) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        final slideOffset =
            slide
                ? Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(animation)
                : null;
        final slideTransition =
            slide
                ? SlideTransition(position: slideOffset!, child: child)
                : child;

        final fadeTransition =
            fade
                ? FadeTransition(opacity: animation, child: slideTransition)
                : slideTransition;

        final scaleTransition =
            scale
                ? ScaleTransition(scale: animation, child: fadeTransition)
                : fadeTransition;
        return scaleTransition;
      },
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      child: Text(
        this,
        key: Key(this),
        style: style,
        textAlign: align,
        overflow: overflow,
        maxLines: maxLines,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        strutStyle: strutStyle,
      ),
    );
  }

  /// Wraps the string in a [StyledText] widget with the given [style].
  StyledText styledText(
    TextStyle style, {
    Key? key,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    StrutStyle? strutStyle,
  }) {
    return StyledText(
      this,
      style,
      key: key,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      strutStyle: strutStyle,
    );
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
}
