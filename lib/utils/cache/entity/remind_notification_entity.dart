import 'package:hive/hive.dart';

import '../hive_constants.dart';

part 'remind_notification_entity.g.dart';

@HiveType(typeId: HiveConst.remindNotificationTypeId)
class RemindNotificationEntity extends HiveObject {
  static const String TABLE_NAME = HiveConst.remindNotificationTableName;

  @HiveField(0)
  final int offsetDaysFromBirthday;

  @HiveField(1)
  final int offsetMonthFromBirthday;

  RemindNotificationEntity(this.offsetDaysFromBirthday, this.offsetMonthFromBirthday);

  @override
  String toString() {
    return "RemindNotificationEntity(offsetDaysFromBirthday=$offsetDaysFromBirthday, "
        "offsetMonthFromBirthday=$offsetMonthFromBirthday)";
  }
}
