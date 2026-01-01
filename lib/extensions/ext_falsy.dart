import 'ext_string.dart';

/// Returns [fallback] when [falsable] is `null` or considered falsy.
///
/// Otherwise, returns [falsable].
///
/// This function provides JavaScript-like falsy behavior in Dart.
T falsy<T>(T? falsable, T fallback) {
  return falsable == null
      ? fallback
      : falsable.isFalsy
      ? fallback
      : falsable;
}

/// Extension for bools
extension ExtBool on bool? {
  /// Returns `false` when [value] is `null`.
  bool get orFalse => this ?? false;

  /// Returns `true` when [value] is `null`.
  bool get orTrue => this ?? true;
}

/// Extension that adds falsy/truthy helpers to nullable values.
extension ExtFalsy<T> on T? {
  /// Returns this value if it is truthy, otherwise returns [fallback].
  ///
  /// Example:
  /// ```dart
  /// final name = userInput.or('Anonymous');
  /// ```
  T or(T fallback) {
    return falsy(this, fallback);
  }

  /// Returns `true` if this value is considered falsy.
  ///
  /// Falsy rules:
  /// - `null`
  /// - `false`
  /// - empty `String`
  /// - numeric zero
  /// - empty `Iterable`
  /// - empty `Map`
  bool get isFalsy {
    final v = this;

    if (v == null) return true;
    if (v is bool) return v == false;
    if (v is String) return v.isBlank;
    if (v is num) return v == 0;
    if (v is Iterable) return v.isEmpty;
    if (v is Map) return v.isEmpty;

    return false;
  }

  /// Returns `true` if this value is not falsy.
  bool get isTruthy => !isFalsy;

  /// Returns this value only if [condition] is `true`.
  ///
  /// Otherwise, returns `null`.
  ///
  /// Example:
  /// ```dart
  /// token.onlyIf(isLoggedIn);
  /// ```
  T? onlyIf(bool? condition) {
    if (condition == true) return this;
    return null;
  }

  /// Returns this value only if [value] is truthy.
  ///
  /// Useful for implicit dependency checks.
  ///
  /// Example:
  /// ```dart
  /// userId.dependsOn(session);
  /// ```
  T? dependsOn<R>(R? value) {
    return onlyIf(value.isTruthy);
  }
}
