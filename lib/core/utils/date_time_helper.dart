import 'package:intl/intl.dart';

/// Helper methods for formatting time and date strings on the Kiosk UI.
class DateTimeHelper {
  DateTimeHelper._();

  static final DateFormat _timeFormatter = DateFormat('hh:mm:ss a');
  static final DateFormat _shortTimeFormatter = DateFormat('hh:mm a');
  static final DateFormat _dateFormatter = DateFormat('EEEE, d MMMM yyyy');
  static final DateFormat _shortDateFormatter = DateFormat('d MMM yyyy');

  /// Formats a [DateTime] to `hh:mm:ss a` (e.g. `02:30:45 PM`)
  static String formatLiveTime(DateTime dateTime) {
    return _timeFormatter.format(dateTime);
  }

  /// Formats a [DateTime] to `hh:mm a` (e.g. `02:30 PM`)
  static String formatShortTime(DateTime dateTime) {
    return _shortTimeFormatter.format(dateTime);
  }

  /// Formats a [DateTime] to full day and date (e.g. `Thursday, 27 August 2026`)
  static String formatFullDate(DateTime dateTime) {
    return _dateFormatter.format(dateTime);
  }

  /// Formats a [DateTime] to short date (e.g. `27 Aug 2026`)
  static String formatShortDate(DateTime dateTime) {
    return _shortDateFormatter.format(dateTime);
  }
}
