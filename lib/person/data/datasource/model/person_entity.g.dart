// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonEntityAdapter extends TypeAdapter<PersonEntity> {
  @override
  final int typeId = 1;

  @override
  PersonEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonEntity(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String,
      (fields[5] as List?)?.cast<NoteEntity>(),
      fields[6] as int?,
      fields[7] as String,
      fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.birthday)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.imgUrl)
      ..writeByte(4)
      ..write(obj.updateDate)
      ..writeByte(5)
      ..write(obj.note)
      ..writeByte(6)
      ..write(obj.notificationOffsetDays)
      ..writeByte(7)
      ..write(obj.createdDate)
      ..writeByte(8)
      ..write(obj.updatedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
