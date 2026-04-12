String twoDigits(int n) => n.toString().padLeft(2, '0');

extension ExtDuration on Duration {
  /// Formats this duration as `DD:HH:mm:ss`.
  ///
  /// Example:
  /// ```dart
  /// Duration(days: 1, hours: 2, minutes: 3, seconds: 4).formatDDHHMMSS;
  /// // "01:02:03:04"
  /// ```
  String get formatDDHHMMSS {
    final days = twoDigits(inDays);
    final hours = twoDigits(inHours.remainder(24));
    final minutes = twoDigits(inMinutes.remainder(60));
    final seconds = twoDigits(inSeconds.remainder(60));

    return "$days:$hours:$minutes:$seconds";
  }

  /// Formats this duration as `DD:HH:mm`.
  ///
  /// Example:
  /// ```dart
  /// Duration(days: 1, hours: 2, minutes: 3).formatDDHHMM;
  /// // "01:02:03"
  /// ```
  String get formatDDHHMM {
    final days = twoDigits(inDays);
    final hours = twoDigits(inHours.remainder(24));
    final minutes = twoDigits(inMinutes.remainder(60));

    return "$days:$hours:$minutes";
  }

  /// Formats this duration as `HH:mm:ss`.
  ///
  /// Hours are not capped to 24.
  ///
  /// Example:
  /// ```dart
  /// Duration(seconds: 3661).formatHHMMSS; // "01:01:01"
  /// ```
  String get formatHHMMSS {
    final hours = twoDigits(inHours);
    final minutes = twoDigits(inMinutes.remainder(60));
    final seconds = twoDigits(inSeconds.remainder(60));

    return "$hours:$minutes:$seconds";
  }

  /// Formats this duration as `mm:ss`.
  ///
  /// Useful for timers, audio, or countdowns.
  ///
  /// Example:
  /// ```dart
  /// Duration(seconds: 125).formatMMSS; // "02:05"
  /// ```
  String get formatMMSS {
    final minutes = twoDigits(inMinutes);
    final seconds = twoDigits(inSeconds.remainder(60));

    return "$minutes:$seconds";
  }

  /// Formats this duration as `ss`.
  ///
  /// Example:
  /// ```dart
  /// Duration(seconds: 5).formatSS; // "05"
  /// ```
  String get formatSS {
    return twoDigits(inSeconds);
  }

  /// Formats this duration using the most appropriate representation:
  ///
  /// - `DD:HH:mm:ss` if duration is at least 1 day
  /// - `HH:mm:ss` if duration is at least 1 hour
  /// - `mm:ss` otherwise
  ///
  /// Example:
  /// ```dart
  /// Duration(seconds: 45).format; // "00:45"
  /// ```
  String get format {
    if (inDays > 0) {
      return formatDDHHMMSS;
    } else if (inHours > 0) {
      return formatHHMMSS;
    } else {
      return formatMMSS;
    }
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

  /// Returns a [DateTime] representing this duration added to the current time.
  ///
  /// Example:
  /// ```dart
  /// final expiresAt = 10.minutes.fromNow();
  /// ```
  DateTime fromNow() {
    return DateTime.now().add(this);
  }
}
