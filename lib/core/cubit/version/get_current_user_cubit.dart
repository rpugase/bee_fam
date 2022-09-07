import 'package:birthday_gift/core/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class OnGetCurrentUser {
  Future<User?> getCurrentUser();
}

class CurrentUserCubit extends Cubit<CurrentUserState> {

  final OnGetCurrentUser _onGetCurrentUser;

  CurrentUserCubit(this._onGetCurrentUser) : super(NoUser()) {
    _onGetCurrentUser.getCurrentUser().then((user) => _onUserLoaded(user));
  }

  _onUserLoaded(User? user) {
    emit(user != null ? ShowData(user) : NoUser());
  }
}

abstract class CurrentUserState extends Equatable {
  @override
  List<Object?> get props => const <dynamic>[];
}

class ShowData extends CurrentUserState {
  final User user;

  ShowData(this.user);

  @override
  List<Object?> get props => [user];
}

class NoUser extends CurrentUserState {}

class Error extends CurrentUserState {}