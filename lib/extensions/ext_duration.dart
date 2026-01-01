extension ExtDuration on Duration {
  /// Formats this duration as `HH:mm:ss`.
  ///
  /// Example:
  /// ```dart
  /// Duration(seconds: 3661).formatHHMMSS; // "01:01:01"
  /// ```
  String get formatHHMMSS {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(inHours);
    final minutes = twoDigits(inMinutes.remainder(60));
    final seconds = twoDigits(inSeconds.remainder(60));

    return "$hours:$minutes:$seconds";
  }

  /// Formats this duration as `mm:ss`.
  ///
  /// Useful for timers, audio/video players, or countdowns.
  ///
  /// Example:
  /// ```dart
  /// Duration(seconds: 125).formatMMSS; // "02:05"
  /// ```
  String get formatMMSS {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = twoDigits(inMinutes);
    final seconds = twoDigits(inSeconds.remainder(60));

    return "$minutes:$seconds";
  }

  /// Delays execution for the duration of this [Duration].
  ///
  /// Example:
  /// ```dart
  /// await 2.seconds.wait();
  /// ```
  Future<void> wait() async {
    await Future.delayed(this);
  }

  /// Returns a [DateTime] representing this duration added to now.
  ///
  /// Example:
  /// ```dart
  /// final expiresAt = 10.minutes.fromNow();
  /// ```
  DateTime fromNow() {
    return DateTime.now().add(this);
  }
}
