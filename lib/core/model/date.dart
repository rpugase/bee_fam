import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Date extends Equatable {
  final DateTime dateTime;

  Date([DateTime? _dateTime, bool toUtc = true])
      : dateTime = (toUtc ? _dateTime?.toUtc() : _dateTime) ?? DateTime.now().toUtc();

  bool get isValid => dateTime.year != INVALID_DATE_TIME.year;

  Date copy({int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) => Date(
      DateTime(
      year ?? dateTime.year,
        month ?? dateTime.month,
        hour ?? dateTime.hour,
        minute ?? dateTime.minute,
        second ?? dateTime.second,
        millisecond ?? dateTime.millisecond,
        microsecond ?? dateTime.microsecond,
      ));

  Date add(Duration duration) => Date(dateTime.add(duration));

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

  String toDay() => DateFormat.d().format(dateTime);

  String toShortMonth() => DateFormat.MMM().format(dateTime);

  String toMonth() => DateFormat.MMMM().format(dateTime);

  @override
  List<Object?> get props => [dateTime];
}

class LeftPeriod extends Equatable {
  final int count;
  final LeftType leftType;

  const LeftPeriod(this.count, this.leftType);

  @override
  List<Object?> get props => [count, leftType];
}

enum LeftType {
  DAYS,
  MONTH
}

extension DateTimeParsing on DateFormat {
  DateTime parseCustom(String date) {
    try {
      return this.parse(date);
    } on Exception catch (e) {
      Log.e(e);
    }
    return INVALID_DATE_TIME;
  }
}

final DateTime INVALID_DATE_TIME = DateTime(-1);
