
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatterHelper {
  // Common date formats
  static const String ddMMyyyy = 'dd/MM/yyyy';
  static const String ddMMyyyyWithDashes = 'dd-MM-yyyy';
  static const String mmDDyyyy = 'MM/dd/yyyy';
  static const String yyyyMMdd = 'yyyy-MM-dd';
  static const String ddMMMMyyyy = 'dd MMMM yyyy';
  static const String ddMMMyyyy = 'dd MMM yyyy';
  static const String EEEEddMMMMyyyy = 'EEEE, dd MMMM yyyy';
  static const String EEEddMMMyyyy = 'EEE, dd MMM yyyy';
  static const String mMMMyyyy = 'd MMM yyyy';
  static const String mMMM = 'd MMM';
  static const String mmmmYYYY = 'MMMM yyyy';
  static const String mmmYYYY = 'MMM yyyy';
  static const String yyyyMM = 'yyyy-MM';
  static const String ddMMyyyyDotHHmm = 'dd-MM-yyyy . HH:mm';

  // Time formats
  static const String hhmm24 = 'HH:mm';
  static const String hhmmss24 = 'HH:mm:ss';
  static const String hhmm12 = 'hh:mm a';
  static const String hhmmss12 = 'hh:mm:ss a';

  // DateTime formats
  static const String ddMMyyyyHHmm = 'dd/MM/yyyy HH:mm';
  static const String ddMMyyyyHHmmss = 'dd/MM/yyyy HH:mm:ss';
  static const String ddMMyyyyhhmma = 'dd/MM/yyyy hh:mm a';
  static const String iso8601 = "yyyy-MM-dd'T'HH:mm:ss'Z'";
  static const String iso8601WithMillis = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

  /// Format DateTime to string with custom pattern
  static String format(DateTime dateTime, String pattern) {
    try {
      return DateFormat(pattern,'en_US').format(dateTime);
    } catch (e) {
      print('Error formatting date: $e');
      return dateTime.toString();
    }
  }

  /// Format DateTime to dd-MM-yyyy . HH:mm (e.g., 12-08-2025 . 12:30)
  static String toDDMMYYYYDotTime24(DateTime dateTime) {
    return format(dateTime, ddMMyyyyDotHHmm);
  }

  /// Format DateTime to dd/MM/yyyy
  static String toDDMMYYYY(DateTime dateTime) {
    return format(dateTime, ddMMyyyy);
  }

  /// Format DateTime to dd-MM-yyyy
  static String toDDMMYYYYWithDashes(DateTime dateTime) {
    return format(dateTime, ddMMyyyyWithDashes);
  }

  /// Format DateTime to MM/dd/yyyy (US format)
  static String toMMDDYYYY(DateTime dateTime) {
    return format(dateTime, mmDDyyyy);
  }

  /// Format DateTime to yyyy-MM-dd (ISO format)
  static String toYYYYMMDD(DateTime dateTime) {
    return format(dateTime, yyyyMMdd);
  }

  /// Format DateTime to dd MMMM yyyy (e.g., 15 August 2024)
  static String toDDMMMMMYYYY(DateTime dateTime) {
    return format(dateTime, ddMMMMyyyy);
  }

  /// Format DateTime to dd MMM yyyy (e.g., 15 Aug 2024)
  static String toDDMMMYYYY(DateTime dateTime) {
    return format(dateTime, ddMMMyyyy);
  }

  /// Format DateTime to full day and date (e.g., Thursday, 15 August 2024)
  static String toFullDayAndDate(DateTime dateTime) {
    return format(dateTime, EEEEddMMMMyyyy);
  }

  /// Format DateTime to short day and date (e.g., Thu, 15 Aug 2024)
  static String toShortDayAndDate(DateTime dateTime) {
    return format(dateTime, EEEddMMMyyyy);
  }

  /// Format DateTime to d MMM yyyy (e.g., 5 Aug 2024)
  static String toDMMMYYYY(DateTime dateTime) {
    return format(dateTime, mMMMyyyy);
  }

  /// Format DateTime to d MMM (e.g., 5 Aug)
  static String toDMMM(DateTime dateTime) {
    return format(dateTime, mMMM);
  }

  /// Format DateTime to month and year (e.g., August 2024)
  static String toMMMMMYYYY(DateTime dateTime) {
    return format(dateTime, mmmmYYYY);
  }

  /// Format DateTime to short month and year (e.g., Aug 2024)
  static String toMMMYYYY(DateTime dateTime) {
    return format(dateTime, mmmYYYY);
  }

  /// Format DateTime to 24-hour time (e.g., 14:30)
  static String toTime24(DateTime dateTime) {
    return format(dateTime, hhmm24);
  }

  static String formatTimeWithAmPm(TimeOfDay time) {
    final hour = time.hourOfPeriod.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  /// Format DateTime to 24-hour time with seconds (e.g., 14:30:45)
  static String toTime24WithSeconds(DateTime dateTime) {
    return format(dateTime, hhmmss24);
  }

  /// Format DateTime to 12-hour time (e.g., 2:30 PM)
  static String toTime12(DateTime dateTime) {
    return format(dateTime, hhmm12);
  }

  /// Format DateTime to 12-hour time with seconds (e.g., 2:30:45 PM)
  static String toTime12WithSeconds(DateTime dateTime) {
    return format(dateTime, hhmmss12);
  }

  /// Format DateTime to date and 24-hour time
  static String toDateAndTime24(DateTime dateTime) {
    return format(dateTime, ddMMyyyyHHmm);
  }

  /// Format DateTime to date and 12-hour time
  static String toDateAndTime12(DateTime dateTime) {
    return format(dateTime, ddMMyyyyhhmma);
  }

  /// Format DateTime to ISO 8601 string
  static String toISO8601(DateTime dateTime) {
    return format(dateTime.toUtc(), iso8601);
  }

  /// Format DateTime to ISO 8601 with milliseconds
  static String toISO8601WithMillis(DateTime dateTime) {
    return format(dateTime.toUtc(), iso8601WithMillis);
  }

  /// Parse string to DateTime with custom pattern
  static DateTime? parseFromString(String dateString, String pattern) {
    try {
 
      return DateFormat(pattern).parse(dateString);
    } catch (e) {
      print('Error parsing date: $e');
      return null;
    }
  }

  /// Parse common date formats automatically
  static DateTime? parseAuto(String dateString) {
    final patterns = [
      ddMMyyyy,
      ddMMyyyyWithDashes,
      mmDDyyyy,
      yyyyMMdd,
      iso8601,
      iso8601WithMillis,
      ddMMyyyyHHmm,
      ddMMyyyyHHmmss,
      ddMMyyyyhhmma,
      ddMMyyyyDotHHmm,
    ];

    for (String pattern in patterns) {
      final result = parseFromString(dateString, pattern);
      if (result != null) return result;
    }

    // Try DateTime.parse as fallback
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print('Could not parse date: $dateString');
      return null;
    }
  }

  /// Get relative time (e.g., "2 minutes ago", "in 3 hours")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.isNegative) {
      // Future time
      final futureDiff = dateTime.difference(now);

      if (futureDiff.inSeconds < 60) {
        return 'in ${futureDiff.inSeconds} seconds';
      } else if (futureDiff.inMinutes < 60) {
        return 'in ${futureDiff.inMinutes} minutes';
      } else if (futureDiff.inHours < 24) {
        return 'in ${futureDiff.inHours} hours';
      } else if (futureDiff.inDays < 7) {
        return 'in ${futureDiff.inDays} days';
      } else if (futureDiff.inDays < 30) {
        return 'in ${(futureDiff.inDays / 7).floor()} weeks';
      } else if (futureDiff.inDays < 365) {
        return 'in ${(futureDiff.inDays / 30).floor()} months';
      } else {
        return 'in ${(futureDiff.inDays / 365).floor()} years';
      }
    } else {
      // Past time
      if (difference.inSeconds < 60) {
        return '${difference.inSeconds} seconds ago';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} minutes ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} hours ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays < 30) {
        return '${(difference.inDays / 7).floor()} weeks ago';
      } else if (difference.inDays < 365) {
        return '${(difference.inDays / 30).floor()} months ago';
      } else {
        return '${(difference.inDays / 365).floor()} years ago';
      }
    }
  }

  /// Get short relative time (e.g., "2m", "3h", "1d")
  static String getShortRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.isNegative) {
      final futureDiff = dateTime.difference(now);

      if (futureDiff.inSeconds < 60) {
        return '${futureDiff.inSeconds}s';
      } else if (futureDiff.inMinutes < 60) {
        return '${futureDiff.inMinutes}m';
      } else if (futureDiff.inHours < 24) {
        return '${futureDiff.inHours}h';
      } else if (futureDiff.inDays < 7) {
        return '${futureDiff.inDays}d';
      } else if (futureDiff.inDays < 30) {
        return '${(futureDiff.inDays / 7).floor()}w';
      } else if (futureDiff.inDays < 365) {
        return '${(futureDiff.inDays / 30).floor()}mo';
      } else {
        return '${(futureDiff.inDays / 365).floor()}y';
      }
    } else {
      if (difference.inSeconds < 60) {
        return '${difference.inSeconds}s';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}h';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d';
      } else if (difference.inDays < 30) {
        return '${(difference.inDays / 7).floor()}w';
      } else if (difference.inDays < 365) {
        return '${(difference.inDays / 30).floor()}mo';
      } else {
        return '${(difference.inDays / 365).floor()}y';
      }
    }
  }

  /// Check if date is today
  static bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime dateTime) {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day;
  }

  /// Check if date is tomorrow
  static bool isTomorrow(DateTime dateTime) {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    return dateTime.year == tomorrow.year &&
        dateTime.month == tomorrow.month &&
        dateTime.day == tomorrow.day;
  }

  /// Check if date is this week
  static bool isThisWeek(DateTime dateTime) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));

    return dateTime.isAfter(startOfWeek.subtract(Duration(seconds: 1))) &&
        dateTime.isBefore(endOfWeek.add(Duration(days: 1)));
  }

  /// Get age from birth date
  static int getAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  /// Get days between two dates
  static int daysBetween(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays;
  }

  /// Format duration to human readable string
  static String formatDuration(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    List<String> parts = [];

    if (days > 0) parts.add('${days}d');
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    if (seconds > 0 && days == 0) parts.add('${seconds}s');

    return parts.isEmpty ? '0s' : parts.join(' ');
  }

  /// Get start of day (00:00:00)
  static DateTime startOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  /// Get end of day (23:59:59)
  static DateTime endOfDay(DateTime dateTime) {
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      23,
      59,
      59,
      999,
    );
  }

  /// Get start of week (Monday 00:00:00)
  static DateTime startOfWeek(DateTime dateTime) {
    final startOfDay = DateFormatterHelper.startOfDay(dateTime);
    return startOfDay.subtract(Duration(days: dateTime.weekday - 1));
  }

  /// Get end of week (Sunday 23:59:59)
  static DateTime endOfWeekDateTime(dateTime) {
    final startOfWeek = DateFormatterHelper.startOfWeek(dateTime);
    return endOfDay(startOfWeek.add(Duration(days: 6)));
  }

  /// Get start of month (1st day 00:00:00)
  static DateTime startOfMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, 1);
  }

  /// Get end of month (last day 23:59:59)
  static DateTime endOfMonth(DateTime dateTime) {
    final nextMonth = DateTime(dateTime.year, dateTime.month + 1, 1);
    final lastDayOfMonth = nextMonth.subtract(Duration(days: 1));
    return endOfDay(lastDayOfMonth);
  }
}
