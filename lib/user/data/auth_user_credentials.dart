import 'package:firebase_auth/firebase_auth.dart';

class AuthUserCredentials {
  final String phoneNumber;

  AuthUserCredentials(this.phoneNumber);

  AuthUserCredentials.fromFirebase(UserCredential authCredential)
       : phoneNumber = authCredential.user?.phoneNumber ?? "";

  bool get isValid => phoneNumber.isNotEmpty;
}
