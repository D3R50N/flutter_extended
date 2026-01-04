import 'dart:ui' show ImageFilter;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extended/utils/color.dart';

export 'ext_textstyle.dart';

extension ExtWidget on Widget {
  /// Wraps this widget in a [SliverToBoxAdapter], useful for slivers in CustomScrollView.
  Widget sliver() => SliverToBoxAdapter(child: this);

  /// Wraps this widget in a [SafeArea].
  Widget safe() => SafeArea(child: this);

  /// Wraps this widget in a [Padding] with the given values.
  /// If [all] is provided, it overrides other parameters.
  /// Example:
  /// ```dart
  /// myWidget.withPadding(all: 16);
  /// myWidget.withPadding(horizontal: 8, vertical: 16);
  /// myWidget.withPadding(top: 10, bottom: 20);
  /// ```
  Widget withPadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    if (all != null) {
      return Padding(padding: EdgeInsets.all(all), child: this);
    }

    return Padding(
      padding: EdgeInsets.only(
        top: vertical ?? top ?? 0,
        bottom: vertical ?? bottom ?? 0,
        left: horizontal ?? left ?? 0,
        right: horizontal ?? right ?? 0,
      ),
      child: this,
    );
  }

  /// Centers this widget.
  Widget center() => Center(child: this);

  /// Wraps this widget with [Expanded] with optional [flex].
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  /// Wraps this widget with [Flexible] with optional [flex] and [fit].
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  /// Wraps this widget with [Visibility] based on [isVisible].
  Widget visibility(bool isVisible) {
    return isVisible ? this : SizedBox.shrink();
  }

  /// Wraps this widget with [Offstage] based on [isOffstage].
  Widget offstage(bool isOffstage) {
    return Offstage(offstage: isOffstage, child: this);
  }

  /// Wraps this widget in a [Positioned] with the given parameters.
  Widget positioned({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: this,
    );
  }

  /// Wraps this widget in a [Positioned.fill] with the given parameters.
  Widget positionedFill({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return Positioned.fill(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: this,
    );
  }

  /// Aligns this widget with the given [alignment].
  Widget align(Alignment alignment) {
    return Align(alignment: alignment, child: this);
  }

  /// Wraps this widget in a [SizedBox] with the given [width] and/or [height].
  Widget sized({double? width, double? height}) {
    return SizedBox(width: width, height: height, child: this);
  }

  /// Wraps this widget in a square [SizedBox] with both width and height set to [size].
  Widget sizedSquare(double size) {
    return SizedBox(width: size, height: size, child: this);
  }

  /// Wraps this widget in an [AspectRatio] with the given [ratio].
  Widget aspectRatio(double ratio) {
    return AspectRatio(aspectRatio: ratio, child: this);
  }

  /// Rotates this widget by [degree] degrees. Animate if degree changes.
  Widget rotated(
    double degree, [
    Duration duration = const Duration(milliseconds: 300),
  ]) {
    return AnimatedRotation(
      turns: degree / 360,
      duration: duration,
      child: this,
    );
  }

  /// Scales this widget by [scale]. Animate if scale changes.
  Widget scaled(
    double scale, [
    Duration duration = const Duration(milliseconds: 300),
  ]) {
    return AnimatedScale(scale: scale, duration: duration, child: this);
  }

  /// Translates this widget by [offset]. Animate if offset changes.
  Widget translated(
    Offset offset, [
    Duration duration = const Duration(milliseconds: 300),
  ]) {
    return AnimatedSlide(offset: offset, duration: duration, child: this);
  }

  /// Fades this widget to the given [opacity]. Animate if opacity changes.
  Widget faded(
    double opacity, [
    Duration duration = const Duration(milliseconds: 300),
  ]) {
    return AnimatedOpacity(opacity: opacity, duration: duration, child: this);
  }

  /// Applies a blur effect to this widget with the given [sigmaX] and [sigmaY].
  Widget blurred(
    double sigmaX,
    double sigmaY, [
    Duration duration = const Duration(milliseconds: 300),
  ]) {
    return AnimatedContainer(
      duration: duration,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: this,
      ),
    );
  }

  /// Fades this widget in with the given [duration].
  Widget fadedIn([Duration duration = const Duration(milliseconds: 300)]) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: this,
    );
  }

  /// Fades this widget out with the given [duration].
  Widget fadedOut([Duration duration = const Duration(milliseconds: 300)]) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: duration,
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: this,
    );
  }

  /// Animates the visibility of this widget based on [isVisible].
  Widget visibilityAnimated(
    bool isVisible, [
    Duration duration = const Duration(milliseconds: 300),
  ]) {
    return AnimatedSwitcher(
      duration: duration,
      child: isVisible ? this : SizedBox.shrink(),
    );
  }

  /// Wraps this widget in a [Container] with the given decoration parameters.
  Widget container({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
    BoxShape shape = BoxShape.rectangle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
    BoxConstraints? constraints,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        image: image,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: gradient,
        backgroundBlendMode: backgroundBlendMode,
        shape: shape,
      ),
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      constraints: constraints,
      alignment: alignment,
      child: this,
    );
  }

  /// Wraps this widget in a [ClipRRect] with the given [borderRadius].
  /// If [borderRadius] is not provided, a circular radius of 8.0 is used.
  /// Example:
  /// ```dart
  /// myWidget.clipped(); // Default radius 8.0
  /// myWidget.clipped(borderRadius: BorderRadius.circular(16));
  /// ```
  Widget clipped({BorderRadius? borderRadius}) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      child: this,
    );
  }

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
