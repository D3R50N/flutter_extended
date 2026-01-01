import 'package:flutter/material.dart';

/// A simple wrapper around [Text] widget that applies a predefined [TextStyle].
///
/// This widget is useful when you want to reuse a specific text style consistently
/// throughout your app without repeatedly merging styles or applying them manually.
class StyledText extends StatelessWidget {
  /// Creates a [StyledText] widget.
  ///
  /// [text] is the string to display.
  /// [style] is the text style to apply.
  /// Optional parameters allow further customization:
  /// - [align] sets the text alignment.
  /// - [maxLines] limits the number of lines.
  /// - [overflow] determines how overflowed text is displayed.
  /// - [textDirection] sets the text reading direction.
  /// - [locale] sets the locale for formatting.
  /// - [softWrap] indicates whether text should wrap at soft line breaks.
  /// - [strutStyle] provides strut style for vertical spacing.
  const StyledText(
    this.text,
    this.style, {
    super.key,
    this.align,
    this.maxLines,
    this.overflow,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.strutStyle,
  });

  /// The text string to display.
  final String text;

  /// The text style to apply.
  final TextStyle style;

  /// The alignment of the text within its container.
  final TextAlign? align;

  /// Maximum number of lines for the text.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The text reading direction.
  final TextDirection? textDirection;

  /// The locale used to select region-specific glyphs.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// Strut style to define minimum line height and vertical spacing.
  final StrutStyle? strutStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
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
}
