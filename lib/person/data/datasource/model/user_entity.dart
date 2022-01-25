import 'package:hive/hive.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 0)
class UserEntity extends HiveObject {

  static const String TABLE_NAME = "User";

  @HiveField(0)
  final String? phone;

  @HiveField(1)
  final String? password;

  @HiveField(2)
  final List<String> personIds;

  @HiveField(3)
  final String createdDate;

  @HiveField(4)
  final String updatedDate;

  @HiveField(5)
  final String notificationOffsetDays;

  UserEntity(this.phone, this.password, this.personIds, this.createdDate,
      this.updatedDate, this.notificationOffsetDays);
}
