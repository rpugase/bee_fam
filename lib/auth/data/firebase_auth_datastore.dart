import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_user_credentials.dart';

const _COUNTER_FORCE_RESENDING_TOKEN = 1;
const _SMS_TIMEOUT = const Duration(minutes: 2);

abstract class FirebaseAuthDatastore {

  Stream<AuthEvent> get phoneStream;

  void startAuth(String phoneNumber);

  void completeSmsCode(String smsCode);
}

class FirebaseAuthDatastoreImpl implements FirebaseAuthDatastore {

  final FirebaseAuth _auth;

  FirebaseAuthDatastoreImpl(this._auth);

  final _phoneStreamController = StreamController<AuthEvent>.broadcast();

  @override
  Stream<AuthEvent> get phoneStream => _phoneStreamController.stream;

  String? _verificationId;

  @override
  void startAuth(String phoneNumber) {
    print("FirebaseAuthDatastore.startAuth phoneNumber=$phoneNumber; _verificationId=$_verificationId");
    if (_verificationId == null) {
      _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          print("verificationCompleted phoneAuthCredential=$phoneAuthCredential");
          final authUserCredentials = AuthUserCredentials.fromFirebase(await _auth.signInWithCredential(phoneAuthCredential));
          if (authUserCredentials.isValid) {
            print("verificationCompleted Complete authUserCredentials=$authUserCredentials");
            _phoneStreamController.add(Complete(authUserCredentials));
          } else {
            print("verificationCompleted Phone number no found");
            _phoneStreamController.addError(FirebaseAuthException(code: "", message: "Phone number no found"));
          }
        },
        verificationFailed: (FirebaseAuthException error) {
          print("verificationFailed $error");
          _phoneStreamController.addError(error, error.stackTrace);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          print("codeSent verificationId=$verificationId; forceResendingToken=$forceResendingToken");
          _verificationId = verificationId;
          _phoneStreamController.add(CodeSent());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("codeAutoRetrievalTimeout verificationId=$verificationId");
          _verificationId = verificationId;
        },
        timeout: _SMS_TIMEOUT,
        forceResendingToken: _COUNTER_FORCE_RESENDING_TOKEN
      );
    } else {
      print("Verification id must be null $_verificationId");
    }
  }

  @override
  void completeSmsCode(String smsCode) async {
    if (_verificationId != null) {
      final userCredentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      ));
      final authUserCredentials = AuthUserCredentials.fromFirebase(userCredentials);
      if (authUserCredentials.isValid) {
        _phoneStreamController.add(Complete(authUserCredentials));
      } else {
        _phoneStreamController.addError(FirebaseAuthException(code: "", message: "Phone number no found"));
      }
    } else {
      print("Verification id must be null $_verificationId");
    }
  }
}

class FirebaseAuthDatastoreMock implements FirebaseAuthDatastore {

  String? _verificationId;
  String? _phoneNumber;

  final _phoneStreamController = StreamController<AuthEvent>();

  @override
  Stream<AuthEvent> get phoneStream => _phoneStreamController.stream;

  @override
  void startAuth(String phoneNumber) async {
    if (_verificationId == null) {
      await Future.delayed(Duration(seconds: 1));
      _verificationId = "";
      _phoneNumber = phoneNumber;
      _phoneStreamController.add(CodeSent());
    } else {
      print("Verification id must be null $_verificationId");
    }
  }

  @override
  void completeSmsCode(String smsCode) async {
    if (_verificationId != null) {
      await Future.delayed(Duration(seconds: 1));
      _verificationId = null;
      _phoneStreamController.add(Complete(AuthUserCredentials(_phoneNumber!)));
    } else {
      print("Verification id must be null $_verificationId");
    }
  }

}

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => const <dynamic>[];
}

class Complete extends AuthEvent {
  final AuthUserCredentials userCredential;
  Complete(this.userCredential);
  @override
  List<Object?> get props => [userCredential];
}
class CodeSent extends AuthEvent {}
