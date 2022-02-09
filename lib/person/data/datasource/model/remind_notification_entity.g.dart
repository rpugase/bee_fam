// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remind_notification_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RemindNotificationEntityAdapter
    extends TypeAdapter<RemindNotificationEntity> {
  @override
  final int typeId = 3;

  @override
  RemindNotificationEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RemindNotificationEntity(
      fields[0] as int,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RemindNotificationEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.offsetDaysFromBirthday)
      ..writeByte(1)
      ..write(obj.offsetMonthFromBirthday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemindNotificationEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
