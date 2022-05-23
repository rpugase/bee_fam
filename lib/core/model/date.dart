import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Date extends Equatable {
  final DateTime dateTime;

  Date([DateTime? _dateTime]) : dateTime = _dateTime?.toUtc() ?? DateTime.now().toUtc();

  bool get isValid => dateTime.year != INVALID_DATE_TIME.year;

  // millis
  Date.millis(int milliseconds) : dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds).toUtc();

  Date.remote(String date) : dateTime = DateTime.parse(date).toUtc();

  Date.defaultBirthday() : dateTime = DateTime.now().toUtc();

  Date.birthdayString(String birthday) : dateTime = DateFormat.yMd().parseCustom(birthday);

  Date.uiBirthdayString(String birthday) : dateTime = DateFormat.yMd().parseCustom(birthday);

  bool isToday() {
    final now = DateTime.now();
    return dateTime.day == now.day && dateTime.month == now.month;
  }

  int toMilliseconds() => dateTime.millisecond;

  String toIso8601String() => dateTime.toIso8601String();

  String toBirthdayString() => DateFormat.yMd().format(dateTime);

  String toUIBirthdayString() => toBirthdayString();

  int daysLeft(Date date) {
    return date.dateTime.difference(dateTime).inDays;
  }

  LeftPeriod dateLeft(Date date) {
    final inDateTime = date.dateTime;
    final outDateTime = DateTime(
      dateTime.year,
      inDateTime.month,
      inDateTime.day,
      inDateTime.hour,
      inDateTime.minute,
      inDateTime.second,
      inDateTime.millisecond,
      inDateTime.microsecond,
    );

    final dayDifference = outDateTime.difference(dateTime).inDays + 1;

    if (dayDifference < 31) {
      return LeftPeriod(dayDifference, LeftType.DAYS);
    } else {
      return LeftPeriod((date.dateTime.month - dateTime.month).abs(), LeftType.MONTH);
    }
  }

  @override
  List<Object?> get props => [dateTime];
}

class LeftPeriod {
  final int count;
  final LeftType leftType;

  const LeftPeriod(this.count, this.leftType);
}

enum LeftType {
  DAYS, MONTH
}

extension DateTimeParsing on DateFormat {
  DateTime parseCustom(String date) {
    try {
      return this.parse(date);
    } on Exception catch(e) {
      Log.e(e);
    }
    return INVALID_DATE_TIME;
  }
}

final DateTime INVALID_DATE_TIME = DateTime(-1);
