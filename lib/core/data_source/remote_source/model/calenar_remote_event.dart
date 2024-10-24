import 'package:birthday_gift/core/model/date.dart';
import 'package:equatable/equatable.dart';

class CalendarBirthdayEvent extends Equatable {
  final String googleEventId;
  final String title;
  final Date birthdayDate;
  final bool isCompletelyBirthdayEvent; // title is name in this case

  const CalendarBirthdayEvent({
    required this.googleEventId,
    required this.title,
    required this.birthdayDate,
    required this.isCompletelyBirthdayEvent,
  });

  @override
  List<Object?> get props => [googleEventId];

  @override
  String toString() {
    return "id=$googleEventId; title=$title; birthdayDate=${birthdayDate.toBirthdayString()}";
  }
}