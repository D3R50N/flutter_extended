extension ExtStream<T> on Stream<T> {
  /// Merges this stream with another [b] stream sequentially.
  ///
  /// First, emits all events from this stream, then emits all events from [b].
  ///
  /// Note: This is **not concurrent merging** — events from the second stream
  /// only start after the first stream completes.
  ///
  /// Example:
  /// ```dart
  /// final s1 = Stream.fromIterable([1, 2]);
  /// final s2 = Stream.fromIterable([3, 4]);
  /// final merged = s1.merge(s2); // emits 1,2,3,4 in order
  /// ```
  Stream<T> merge(Stream<T> b) async* {
    yield* this;
    yield* b;
  }
}
