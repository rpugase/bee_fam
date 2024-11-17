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
  final String? googleRemoteId;

  @HiveField(10, defaultValue: false)
  final bool isDeleted; // document will be deleted after remote synchronization

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
      this.googleRemoteId,
      this.isDeleted,
  );


  NotificationEntity copyWith({
    String? name,
    String? birthday,
    String? phone,
    String? imgUrl,
    String? updateDate,
    List<NoteEntity>? note,
    List<RemindNotificationEntity>? remindNotifications,
    String? createdDate,
    String? updatedDate,
    String? googleRemoteId,
    bool? isDeleted,
  }) {
    return NotificationEntity(
        name ?? this.name,
        birthday ?? this.birthday,
        phone ?? this.phone,
        imgUrl ?? this.imgUrl,
        updateDate ?? this.updateDate,
        note ?? this.note,
        remindNotifications ?? this.remindNotifications,
        createdDate ?? this.createdDate,
        updatedDate ?? this.updatedDate,
        googleRemoteId ?? this.googleRemoteId,
        isDeleted ?? this.isDeleted,
    );
  }

  @override
  String toString() {
    return "PersonEntity(name=$name, birthday=$birthday, phone=$phone, imgUrl=$imgUrl, updateDate=$updateDate, "
        "note=$note, remindNotifications=${remindNotifications.toList()}, "
        "createdDate=$createdDate, updatedDate=$updatedDate, googleRemoteId=$googleRemoteId)";
  }
}
