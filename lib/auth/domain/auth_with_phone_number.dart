import 'package:birthday_gift/auth/data/firebase_auth_datastore.dart';
import 'package:birthday_gift/core/use_case.dart';

class AuthWithPhoneNumber implements UseCase<Stream<AuthEvent>, String> {

  final FirebaseAuthDatastore _firebaseAuthDatastore;

  AuthWithPhoneNumber(this._firebaseAuthDatastore);

  @override
  Future<Stream<AuthEvent>> call(String phoneNumber) async {
    print("AuthWithPhoneNumber phoneNumber=$phoneNumber");
    if (phoneNumber.isEmpty) throw Exception();
    _firebaseAuthDatastore.startAuth(phoneNumber);
    return _firebaseAuthDatastore.phoneStream;
  }
}
