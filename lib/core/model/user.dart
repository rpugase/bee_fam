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

  static const int invalidId = -1;

  const User(this.phone, this.notifications, this.createdDate, this.updatedDate, this.lastSyncDate, {this.id = invalidId});

  factory User.fromAuthUserCredentials(AuthUserCredentials authUserCredentials) => User(
    authUserCredentials.phoneNumber,
    const [],
    Date(),
    Date(),
    null,
  );

  factory User.fromEntity(UserEntity userEntity) => User(
    userEntity.phone,
    const [],
    Date.millis(userEntity.createdDate),
    Date.millis(userEntity.updatedDate),
    Date.millis(userEntity.lastSyncDate),
  );

  UserEntity toUserEntity() => UserEntity(
        phone,
        const [],
        createdDate.toMilliseconds(),
        updatedDate.toMilliseconds(),
        lastSyncDate?.toMilliseconds() ?? 0,
      );

  @override
  List<Object?> get props => const [];
}
