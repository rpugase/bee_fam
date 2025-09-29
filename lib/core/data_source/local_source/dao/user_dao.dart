import 'package:birthday_gift/core/data_source/local_source/dao/Box.dart';
import 'package:birthday_gift/utils/logger/logger.dart';

import '../entity/user_entity.dart';

class UserDao {
  final Box<UserEntity> _boxUser = Box();

  Future<Map<int, UserEntity>> getUsers() async {
    return _boxUser.all;
    // return { for (var e in _boxUser.keys) e as int : _boxUser.get(e)! };
  }

  Future<int> addUser(UserEntity userEntity) async {
    Log.i("Add userEntity=$userEntity");
    return _boxUser.add(userEntity);
  }

  Future<void> updateUser(int index, UserEntity userEntity) async {
    Log.i("Update userEntity=$userEntity");
    return _boxUser.put(index, userEntity);
  }

  Future<void> deleteUser(int index) async {
    Log.i("Delete userEntity=$index");
    return _boxUser.delete(index);
  }
}
