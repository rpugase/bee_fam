import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/feature/user/data/auth_user_credentials.dart';
import 'package:birthday_gift/local_data_source/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String phone;
  final List<Person> persons;
  final Date createdDate;
  final Date updatedDate;
  final Date? lastSyncDate;

  static const int INVALID_ID = -1;

  User(this.phone, this.persons, this.createdDate, this.updatedDate, this.lastSyncDate, {this.id = INVALID_ID});

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
