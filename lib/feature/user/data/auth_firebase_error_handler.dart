import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthFirebaseErrorHandler extends ErrorHandler {
  @override
  String getErrorMessage(BuildContext context, Exception exception) {
    if (exception is FirebaseAuthException) {
      switch (exception.code) {
        case "id-token-expired" : break;
        case "id-token-revoked" : break;
        case "internal-error" : break;
        case "phone-number-already-exists" : break;
        case "invalid-phone-number" :
          return context.strings.error_phone_incorrect;
        case "network-request-failed" :
          return context.strings.error_no_internet;
      }
    }
    return "";
  }
}
