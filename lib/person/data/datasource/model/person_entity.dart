import 'package:birthday_gift/person/data/datasource/model/remind_notification_entity.dart';
import 'package:hive/hive.dart';

import 'note_entity.dart';

part 'person_entity.g.dart';

@HiveType(typeId: 1)
class PersonEntity extends HiveObject {

  static const String TABLE_NAME = "Person";

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
  final List<NoteEntity>? note;

  @HiveField(6)
  final List<RemindNotificationEntity> remindNotifications;

  @HiveField(7)
  final String createdDate;

  @HiveField(8)
  final String updatedDate;

  PersonEntity(
    this.name,
    this.birthday,
    this.phone,
    this.imgUrl,
    this.updateDate,
    this.note,
    this.remindNotifications,
    this.createdDate,
    this.updatedDate,
  );

  @override
  String toString() {
    return "PersonEntity(name=$name, birthday=$birthday, phone=$phone, imgUrl=$imgUrl, updateDate=$updateDate, "
        "note=$note, remindNotifications=${remindNotifications.toList()}, "
        "createdDate=$createdDate, updatedDate=$updatedDate)";
  }
}
