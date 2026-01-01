import 'package:flutter/material.dart';

extension ExtDecoration on InputDecoration {
  /// Returns a new [InputDecoration] created by merging `this`
  /// with the given [other] decoration.
  ///
  /// Non-null values from [other] override the corresponding values
  /// of the current decoration.
  InputDecoration mergeWith(InputDecoration? other) {
    if (other == null) return this;

    return copyWith(
      icon: other.icon ?? icon,
      labelText: other.labelText ?? labelText,
      labelStyle: other.labelStyle ?? labelStyle,
      hintText: other.hintText ?? hintText,
      hintStyle: other.hintStyle ?? hintStyle,
      helperText: other.helperText ?? helperText,
      helperStyle: other.helperStyle ?? helperStyle,
      errorText: other.errorText ?? errorText,
      errorStyle: other.errorStyle ?? errorStyle,
      prefixText: other.prefixText ?? prefixText,
      suffixText: other.suffixText ?? suffixText,
      prefixStyle: other.prefixStyle ?? prefixStyle,
      suffixStyle: other.suffixStyle ?? suffixStyle,
      prefixIcon: other.prefixIcon ?? prefixIcon,
      suffixIcon: other.suffixIcon ?? suffixIcon,
      counterText: other.counterText ?? counterText,
      counterStyle: other.counterStyle ?? counterStyle,
      isDense: other.isDense ?? isDense,
      contentPadding: other.contentPadding ?? contentPadding,
      filled: other.filled ?? filled,
      fillColor: other.fillColor ?? fillColor,
      focusColor: other.focusColor ?? focusColor,
      hoverColor: other.hoverColor ?? hoverColor,
      enabled: other.enabled && enabled,
      alignLabelWithHint: other.alignLabelWithHint ?? alignLabelWithHint,
      floatingLabelBehavior:
          other.floatingLabelBehavior ?? floatingLabelBehavior,
      border: other.border ?? border,
      enabledBorder: other.enabledBorder ?? enabledBorder,
      focusedBorder: other.focusedBorder ?? focusedBorder,
      errorBorder: other.errorBorder ?? errorBorder,
      focusedErrorBorder: other.focusedErrorBorder ?? focusedErrorBorder,
      constraints: other.constraints ?? constraints,
      semanticCounterText: other.semanticCounterText ?? semanticCounterText,
    );
  }

  /// Merges a list of [InputDecoration] instances from left to right.
  ///
  /// Later decorations in the list take priority over earlier ones.
  static InputDecoration mergeAll(List<InputDecoration?> list) {
    return list.fold<InputDecoration>(
      const InputDecoration(),
      (acc, d) => acc.mergeWith(d),
    );
  }

  /// Creates a copy of this [InputDecoration] with the same [border]
  /// applied to all border states.
  ///
  /// This includes:
  /// - default border
  /// - enabled border
  /// - focused border
  /// - error border
  /// - focused error border
  InputDecoration copyWithBorder(InputBorder? border) {
    return copyWith(
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border,
      focusedErrorBorder: border,
    );
  }
}
