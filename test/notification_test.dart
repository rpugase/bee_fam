import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/model/remind_notification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final rnToday = RemindNotification.inBirthday();
  final rnWeek = RemindNotification.inWeek();
  final rnMonth = RemindNotification.inMonth();

  final dYesterday = Date().add(Duration(days: -1));

  final dWeek = Date().add(Duration(days: -7));
  final dWeekMinusDay = Date().add(Duration(days: -6));
  final dWeekPlusDay = Date().add(Duration(days: -8));


  final dMonth = Date().add(Duration(days: -30));
  final dMonthMinusDay = Date().add(Duration(days: -29));
  final dMonthPlusDay = Date().add(Duration(days: -31));

  test('Notification showing today test', () async {
    final today = Person.forTest(Date(), [rnToday]).isIncludeRemindNotificationForToday();
    final sevenDays = Person.forTest(dWeek, [rnToday]).isIncludeRemindNotificationForToday();
    final month = Person.forTest(dMonth, [rnToday]).isIncludeRemindNotificationForToday();

    expect(today, equals(true));
    expect(sevenDays, equals(false));
    expect(month, equals(false));

    final yesterday = Person.forTest(dYesterday, [rnToday]).isIncludeRemindNotificationForToday();
    final weekMinusDay = Person.forTest(dWeekMinusDay, [rnToday]).isIncludeRemindNotificationForToday();
    final weekPlusDay = Person.forTest(dWeekPlusDay, [rnToday]).isIncludeRemindNotificationForToday();
    final monthMinusDay = Person.forTest(dMonthMinusDay, [rnToday]).isIncludeRemindNotificationForToday();
    final monthPlusDay = Person.forTest(dMonthPlusDay, [rnToday]).isIncludeRemindNotificationForToday();

    expect(yesterday, equals(false));
    expect(weekMinusDay, equals(false));
    expect(weekPlusDay, equals(false));
    expect(monthMinusDay, equals(false));
    expect(monthPlusDay, equals(false));
  });

  test('Notification showing week test', () async {
    final today = Person.forTest(Date(), [rnWeek]).isIncludeRemindNotificationForToday();
    final sevenDays = Person.forTest(dWeek, [rnWeek]).isIncludeRemindNotificationForToday();
    final month = Person.forTest(dMonth, [rnWeek]).isIncludeRemindNotificationForToday();

    expect(today, equals(false));
    expect(sevenDays, equals(true));
    expect(month, equals(false));

    final yesterday = Person.forTest(dYesterday, [rnWeek]).isIncludeRemindNotificationForToday();
    final weekMinusDay = Person.forTest(dWeekMinusDay, [rnWeek]).isIncludeRemindNotificationForToday();
    final weekPlusDay = Person.forTest(dWeekPlusDay, [rnWeek]).isIncludeRemindNotificationForToday();
    final monthMinusDay = Person.forTest(dMonthMinusDay, [rnWeek]).isIncludeRemindNotificationForToday();
    final monthPlusDay = Person.forTest(dMonthPlusDay, [rnWeek]).isIncludeRemindNotificationForToday();

    expect(yesterday, equals(false));
    expect(weekMinusDay, equals(false));
    expect(weekPlusDay, equals(false));
    expect(monthMinusDay, equals(false));
    expect(monthPlusDay, equals(false));
  });

  test('Notification showing month test', () async {
    final today = Person.forTest(Date(), [rnMonth]).isIncludeRemindNotificationForToday();
    final sevenDays = Person.forTest(dWeek, [rnMonth]).isIncludeRemindNotificationForToday();
    final month = Person.forTest(dMonth, [rnMonth]).isIncludeRemindNotificationForToday();

    expect(today, equals(false));
    expect(sevenDays, equals(false));
    expect(month, equals(true));

    final yesterday = Person.forTest(dYesterday, [rnMonth]).isIncludeRemindNotificationForToday();
    final weekMinusDay = Person.forTest(dWeekMinusDay, [rnMonth]).isIncludeRemindNotificationForToday();
    final weekPlusDay = Person.forTest(dWeekPlusDay, [rnMonth]).isIncludeRemindNotificationForToday();
    final monthMinusDay = Person.forTest(dMonthMinusDay, [rnMonth]).isIncludeRemindNotificationForToday();
    final monthPlusDay = Person.forTest(dMonthPlusDay, [rnMonth]).isIncludeRemindNotificationForToday();

    expect(yesterday, equals(false));
    expect(weekMinusDay, equals(false));
    expect(weekPlusDay, equals(false));
    expect(monthMinusDay, equals(false));
    expect(monthPlusDay, equals(false));
  });

  test('Notification showing day & week test', () async {
    final today = Person.forTest(Date(), [rnToday, rnWeek]).isIncludeRemindNotificationForToday();
    final sevenDays = Person.forTest(dWeek, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();
    final month = Person.forTest(dMonth, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();

    expect(today, equals(true));
    expect(sevenDays, equals(true));
    expect(month, equals(false));

    final yesterday = Person.forTest(dYesterday, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();
    final weekMinusDay = Person.forTest(dWeekMinusDay, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();
    final weekPlusDay = Person.forTest(dWeekPlusDay, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();
    final monthMinusDay = Person.forTest(dMonthMinusDay, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();
    final monthPlusDay = Person.forTest(dMonthPlusDay, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();

    expect(yesterday, equals(false));
    expect(weekMinusDay, equals(false));
    expect(weekPlusDay, equals(false));
    expect(monthMinusDay, equals(false));
    expect(monthPlusDay, equals(false));
  });

  test('Notification showing week & month test', () async {
    final today = Person.forTest(Date(), [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();
    final sevenDays = Person.forTest(dWeek, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();
    final month = Person.forTest(dMonth, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();

    expect(today, equals(false));
    expect(sevenDays, equals(true));
    expect(month, equals(true));

    final yesterday = Person.forTest(dYesterday, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();
    final weekMinusDay = Person.forTest(dWeekMinusDay, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();
    final weekPlusDay = Person.forTest(dWeekPlusDay, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();
    final monthMinusDay = Person.forTest(dMonthMinusDay, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();
    final monthPlusDay = Person.forTest(dMonthPlusDay, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();

    expect(yesterday, equals(false));
    expect(weekMinusDay, equals(false));
    expect(weekPlusDay, equals(false));
    expect(monthMinusDay, equals(false));
    expect(monthPlusDay, equals(false));
  });

  test('Notification showing day & month test', () async {
    final today = Person.forTest(Date(), [rnToday, rnMonth]).isIncludeRemindNotificationForToday();
    final sevenDays = Person.forTest(dWeek, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();
    final month = Person.forTest(dMonth, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();

    expect(today, equals(true));
    expect(sevenDays, equals(false));
    expect(month, equals(true));

    final yesterday = Person.forTest(dYesterday, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();
    final weekMinusDay = Person.forTest(dWeekMinusDay, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();
    final weekPlusDay = Person.forTest(dWeekPlusDay, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();
    final monthMinusDay = Person.forTest(dMonthMinusDay, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();
    final monthPlusDay = Person.forTest(dMonthPlusDay, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();

    expect(yesterday, equals(false));
    expect(weekMinusDay, equals(false));
    expect(weekPlusDay, equals(false));
    expect(monthMinusDay, equals(false));
    expect(monthPlusDay, equals(false));
  });
}
