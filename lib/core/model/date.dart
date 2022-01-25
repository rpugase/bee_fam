import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Date extends Equatable {
  final DateTime dateTime;

  Date([DateTime? _dateTime])
      : dateTime = _dateTime?.toUtc() ?? DateTime.now().toUtc();

  // millis
  Date.millis(int milliseconds)
      : dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds).toUtc();

  Date.remote(String date) : dateTime = DateTime.parse(date).toUtc();

  Date.defaultBirthday() : dateTime = DateTime.now().toUtc();

  Date.birthdayString(String birthday)
      : dateTime = DateFormat.yMd().parse(birthday);

  Date.uiBirthdayString(String birthday)
      : dateTime = DateFormat.yMd().parse(birthday);

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

  @override
  List<Object?> get props => [dateTime];
}
