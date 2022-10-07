import 'package:hive_flutter/hive_flutter.dart';

import '../hive_constants.dart';

part 'shown_notification_entity.g.dart';

@HiveType(typeId: HiveConst.shownNotificationTypeId)
class ShownNotificationEntity extends HiveObject {

  static Future<Box<ShownNotificationEntity>> createBox() async {
    return Hive.openBox<ShownNotificationEntity>(HiveConst.shownNotificationTableName);
  }

  @HiveField(0)
  final int notificationId;

  @HiveField(1)
  final String shownDate;


  ShownNotificationEntity(
    this.notificationId,
    this.shownDate,
  );

  @override
  String toString() {
    return "ShownNotificationEntity(notificationId=$notificationId, shownDate=$shownDate)";
  }
}
