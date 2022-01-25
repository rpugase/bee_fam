import 'dart:async';

import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/person/data/datasource/db/db_datasource.dart';

class PersonRepository {
  final DatabaseDatasource _db;

  final _onUpdatePersonsList = StreamController<List<Person>>.broadcast();

  PersonRepository(this._db);

  Stream<List<Person>> listenPersons() {
    getPersons().then((persons) => _onUpdatePersonsList.add(persons));
    return _onUpdatePersonsList.stream;
  }

  Future<List<Person>> getPersons() async {
    return (await _db.getPersons())
        .entries
        .map((person) => Person.fromEntity(person.value, person.key))
        .toList();
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
