import 'package:birthday_gift/utils/base/base_cubit.dart';
import 'package:birthday_gift/feature/user/domain/exception/user_exceptions.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/firebase_auth_datastore.dart';
import '../domain/auth_with_phone_number.dart';
import '../domain/confirm_phone_number_code.dart';
import '../domain/user_error_handler.dart';

class AuthCubit extends BaseCubit<AuthState> {
  final AuthWithPhoneNumber _authWithPhoneNumber;
  final ConfirmPhoneNumberCode _confirmPhoneNumberCode;
  final UserErrorHandler _userErrorHandler;

  AuthCubit(
    this._authWithPhoneNumber,
    this._confirmPhoneNumberCode,
    this._userErrorHandler,
  ) : super(EnterPhoneNumber());

  @override
  BlocError getErrorTemplate(Exception exception) {
    return AuthError(exception, _userErrorHandler);
  }

  void onAuth(String phoneNumberOrCode) {
    Log.i("$phoneNumberOrCode $state");
    if (state is EnterPhoneNumber) {
      emit(LoadingPhoneNumber());
      collect(_authWithPhoneNumber(phoneNumberOrCode), (event) async {
        event is Complete ? emit(SuccessCode()) : emit(EnterCode());
      }, (err) async => emit(EnterPhoneNumber()..withError(err)));
    } else if (state is EnterCode) {
      launch(() async {
        emit(LoadingConfirmationCode());
        await _confirmPhoneNumberCode(phoneNumberOrCode);
      }, (error) async => emit(EnterCode()..withError(error)));
    }
  }
}

abstract class AuthState extends BlocState {}

class LoadingPhoneNumber extends AuthState {}

class LoadingConfirmationCode extends AuthState {}

class EnterPhoneNumber extends AuthState {}

class EnterCode extends AuthState {}

class SuccessCode extends AuthState {}

class AuthError extends BlocError {
  AuthError(Exception exception, ErrorHandler errorHandler) : super(exception, errorHandler);
}
