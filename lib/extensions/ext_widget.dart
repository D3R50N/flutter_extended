import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extended/utils/color.dart';

export 'ext_textstyle.dart';

extension ExtWidget on Widget {
  /// Wraps this widget in a [SliverToBoxAdapter], useful for slivers in CustomScrollView.
  Widget sliver() => SliverToBoxAdapter(child: this);

  /// Wraps this widget with padding of [v] on all sides.
  Widget withPadding(double v) =>
      Padding(padding: EdgeInsets.all(v), child: this);

  /// Wraps this widget with symmetric padding: horizontal [h], vertical [v].
  Widget withSymPadding({double h = 0, double v = 0}) => Padding(
    padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
    child: this,
  );

  /// Centers this widget.
  Widget center() => Center(child: this);

  /// Wraps this widget with [Expanded] with optional [flex].
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  /// Adds an onTap gesture using [InkWell] over a transparent [Material].
  Widget onTap(VoidCallback callback) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: callback,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: this,
      ),
    );
  }

  /// Adds an onLongPress gesture using [InkWell] over a transparent [Material].
  Widget onLongPress(VoidCallback callback) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onLongPress: callback,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: this,
      ),
    );
  }

  /// Creates a list containing [n] copies of this widget.
  List<Widget> operator *(int n) => List.generate(n, (_) => this);
}

extension ExtText on Text {
  /// Highlights parts of the text matching [regex] with [specialStyle] and adds an optional [onTap] callback.
  ///
  /// Example:
  /// ```dart
  /// Text("Hello *world*!").specialText(
  ///   regex: r'\*(.*?)\*',
  ///   specialStyle: TextStyle(fontWeight: FontWeight.bold),
  ///   onTap: (index, text) => print("Tapped $text at $index"),
  /// );
  /// ```
  Widget specialText({
    required String regex,
    TextStyle? specialStyle,
    void Function(int index, String text)? onTap,
  }) {
    final textStr = data ?? '';
    final matches = RegExp(regex).allMatches(textStr).toList();

    if (matches.isEmpty) return this;

    final spans = <TextSpan>[];
    int lastIndex = 0;

    final style = TextStyle(color: Colors.black).merge(this.style);

    for (final match in matches) {
      final index = matches.indexOf(match);
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: textStr.substring(lastIndex, match.start),
            style: style,
          ),
        );
      }

      final t = match.group(1);

      spans.add(
        TextSpan(
          text: t,
          recognizer:
              TapGestureRecognizer()
                ..onTap = () {
                  if (t != null && onTap != null) {
                    onTap(index, t);
                  }
                },
          style: style.merge(specialStyle),
        ),
      );

      lastIndex = match.end;
    }

    if (lastIndex < textStr.length) {
      spans.add(TextSpan(text: textStr.substring(lastIndex), style: style));
    }

    return RichText(text: TextSpan(children: spans, style: style));
  }

  /// Boldens text wrapped in asterisks (*text*). Optional [onTap] callback.
  Widget withBold({void Function(int index, String text)? onTap}) {
    return specialText(
      regex: r'\*(.*?)\*',
      onTap: onTap,
      specialStyle: TextStyle(fontWeight: FontWeight.w700),
    );
  }

  /// Styles text hashtags (#tag) with bold and blue color. Optional [onTap] callback.
  Widget withTags({void Function(int index, String text)? onTap}) {
    return specialText(
      regex: r'#(.*?)',
      onTap: onTap,
      specialStyle: TextStyle(fontWeight: FontWeight.w600, color: blue),
    );
  }

  /// Returns a new [Text] widget with the given [style], preserving other properties.
  Text styled(TextStyle style) {
    return Text(
      data ?? '',
      key: key,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
