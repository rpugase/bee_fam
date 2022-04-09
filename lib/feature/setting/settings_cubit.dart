import 'package:birthday_gift/core/model/user.dart';
import 'package:birthday_gift/feature/user/domain/get_current_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {

  final GetCurrentUser _getCurrentUser;

  SettingsCubit(this._getCurrentUser) : super(Loading()) {
    _getCurrentUser().then((user) => _onUserLoaded(user));
  }

  _onUserLoaded(User? user) {
    emit(user != null ? ShowData(user) : Error());
  }
}

abstract class SettingsState extends Equatable {
  @override
  List<Object?> get props => const <dynamic>[];
}

class Loading extends SettingsState {}

class ShowData extends SettingsState {
  final User user;

  ShowData(this.user);

  @override
  List<Object?> get props => [user];
}

class Error extends SettingsState {}