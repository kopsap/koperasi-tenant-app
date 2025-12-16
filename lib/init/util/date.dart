part of 'util.dart';

enum DateAdditionType { second, minute, hour, day, month, year }

final int msToSecond = 1000;
final int msToMinute = msToSecond * 60;
final int msToHour = msToMinute * 60;
final int msToDay = msToHour * 24;
final int msToMonth = msToDay * 31;
final int msToYear = msToDay * 365;

class DateUtil {
  final Map<int, String> months = {
    DateTime.january: "Januari",
    DateTime.february: "Februari",
    DateTime.march: "Maret",
    DateTime.april: "April",
    DateTime.may: "Mei",
    DateTime.june: "Juni",
    DateTime.july: "Juli",
    DateTime.august: "Agustus",
    DateTime.september: "September",
    DateTime.october: "Oktober",
    DateTime.november: "November",
    DateTime.december: "Desember",
  };

  final Map<DateAdditionType, int> datetimeConstant = {
    DateAdditionType.second: msToSecond,
    DateAdditionType.minute: msToMinute,
    DateAdditionType.hour: msToHour,
    DateAdditionType.day: msToDay,
    DateAdditionType.month: msToMonth,
    DateAdditionType.year: msToYear,
  };

  DateTime getToday() {
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day, 0, 0, 0);
  }

  DateTime dateAddition({
    DateTime? datetime,
    required int addition,
    DateAdditionType type = DateAdditionType.second,
  }) {
    var dt = datetime ?? getToday();

    if (type == DateAdditionType.second) {
      dt = DateTime(
        dt.year,
        dt.month,
        dt.day,
        dt.hour,
        dt.minute,
        dt.second + addition,
      );
    } else if (type == DateAdditionType.minute) {
      dt = DateTime(
        dt.year,
        dt.month,
        dt.day,
        dt.hour,
        dt.minute + addition,
        dt.second,
      );
    } else if (type == DateAdditionType.hour) {
      dt = DateTime(
        dt.year,
        dt.month,
        dt.day,
        dt.hour + addition,
        dt.minute,
        dt.second,
      );
    } else if (type == DateAdditionType.day) {
      dt = DateTime(
        dt.year,
        dt.month,
        dt.day + addition,
        dt.hour,
        dt.minute,
        dt.second,
      );
    } else if (type == DateAdditionType.month) {
      dt = DateTime(
        dt.year,
        dt.month + addition,
        dt.day,
        dt.hour,
        dt.minute,
        dt.second,
      );
    } else if (type == DateAdditionType.year) {
      dt = DateTime(
        dt.year + addition,
        dt.month,
        dt.day,
        dt.hour,
        dt.minute,
        dt.second,
      );
    }

    return dt;
  }

  String datetimeFormat({DateTime? datetime, String format = "Y-m-d H:i:s"}) {
    datetime ??= getToday();

    String str = datetime.toString();
    DateTime localDt = DateTime.parse(str).toLocal();

    String year = localDt.year.toString();
    String month = localDt.month.toString().padLeft(2, '0');
    String date = localDt.day.toString().padLeft(2, '0');
    String hour = localDt.hour.toString().padLeft(2, '0');
    String minute = localDt.minute.toString().padLeft(2, '0');
    String second = localDt.second.toString().padLeft(2, '0');

    String fullMonth = months[localDt.month]!;

    return format
        .replaceFirst("Y", year)
        .replaceFirst("m", month)
        .replaceFirst("d", date)
        .replaceFirst("H", hour)
        .replaceFirst("i", minute)
        .replaceFirst("s", second)
        .replaceFirst("M", fullMonth);
  }

  /// Compare Date Rule:
  /// Positive: Last Date > First Date
  /// 0: Last Date = First Date
  /// Negative: Last Date < First Date
  int compareDate(DateTime firstDate, DateTime lastDate) {
    return lastDate.millisecondsSinceEpoch - firstDate.millisecondsSinceEpoch;
  }

  String getFormat(DateTime firstDate, DateTime lastDate) {
    final dateDiff = compareDate(firstDate, lastDate);
    String dateFormat = "d M";

    if (dateDiff > datetimeConstant[DateAdditionType.year]!) {
      dateFormat = "Y";
    } else if (dateDiff > datetimeConstant[DateAdditionType.month]!) {
      dateFormat = "M Y";
    }

    return dateFormat;
  }
}
