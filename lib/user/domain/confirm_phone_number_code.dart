import 'package:birthday_gift/user/data/firebase_auth_datastore.dart';
import 'package:birthday_gift/user/data/user_dao.dart';
import 'package:birthday_gift/core/model/user.dart';
import 'package:birthday_gift/core/use_case.dart';

class ConfirmPhoneNumberCode extends UseCase<void, String> {

  final FirebaseAuthDatastore _firebaseAuthDatastore;
  final UserDao _userDao;

  ConfirmPhoneNumberCode(this._firebaseAuthDatastore, this._userDao);

  @override
  Future<void> call(String confirmationCode) async {
    if (confirmationCode.isEmpty) throw Exception();
    final authUserCredentials = await _firebaseAuthDatastore.completeSmsCode(confirmationCode);
    if (authUserCredentials != null) {
      await _userDao.addUser(User.fromAuthUserCredentials(authUserCredentials).toUserEntity());
    } else {
      throw Exception();
    }
  }
}
