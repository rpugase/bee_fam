import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/feature/person/domain/person_error_handler.dart';

import '../../domain/usecase/listen_person.dart';

class PersonListCubit extends BaseCubit<PersonListState> {
  final ListenPersons _listenPersons;

  PersonListCubit(this._listenPersons) : super(Loading());

  @override
  void onInit() {
    _listenPersons().handleError(addError).listen(_onPersonLoaded);
  }

  @override
  BlocError getErrorTemplate(Exception exception) {
    return Error(exception, PersonErrorHandler());
  }

  void _onPersonLoaded(List<Person> persons) {
    emit(persons.isEmpty ? EmptyList() : PersonsList(persons));
  }
}

abstract class PersonListState extends BlocState {}

class Loading extends PersonListState {}

class EmptyList extends PersonListState {}

class PersonsList extends PersonListState {
  final List<Person> persons;

  PersonsList(this.persons);

  @override
  List<Object?> get props => [persons.hashCode];
}

class Error extends BlocError implements PersonListState {
  Error(Exception exception, ErrorHandler errorHandler) : super(exception, errorHandler);
}
