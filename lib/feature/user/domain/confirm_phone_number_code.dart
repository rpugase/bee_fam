import 'package:birthday_gift/feature/user/domain/exception/user_exceptions.dart';
import 'package:birthday_gift/utils/cache/dao/user_dao.dart';
import 'package:birthday_gift/core/model/user.dart';
import 'package:birthday_gift/core/use_case.dart';
import '../data/firebase_auth_datastore.dart';

class ConfirmPhoneNumberCode extends UseCase<void, String> {
  final FirebaseAuthDatastore _firebaseAuthDatastore;
  final UserDao _userDao;

  ConfirmPhoneNumberCode(this._firebaseAuthDatastore, this._userDao);

  @override
  Future<void> call(String confirmationCode) async {
    if (confirmationCode.isEmpty) throw EmptyCodeException();
    final authUserCredentials = await _firebaseAuthDatastore.completeSmsCode(confirmationCode);
    if (authUserCredentials != null) {
      await _userDao.addUser(User.fromAuthUserCredentials(authUserCredentials).toUserEntity());
    } else {
      throw IncorrectCodeException();
    }
  }
}
