import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/utils/cache/entity/remind_notification_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RemindNotification extends Equatable {
  final int offsetDaysFromBirthday;
  final int offsetMonthFromBirthday;

  const RemindNotification({
    this.offsetDaysFromBirthday = 0,
    this.offsetMonthFromBirthday = 0,
  });

  factory RemindNotification.inBirthday() {
    return const RemindNotification();
  }

  factory RemindNotification.inWeek() {
    return const RemindNotification(offsetDaysFromBirthday: 7);
  }

  factory RemindNotification.inMonth() {
    return const RemindNotification(offsetMonthFromBirthday: 1);
  }

  factory RemindNotification.fromEntity(RemindNotificationEntity entity) {
    return RemindNotification(
      offsetDaysFromBirthday: entity.offsetDaysFromBirthday,
      offsetMonthFromBirthday: entity.offsetMonthFromBirthday,
    );
  }

  RemindNotificationEntity toEntity() {
    return RemindNotificationEntity(offsetDaysFromBirthday, offsetMonthFromBirthday);
  }

  String getTitle(BuildContext context) {
    if (offsetDaysFromBirthday == 0 && offsetMonthFromBirthday == 0) {
      return context.strings.in_day_birthday;
    } else if (offsetDaysFromBirthday > 0 && offsetMonthFromBirthday == 0) {
      return context.strings.in_x_week(offsetDaysFromBirthday ~/ 7);
    } else {
      return context.strings.in_x_month(offsetMonthFromBirthday.toInt());
    }
  }

  @override
  List<Object?> get props => [offsetDaysFromBirthday, offsetMonthFromBirthday];
}
