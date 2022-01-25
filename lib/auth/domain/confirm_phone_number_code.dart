import 'package:birthday_gift/auth/data/firebase_auth_datastore.dart';
import 'package:birthday_gift/core/use_case.dart';

class ConfirmPhoneNumberCode extends UseCase<void, String> {

  final FirebaseAuthDatastore _firebaseAuthDatastore;

  ConfirmPhoneNumberCode(this._firebaseAuthDatastore);

  @override
  Future<void> call(String confirmationCode) async {
    if (confirmationCode.isEmpty) throw Exception();
    return _firebaseAuthDatastore.completeSmsCode(confirmationCode);
  }
}
