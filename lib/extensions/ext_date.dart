import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'ext_string.dart';

extension ExtDate on DateTime {
  /// Returns the start and end dates of the current week.
  ///
  /// The week starts on Monday and ends on Sunday.
  ///
  /// Example:
  /// ```dart
  /// final range = DateTime.now().week;
  /// final start = range.first;
  /// final end = range.last;
  /// ```
  List<DateTime> get week {
    final currentDay = DateTime(year, month, day);

    // Monday as the first day of the week
    final beginDay = weekday - 1;
    final begin = currentDay.subtract(Duration(days: beginDay));

    // Sunday as the last day of the week
    final endDay = 7 - weekday;
    final end = currentDay.add(Duration(days: endDay));

    return [begin, end];
  }

  /// Checks whether this date has the same day and month
  /// as the given [dateTime].
  ///
  /// Year is intentionally ignored.
  bool isSameDate(DateTime dateTime) {
    return day == dateTime.day && month == dateTime.month;
  }

  /// Returns `true` if this date represents today.
  bool get isToday {
    final now = DateTime.now();
    return isSameDay(now);
  }

  /// Returns `true` if this date represents yesterday.
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(yesterday);
  }

  /// Returns `true` if this date represents tomorrow.
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return isSameDay(tomorrow);
  }

  /// Returns `true` if this date is in the past.
  bool get isPast => isBefore(DateTime.now());

  /// Returns `true` if this date is in the future.
  bool get isFuture => isAfter(DateTime.now());

  /// Returns `true` if this date is on a weekend (Saturday or Sunday).
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Returns `true` if this date is on a weekday (Monday to Friday).
  bool get isWeekday => !isWeekend;

  /// Calculates age in full years from this birth date.
  int get age {
    final today = DateTime.now();
    var calculatedAge = today.year - year;
    if (today.month < month || (today.month == month && today.day < day)) {
      calculatedAge--;
    }
    return calculatedAge;
  }

  /// Adds [days] days to this date.
  DateTime addDays(int days) => add(Duration(days: days));

  /// Subtracts [days] days from this date.
  DateTime subDays(int days) => subtract(Duration(days: days));

  /// Returns the start of this day (00:00:00.000).
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns the end of this day (23:59:59.999).
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Checks whether this date occurs on the same calendar day
  /// as [other], including year.
  bool isSameDay(DateTime other) => year == other.year && isSameDate(other);

  /// Formats this date using the given [pattern] and [locale].
  ///
  /// The result is automatically capitalized.
  String format({String pattern = "dd MMM yyyy", String? locale}) {
    return DateFormat(pattern, locale).format(this).cap;
  }

  /// Formats this date as "Month Year".
  ///
  /// If [fullMonth] is `true`, the full month name is used.
  /// Otherwise, the abbreviated month name is used.
  ///
  /// Examples:
  /// - `Jan 2025`
  /// - `January 2025`
  String formatMY([bool fullMonth = true]) {
    return format(pattern: "MMM${fullMonth ? "M" : ""} yyyy");
  }

  /// Returns a human-readable relative time string.
  ///
  /// Examples:
  /// - `5 minutes ago`
  /// - `2 days ago`
  ///
  /// The output language can be customized using [locale].
  String ago({String locale = "en"}) => timeago.format(this, locale: locale);
}
