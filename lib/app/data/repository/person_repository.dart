import 'dart:async';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/utils/cache/dao/person_dao.dart';

class PersonRepository {
  final PersonDao _db;

  final _onUpdatePersonsList = StreamController<Iterable<Person>>.broadcast();

  PersonRepository(this._db);

  Stream<Iterable<Person>> listenPersons() async* {
    yield await getPersons();
    yield* _onUpdatePersonsList.stream;
  }

  Future<Iterable<Person>> getPersons() async {
    return (await _db.getPersons())
        .entries
        .map((person) => Person.fromEntity(person.value, person.key))
        .toList();
  }

  Future<Person?> getPerson(int personId) async {
    final personEntity = (await _db.getPersons())[personId];
    return personEntity != null ? Person.fromEntity(personEntity, personId) : null;
  }

  Future<void> createPerson(Person person) async {
    await _db.addPerson(person.toEntity());
    _onUpdatePersonsList.add(await getPersons());
  }

  Future<void> updatePerson(Person person) async {
    await _db.updatePerson(person.id, person.toEntity());
    _onUpdatePersonsList.add(await getPersons());
  }
}
