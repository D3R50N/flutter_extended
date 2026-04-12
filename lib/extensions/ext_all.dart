import 'package:flutter/material.dart';
import 'package:flutter_extended/widgets/styled_text.dart';

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
      toString(),
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
        toString(),
        key: Key(toString()),
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
      toString(),
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
}
