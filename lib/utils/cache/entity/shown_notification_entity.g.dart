// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shown_notification_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShownNotificationEntityAdapter
    extends TypeAdapter<ShownNotificationEntity> {
  @override
  final int typeId = 4;

  @override
  ShownNotificationEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShownNotificationEntity(
      fields[0] as int,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShownNotificationEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.notificationId)
      ..writeByte(1)
      ..write(obj.shownDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShownNotificationEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
