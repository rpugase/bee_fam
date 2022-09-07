import 'package:birthday_gift/core/cubit/version/get_current_user_cubit.dart';
import 'package:birthday_gift/core/model/user.dart';
import 'package:birthday_gift/utils/cache/dao/user_dao.dart';

class GetCurrentUser implements OnGetCurrentUser {

  final UserDao _userDao;

  GetCurrentUser(this._userDao);

  @override
  Future<User?> getCurrentUser() async {
    final users = await _userDao.getUsers();
    if (users.isEmpty) {
      return null;
    }
    return User.fromEntity(users[0]!);
  }
}
