import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/firebase_auth_datastore.dart';
import '../domain/auth_with_phone_number.dart';
import '../domain/confirm_phone_number_code.dart';

class AuthCubit extends Cubit<AuthState> {

  final AuthWithPhoneNumber _authWithPhoneNumber;
  final ConfirmPhoneNumberCode _confirmPhoneNumberCode;

  AuthCubit(this._authWithPhoneNumber, this._confirmPhoneNumberCode) : super(EnterPhoneNumber());

  void onAuth(String phoneNumberOrCode) {
    print("$phoneNumberOrCode $state");
    if (state is EnterPhoneNumber || state is ErrorOnEnterPhoneNumber) {
      emit(LoadingPhoneNumber());
      _authWithPhoneNumber(phoneNumberOrCode)
          .then((stream) => stream.listen((event) =>
          event is Complete ? emit(SuccessCode()) : emit(EnterCode())
      ).onError((error) { emit(ErrorOnEnterPhoneNumber(error.toString())); }))
          .onError((error, stackTrace) => emit(ErrorOnEnterPhoneNumber(error.toString())));
    } else if (state is EnterCode || state is ErrorOnEnterCodeNumber) {
      emit(LoadingConfirmationCode());
      _confirmPhoneNumberCode(phoneNumberOrCode)
          .onError((error, stackTrace) => emit(ErrorOnEnterCodeNumber(error.toString())));
    }
  }

  @override
  void emit(AuthState state) {
    print(state);
    super.emit(state);
  }
}

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => const <dynamic>[];
}

class LoadingPhoneNumber extends AuthState {}

class LoadingConfirmationCode extends AuthState {}

class EnterPhoneNumber extends AuthState {}

class EnterCode extends AuthState {}

class SuccessCode extends AuthState {}

class Error extends AuthState {
  final String error;

  Error(this.error);

  @override
  List<Object?> get props => [error];
}

class ErrorOnEnterPhoneNumber extends Error {
  ErrorOnEnterPhoneNumber(String error) : super(error);
}

class ErrorOnEnterCodeNumber extends Error {
  ErrorOnEnterCodeNumber(String error) : super(error);
}