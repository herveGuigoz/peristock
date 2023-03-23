import 'package:intl/intl.dart';

extension DateTimeTimeExtension on DateTime {
  /// Adds this DateTime and Duration and returns the sum as a new DateTime
  /// object.
  DateTime operator +(Duration duration) => add(duration);

  /// Subtracts the Duration from this DateTime returns the difference as a new
  /// DateTime object.
  DateTime operator -(Duration duration) => subtract(duration);

  /// Returns only year, month and day.
  DateTime get asDay => DateTime(year, month, day);

  /// Returns if today, true.
  bool get isToday {
    return _calculateDifference(this) == 0;
  }

  /// Returns if tomorrow, true.
  bool get isTomorrow {
    return _calculateDifference(this) == 1;
  }

  /// Returns true if [other] is in the same year.
  ///
  /// Does not account for timezones.
  bool isAtSameYearAs(DateTime other) {
    return year == other.year;
  }

  /// Returns true if [other] is in the same month.
  ///
  /// This means the exact month, including year.
  ///
  /// Does not account for timezones.
  bool isAtSameMonthAs(DateTime other) {
    return isAtSameYearAs(other) && month == other.month;
  }

  /// Returns true if [other] is on the same day.
  ///
  /// This means the exact day, including year and month.
  ///
  /// Does not account for timezones.
  bool isAtSameDayAs(DateTime other) {
    return isAtSameMonthAs(other) && day == other.day;
  }

  int _calculateDifference(DateTime date) {
    final now = DateTime.now();
    
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }

  String format([String? locale]) {
    final format = DateFormat('dd MMM. y', locale);

    return format.format(this);
  }
}

extension NumTimeExtension<T extends num> on T {
  /// Returns a Duration represented in days.
  Duration get days => milliseconds * Duration.millisecondsPerDay;

  /// Returns a Duration represented in hours.
  Duration get hours => milliseconds * Duration.millisecondsPerHour;

  /// Returns a Duration represented in minutes.
  Duration get minutes => milliseconds * Duration.millisecondsPerMinute;

  /// Returns a Duration represented in seconds.
  Duration get seconds => milliseconds * Duration.millisecondsPerSecond;

  /// Returns a Duration represented in milliseconds.
  Duration get milliseconds {
    return Duration(
      microseconds: (this * Duration.microsecondsPerMillisecond).toInt(),
    );
  }
}
