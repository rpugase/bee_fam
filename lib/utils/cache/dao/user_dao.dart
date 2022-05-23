import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../entity/user_entity.dart';

class UserDao {
  final Box<UserEntity> _boxUser;

  const UserDao(this._boxUser);

  Future<Map<int, UserEntity>> getUsers() async {
    return Map.fromIterable(_boxUser.keys, key: (key) => key as int, value: (value) => _boxUser.get(value)!);
  }

  Future<int> addUser(UserEntity userEntity) async {
    Log.i("Add userEntity=$userEntity");
    return _boxUser.add(userEntity);
  }

  Future<void> updateUser(int index, UserEntity userEntity) async {
    Log.i("Update userEntity=$userEntity");
    return _boxUser.putAt(index, userEntity);
  }

  Future<void> deleteUser(int index) async {
    Log.i("Delete userEntity=$index");
    return _boxUser.deleteAt(index);
  }
}
