import 'remind_notification.dart';
import 'package:birthday_gift/utils/cache/entity/note_entity.dart';
import 'package:birthday_gift/utils/cache/entity/person_entity.dart';

import 'date.dart';
import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final int id;
  final String name;
  final Date birthday;
  final String note;
  final String phone;
  final List<RemindNotification> remindNotifications;
  final String imgUrl;

  String get initials {
    final split = name.split(RegExp(" "));
    if (split.length == 1) {
      if (name.length > 2) {
        return name.substring(0, 2);
      } else {
        return name;
      }
    } else {
      return "${split[0].substring(0, 1)}${split[1].substring(0, 1)}";
    }
  }

  String getNotificationMessage() {
    return birthday.isTodayWithoutYear() ? "Make happy $name today!" : "$name's birthday is coming soon";
  }

  bool isIncludeRemindNotificationForToday() {
    return remindNotifications.map((remind) {
      final offsetDay = remind.offsetDaysFromBirthday + remind.offsetMonthFromBirthday * 30;
      return birthday.add(Duration(days: offsetDay));
    }).where((remindDate) => remindDate.isTodayWithoutYear()).isNotEmpty;
  }

  static const int invalidId = -1;

  const NotificationModel({
    required this.name,
    required this.birthday,
    this.phone = "",
    this.imgUrl = "",
    this.note = "",
    this.remindNotifications = const [],
    this.id = invalidId,
  });

  factory NotificationModel.forTest(Date birthday, List<RemindNotification> remindNotifications) =>
      NotificationModel(name: "", birthday: birthday, remindNotifications: remindNotifications);

  factory NotificationModel.fromEntity(PersonEntity entity, int id) {
    return NotificationModel(
      name: entity.name,
      birthday: Date.birthdayString(entity.birthday),
      phone: entity.phone ?? "",
      imgUrl: entity.imgUrl ?? "",
      note: entity.note?.first.text ?? "",
      remindNotifications: entity.remindNotifications.map((it) => RemindNotification.fromEntity(it)).toList(),
      id: id,
    );
  }

  PersonEntity toEntity() {
    return PersonEntity(
      name,
      birthday.toBirthdayString(),
      phone.isEmpty ? null : phone,
      imgUrl.isEmpty ? null : imgUrl,
      Date().toIso8601String(),
      note.isEmpty ? null : [NoteEntity(note)],
      remindNotifications.map((it) => it.toEntity()).toList(),
      Date().toIso8601String(),
      Date().toIso8601String(),
    );
  }

  @override
  List<Object?> get props => [id, name, phone];

  @override
  String toString() {
    return "Person(name=$name, birthday=$birthday, phone=$phone, imgUrl=$imgUrl, "
        "note=$note,remindNotifications=$remindNotifications,id=$id)";
  }
}

enum NotificationRequireFields { name, birthday }
