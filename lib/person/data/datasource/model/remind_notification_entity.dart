import 'package:hive/hive.dart';

part 'remind_notification_entity.g.dart';

@HiveType(typeId: 3)
class RemindNotificationEntity extends HiveObject {

  static const String TABLE_NAME = "RemindNotification";

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
