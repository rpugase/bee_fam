import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/person/data/datasource/model/note_entity.dart';
import 'package:birthday_gift/person/data/datasource/model/person_entity.dart';
import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final int id;
  final String name;
  final Date birthday;
  final String note;
  final String phone;
  final int notificationOffsetDays;
  final String imgUrl;

  int get daysLeft => Date().daysLeft(birthday);

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
    this.notificationOffsetDays = 0,
    this.id = INVALID_ID,
  });

  factory Person.fromEntity(PersonEntity entity, int id) {
    return Person(
      name: entity.name,
      birthday: Date.birthdayString(entity.birthday),
      phone: entity.phone ?? "",
      imgUrl: entity.imgUrl ?? "",
      note: entity.note?.first.text ?? "",
      notificationOffsetDays: entity.notificationOffsetDays ?? 0,
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
      notificationOffsetDays == 0 ? null : notificationOffsetDays,
      Date().toIso8601String(),
      Date().toIso8601String(),
    );
  }

  @override
  List<Object?> get props => [id, name];
}

enum PersonRequireFields { NAME, BIRTHDAY }
