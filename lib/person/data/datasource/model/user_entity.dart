import 'package:hive/hive.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 0)
class UserEntity extends HiveObject {
  static const String TABLE_NAME = "User";

  @HiveField(0)
  final String phone;

  @HiveField(1)
  final List<String> notificationsIds;

  @HiveField(2)
  final int createdDate;

  @HiveField(3)
  final int updatedDate;

  @HiveField(4)
  final int lastSyncDate;

  UserEntity(
    this.phone,
    this.notificationsIds,
    this.createdDate,
    this.updatedDate,
    this.lastSyncDate,
  );
}
