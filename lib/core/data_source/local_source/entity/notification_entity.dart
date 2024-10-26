import 'package:hive/hive.dart';

import '../hive_constants.dart';
import 'note_entity.dart';
import 'remind_notification_entity.dart';

part 'notification_entity.g.dart';

@HiveType(typeId: HiveConst.personTypeId)
class NotificationEntity extends HiveObject {

  static Future<Box<NotificationEntity>> createBox() async {
    return Hive.openBox<NotificationEntity>(HiveConst.personTableName);
  }

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String birthday;

  @HiveField(2)
  final String? phone;

  @HiveField(3)
  final String? imgUrl;

  @HiveField(4)
  final String updateDate;

  @HiveField(5)
  final List<NoteEntity> note;

  @HiveField(6)
  final List<RemindNotificationEntity> remindNotifications;

  @HiveField(7)
  final String createdDate;

  @HiveField(8)
  final String updatedDate;

  @HiveField(9)
  final String? remoteId;

  @HiveField(10, defaultValue: true)
  final bool isSynced;

  NotificationEntity(
      this.name,
      this.birthday,
      this.phone,
      this.imgUrl,
      this.updateDate,
      this.note,
      this.remindNotifications,
      this.createdDate,
      this.updatedDate,
      this.remoteId,
      this.isSynced,
  );

  @override
  String toString() {
    return "PersonEntity(name=$name, birthday=$birthday, phone=$phone, imgUrl=$imgUrl, updateDate=$updateDate, "
        "note=$note, remindNotifications=${remindNotifications.toList()}, "
        "createdDate=$createdDate, updatedDate=$updatedDate, remoteId=$remoteId, isSynced=$isSynced)";
  }
}
