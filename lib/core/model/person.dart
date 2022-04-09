import 'remind_notification.dart';
import 'package:birthday_gift/utils/cache/entity/note_entity.dart';
import 'package:birthday_gift/utils/cache/entity/person_entity.dart';

import 'date.dart';
import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final int id;
  final String name;
  final Date birthday;
  final String note;
  final String phone;
  final List<RemindNotification> remindNotifications;
  final String imgUrl;

  LeftPeriod get leftPeriod => Date().dateLeft(birthday);

  String get initials {
    final split = name.split(RegExp(" "));
    if (split.length == 1) {
      if (name.length > 2) return name.substring(0, 2);
      else return name;
    } else {
      return "${split[0].substring(0, 1)}${split[1].substring(0, 1)}";
    }
  }

  static const int INVALID_ID = -1;

  const Person({
    required this.name,
    required this.birthday,
    this.phone = "",
    this.imgUrl = "",
    this.note = "",
    this.remindNotifications = const [],
    this.id = INVALID_ID,
  });

  factory Person.fromEntity(PersonEntity entity, int id) {
    return Person(
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
        "note=$note,remindNotifications,id=$id)";
  }
}

enum PersonRequireFields { NAME, BIRTHDAY }
