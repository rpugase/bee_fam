import 'note_entity.dart';
import 'remind_notification_entity.dart';


class NotificationEntity {

  final String name;
  final String birthday;
  final String? phone;
  final String? imgUrl;
  final String updateDate;
  final List<NoteEntity> note;
  final List<RemindNotificationEntity> remindNotifications;
  final String createdDate;
  final String updatedDate;
  final String? googleRemoteId;

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
