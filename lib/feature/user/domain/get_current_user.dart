import 'package:birthday_gift/core/model/user.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:birthday_gift/local_data_source/dao/user_dao.dart';

class GetCurrentUser implements UseCase<User?, NoParams> {

  final UserDao _userDao;

  GetCurrentUser(this._userDao);

  @override
  Future<User?> call([NoParams? params]) async {
    final users = await _userDao.getUsers();
    if (users.isEmpty) {
      return null;
    }
    return User.fromEntity(users[0]!);
  }
}
