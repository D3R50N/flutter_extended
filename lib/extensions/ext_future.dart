extension ExtFuture<T> on Future<T> {
  /// Retries this future up to [times] attempts if it throws an error.
  ///
  /// An optional [delay] can be applied between retries.
  /// If all attempts fail, the last captured error is thrown.
  ///
  /// Example:
  /// ```dart
  /// await apiCall().retry(3, delay: const Duration(seconds: 1));
  /// ```
  Future<T> retry(int times, {Duration delay = Duration.zero}) async {
    late Object error;

    for (var i = 0; i < times; i++) {
      try {
        return await this;
      } catch (e) {
        error = e;

        if (delay != Duration.zero) {
          await Future.delayed(delay);
        }
      }
    }

    throw error;
  }
}
