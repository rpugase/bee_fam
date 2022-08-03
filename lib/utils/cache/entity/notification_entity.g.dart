// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationEntityAdapter extends TypeAdapter<NotificationEntity> {
  @override
  final int typeId = 1;

  @override
  NotificationEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationEntity(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String,
      (fields[5] as List).cast<NoteEntity>(),
      (fields[6] as List).cast<RemindNotificationEntity>(),
      fields[7] as String,
      fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationEntity obj) {
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
      ..write(obj.remindNotifications)
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
      other is NotificationEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
