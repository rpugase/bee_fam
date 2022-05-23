import 'package:birthday_gift/core/base_cubit.dart';
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
    return Error(exception, _userErrorHandler);
  }

  void onAuth(String phoneNumberOrCode) {
    Log.i("$phoneNumberOrCode $state");
    if (state is EnterPhoneNumber || state is ErrorOnEnterPhoneNumber) {
      emit(LoadingPhoneNumber());
      _authWithPhoneNumber(phoneNumberOrCode)
          .then((stream) =>
              stream
                  .listen((event) => event is Complete ? emit(SuccessCode()) : emit(EnterCode()))
                  .onError((error) => _handleUserException(error, phone: true)))
          .onError((error, stackTrace) => _handleUserException(error ?? Object(), phone: true));
    } else if (state is EnterCode || state is ErrorOnEnterCodeNumber) {
      emit(LoadingConfirmationCode());
      _confirmPhoneNumberCode(phoneNumberOrCode)
          .onError((error, stackTrace) => _handleUserException(error ?? Object(), code: true));
    }
  }

  void _handleUserException(Object error, {bool phone = false, bool code = false}) {
    if (error is UserException) {
      if (phone) emit(ErrorOnEnterPhoneNumber(error, _userErrorHandler));
      else if (code) emit(ErrorOnEnterCodeNumber(error, _userErrorHandler));
      else addError(error);
    } else {
      addError(error);
    }
  }
}

abstract class AuthState extends BlocState {}

class LoadingPhoneNumber extends AuthState {}

class LoadingConfirmationCode extends AuthState {}

class EnterPhoneNumber extends AuthState {}

class EnterCode extends AuthState {}

class SuccessCode extends AuthState {}

class Error extends BlocError implements AuthState {
  Error(Exception exception, ErrorHandler errorHandler) : super(exception, errorHandler);
}

class ErrorOnEnterPhoneNumber extends Error {
  ErrorOnEnterPhoneNumber(Exception exception, ErrorHandler errorHandler) : super(exception, errorHandler);
}

class ErrorOnEnterCodeNumber extends Error {
  ErrorOnEnterCodeNumber(Exception exception, ErrorHandler errorHandler) : super(exception, errorHandler);
}
