import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Date extends Equatable {
  final DateTime dateTime;

  Date([DateTime? dateTime, bool toUtc = false])
      : dateTime = (toUtc ? dateTime?.toUtc() : dateTime) ?? (toUtc ? DateTime.now() : DateTime.now().toUtc());

  bool get isValid => dateTime.year != invalidDateTime.year;

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

  Date.uiBirthdayString(String birthday) : dateTime = DateFormat.MMMd().parseCustom(birthday);

  String getOffset() => dateTime.timeZoneOffset.toString();

  bool isTodayWithoutYear() {
    final now = DateTime.now();
    return dateTime.day == now.day && dateTime.month == now.month;
  }

  bool isToday() {
    final now = DateTime.now();
    return dateTime.day == now.day &&
        dateTime.month == now.month &&
        dateTime.year == now.year;
  }

  int toMilliseconds() => dateTime.millisecond;

  String toIso8601String() => dateTime.toIso8601String();

  String toBirthdayString() => DateFormat.yMd().format(dateTime);

  String toUIBirthdayString() => DateFormat.MMMd().format(dateTime);

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
  days,
  month
}

extension DateTimeParsing on DateFormat {
  DateTime parseCustom(String date) {
    try {
      return parse(date);
    } on Exception catch (e) {
      Log.e(e);
    }
    return invalidDateTime;
  }
}

final DateTime invalidDateTime = DateTime(-1);
