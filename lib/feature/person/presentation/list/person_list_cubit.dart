import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/feature/person/domain/person_error_handler.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecase/listen_person.dart';

class PersonListCubit extends BaseCubit<PersonListState> {
  final ListenPersons _listenPersons;

  PersonListCubit(this._listenPersons) : super(Loading());

  @override
  void onInit() {
    collect<List<Person>>(_listenPersons(), _onPersonLoaded, null);
  }

  @override
  BlocError getErrorTemplate(Exception exception) {
    return NotificationError(exception, PersonErrorHandler());
  }

  Future _onPersonLoaded(List<Person> persons) async {
    emit(persons.isEmpty ? EmptyList() : PersonsList(persons));
  }
}

abstract class PersonListState extends BlocState {}

class Loading extends PersonListState {}

class EmptyList extends PersonListState {}

class PersonsList extends PersonListState implements Equatable {
  final List<Person> persons;

  PersonsList(this.persons);

  @override
  List<Object?> get props => [persons.hashCode];

  @override
  bool? get stringify => true;
}

class NotificationError extends BlocError {
  NotificationError(Exception exception, ErrorHandler errorHandler) : super(exception, errorHandler);
}
