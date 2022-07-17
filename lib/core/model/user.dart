import 'package:birthday_gift/feature/user/data/auth_user_credentials.dart';
import 'package:birthday_gift/utils/cache/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

import 'date.dart';
import 'notification_model.dart';

class User extends Equatable {
  final int id;
  final String phone;
  final List<NotificationModel> notifications;
  final Date createdDate;
  final Date updatedDate;
  final Date? lastSyncDate;

  static const int INVALID_ID = -1;

  User(this.phone, this.notifications, this.createdDate, this.updatedDate, this.lastSyncDate, {this.id = INVALID_ID});

  factory User.fromAuthUserCredentials(AuthUserCredentials authUserCredentials) => User(
    authUserCredentials.phoneNumber,
    [],
    Date(),
    Date(),
    null,
  );

  factory User.fromEntity(UserEntity userEntity) => User(
    userEntity.phone,
    [],
    Date.millis(userEntity.createdDate),
    Date.millis(userEntity.updatedDate),
    Date.millis(userEntity.lastSyncDate),
  );

  UserEntity toUserEntity() => UserEntity(
        phone,
        [],
        createdDate.toMilliseconds(),
        updatedDate.toMilliseconds(),
        lastSyncDate?.toMilliseconds() ?? 0,
      );

  @override
  List<Object?> get props => [];
}
