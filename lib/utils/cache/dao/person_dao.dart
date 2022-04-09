import 'package:hive_flutter/hive_flutter.dart';

import '../entity/note_entity.dart';
import '../entity/person_entity.dart';
import '../entity/user_entity.dart';

class PersonDao {
  final Box<UserEntity> _boxUser;
  final Box<PersonEntity> _boxPerson;
  final Box<NoteEntity> _boxNote;

  const PersonDao(this._boxPerson, this._boxNote, this._boxUser);

  Future<Map<int, PersonEntity>> getPersons() async {
    return Map.fromIterable(_boxPerson.keys, key: (key) => key as int, value: (value) => _boxPerson.get(value)!);
  }

  Future<int> addPerson(PersonEntity personEntity) async {
    print("Add personEntity=$personEntity");
    return _boxPerson.add(personEntity);
  }

  Future<void> updatePerson(int index, PersonEntity personEntity) async {
    print("Update personEntity=$personEntity");
    return _boxPerson.putAt(index, personEntity);
  }
}
