import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/core/model/remind_notification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final rnToday = RemindNotification.inBirthday();
  final rnWeek = RemindNotification.inWeek();
  final rnMonth = RemindNotification.inMonth();

  final dYesterday = Date().add(const Duration(days: -1));

  final dWeek = Date().add(const Duration(days: -7));
  final dWeekMinusDay = Date().add(const Duration(days: -6));
  final dWeekPlusDay = Date().add(const Duration(days: -8));


  final dMonth = Date().add(const Duration(days: -30));
  final dMonthMinusDay = Date().add(const Duration(days: -29));
  final dMonthPlusDay = Date().add(const Duration(days: -31));

  test('Notification showing today test', () async {
    final today = NotificationModel.forTest(Date(), [rnToday]).isIncludeRemindNotificationForToday();
    final sevenDays = NotificationModel.forTest(dWeek, [rnToday]).isIncludeRemindNotificationForToday();
    final month = NotificationModel.forTest(dMonth, [rnToday]).isIncludeRemindNotificationForToday();

    expect(today, equals(true));
    expect(sevenDays, equals(false));
    expect(month, equals(false));

    final yesterday = NotificationModel.forTest(dYesterday, [rnToday]).isIncludeRemindNotificationForToday();
    final weekMinusDay = NotificationModel.forTest(dWeekMinusDay, [rnToday]).isIncludeRemindNotificationForToday();
    final weekPlusDay = NotificationModel.forTest(dWeekPlusDay, [rnToday]).isIncludeRemindNotificationForToday();
    final monthMinusDay = NotificationModel.forTest(dMonthMinusDay, [rnToday]).isIncludeRemindNotificationForToday();
    final monthPlusDay = NotificationModel.forTest(dMonthPlusDay, [rnToday]).isIncludeRemindNotificationForToday();

    expect(yesterday, equals(false));
    expect(weekMinusDay, equals(false));
    expect(weekPlusDay, equals(false));
    expect(monthMinusDay, equals(false));
    expect(monthPlusDay, equals(false));
  });

  test('Notification showing week test', () async {
    final today = NotificationModel.forTest(Date(), [rnWeek]).isIncludeRemindNotificationForToday();
    final sevenDays = NotificationModel.forTest(dWeek, [rnWeek]).isIncludeRemindNotificationForToday();
    final month = NotificationModel.forTest(dMonth, [rnWeek]).isIncludeRemindNotificationForToday();

    expect(today, equals(false));
    expect(sevenDays, equals(true));
    expect(month, equals(false));

    final yesterday = NotificationModel.forTest(dYesterday, [rnWeek]).isIncludeRemindNotificationForToday();
    final weekMinusDay = NotificationModel.forTest(dWeekMinusDay, [rnWeek]).isIncludeRemindNotificationForToday();
    final weekPlusDay = NotificationModel.forTest(dWeekPlusDay, [rnWeek]).isIncludeRemindNotificationForToday();
    final monthMinusDay = NotificationModel.forTest(dMonthMinusDay, [rnWeek]).isIncludeRemindNotificationForToday();
    final monthPlusDay = NotificationModel.forTest(dMonthPlusDay, [rnWeek]).isIncludeRemindNotificationForToday();

    expect(yesterday, equals(false));
    expect(weekMinusDay, equals(false));
    expect(weekPlusDay, equals(false));
    expect(monthMinusDay, equals(false));
    expect(monthPlusDay, equals(false));
  });

  test('Notification showing month test', () async {
    final today = NotificationModel.forTest(Date(), [rnMonth]).isIncludeRemindNotificationForToday();
    final sevenDays = NotificationModel.forTest(dWeek, [rnMonth]).isIncludeRemindNotificationForToday();
    final month = NotificationModel.forTest(dMonth, [rnMonth]).isIncludeRemindNotificationForToday();

    expect(today, equals(false));
    expect(sevenDays, equals(false));
    expect(month, equals(true));

    final yesterday = NotificationModel.forTest(dYesterday, [rnMonth]).isIncludeRemindNotificationForToday();
    final weekMinusDay = NotificationModel.forTest(dWeekMinusDay, [rnMonth]).isIncludeRemindNotificationForToday();
    final weekPlusDay = NotificationModel.forTest(dWeekPlusDay, [rnMonth]).isIncludeRemindNotificationForToday();
    final monthMinusDay = NotificationModel.forTest(dMonthMinusDay, [rnMonth]).isIncludeRemindNotificationForToday();
    final monthPlusDay = NotificationModel.forTest(dMonthPlusDay, [rnMonth]).isIncludeRemindNotificationForToday();

    expect(yesterday, equals(false));
    expect(weekMinusDay, equals(false));
    expect(weekPlusDay, equals(false));
    expect(monthMinusDay, equals(false));
    expect(monthPlusDay, equals(false));
  });

  test('Notification showing day & week test', () async {
    final today = NotificationModel.forTest(Date(), [rnToday, rnWeek]).isIncludeRemindNotificationForToday();
    final sevenDays = NotificationModel.forTest(dWeek, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();
    final month = NotificationModel.forTest(dMonth, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();

    expect(today, equals(true));
    expect(sevenDays, equals(true));
    expect(month, equals(false));

    final yesterday = NotificationModel.forTest(dYesterday, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();
    final weekMinusDay = NotificationModel.forTest(dWeekMinusDay, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();
    final weekPlusDay = NotificationModel.forTest(dWeekPlusDay, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();
    final monthMinusDay = NotificationModel.forTest(dMonthMinusDay, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();
    final monthPlusDay = NotificationModel.forTest(dMonthPlusDay, [rnToday, rnWeek]).isIncludeRemindNotificationForToday();

    expect(yesterday, equals(false));
    expect(weekMinusDay, equals(false));
    expect(weekPlusDay, equals(false));
    expect(monthMinusDay, equals(false));
    expect(monthPlusDay, equals(false));
  });

  test('Notification showing week & month test', () async {
    final today = NotificationModel.forTest(Date(), [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();
    final sevenDays = NotificationModel.forTest(dWeek, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();
    final month = NotificationModel.forTest(dMonth, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();

    expect(today, equals(false));
    expect(sevenDays, equals(true));
    expect(month, equals(true));

    final yesterday = NotificationModel.forTest(dYesterday, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();
    final weekMinusDay = NotificationModel.forTest(dWeekMinusDay, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();
    final weekPlusDay = NotificationModel.forTest(dWeekPlusDay, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();
    final monthMinusDay = NotificationModel.forTest(dMonthMinusDay, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();
    final monthPlusDay = NotificationModel.forTest(dMonthPlusDay, [rnWeek, rnMonth]).isIncludeRemindNotificationForToday();

    expect(yesterday, equals(false));
    expect(weekMinusDay, equals(false));
    expect(weekPlusDay, equals(false));
    expect(monthMinusDay, equals(false));
    expect(monthPlusDay, equals(false));
  });

  test('Notification showing day & month test', () async {
    final today = NotificationModel.forTest(Date(), [rnToday, rnMonth]).isIncludeRemindNotificationForToday();
    final sevenDays = NotificationModel.forTest(dWeek, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();
    final month = NotificationModel.forTest(dMonth, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();

    expect(today, equals(true));
    expect(sevenDays, equals(false));
    expect(month, equals(true));

    final yesterday = NotificationModel.forTest(dYesterday, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();
    final weekMinusDay = NotificationModel.forTest(dWeekMinusDay, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();
    final weekPlusDay = NotificationModel.forTest(dWeekPlusDay, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();
    final monthMinusDay = NotificationModel.forTest(dMonthMinusDay, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();
    final monthPlusDay = NotificationModel.forTest(dMonthPlusDay, [rnToday, rnMonth]).isIncludeRemindNotificationForToday();

    expect(yesterday, equals(false));
    expect(weekMinusDay, equals(false));
    expect(weekPlusDay, equals(false));
    expect(monthMinusDay, equals(false));
    expect(monthPlusDay, equals(false));
  });
}
