extension ExtMap<K, V> on Map<K, V> {
  /// Checks if the map contains a non-null value for the given [key].
  ///
  /// Returns `true` only if the key exists and the value is not null.
  bool has(K key) {
    return containsKey(key) && this[key] != null;
  }

  /// Returns the string representation of the value associated with [key].
  ///
  /// If the key does not exist or the value is null, returns an empty string.
  String string(K key) {
    return this[key]?.toString() ?? '';
  }

  /// Returns a new map containing only the entries where the value
  /// satisfies the [test] predicate.
  ///
  /// Example:
  /// ```dart
  /// final filtered = map.whereValue((v) => v > 10);
  /// ```
  Map<K, V> whereValue(bool Function(V v) test) =>
      Map.fromEntries(entries.where((e) => test(e.value)));

  /// Returns a new map containing only the entries where the key
  /// satisfies the [test] predicate.
  ///
  /// Example:
  /// ```dart
  /// final filtered = map.whereKey((k) => k.startsWith('A'));
  /// ```
  Map<K, V> whereKey(bool Function(K k) test) =>
      Map.fromEntries(entries.where((e) => test(e.key)));
}
