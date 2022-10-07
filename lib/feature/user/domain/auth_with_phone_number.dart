import 'package:birthday_gift/utils/base/use_case.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import '../data/firebase_auth_datastore.dart';
import 'exception/user_exceptions.dart';

class AuthWithPhoneNumber implements UseCaseStream<AuthEvent, String> {
  final FirebaseAuthDatastore _firebaseAuthDatastore;

  AuthWithPhoneNumber(this._firebaseAuthDatastore);

  @override
  Stream<AuthEvent> call(String phoneNumber) async* {
    Log.i("phoneNumber=$phoneNumber");
    if (phoneNumber.isEmpty) throw EmptyPhoneNumberException();
    _firebaseAuthDatastore.startAuth(phoneNumber);
    yield* _firebaseAuthDatastore.phoneStream;
  }
}
