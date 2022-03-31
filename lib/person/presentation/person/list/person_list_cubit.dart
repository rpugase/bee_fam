import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/person/domain/usecase/listen_person.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonListCubit extends Cubit<PersonListState> {
  final ListenPersons _listenPersons;

  PersonListCubit(this._listenPersons) : super(Loading()) {
    _listenPersons().listen(_onPersonLoaded);
  }

  void _onPersonLoaded(List<Person> persons) {
    emit(persons.isEmpty ? EmptyList() : PersonsList(persons));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(Error(stackTrace.toString()));
    super.onError(error, stackTrace);
  }
}

abstract class PersonListState extends Equatable {
  @override
  List<Object?> get props => const <dynamic>[];
}

class Loading extends PersonListState {}

class EmptyList extends PersonListState {}

class PersonsList extends PersonListState {
  final List<Person> persons;

  PersonsList(this.persons);

  @override
  List<Object?> get props => [persons.hashCode];
}

class Error extends PersonListState {
  final String errorMessage;

  Error(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
