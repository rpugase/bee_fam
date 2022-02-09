import 'package:birthday_gift/person/data/datasource/model/note_entity.dart';
import 'package:birthday_gift/person/data/datasource/model/person_entity.dart';
import 'package:birthday_gift/person/data/datasource/model/user_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseDatasource {
  final Box<UserEntity> _boxUser;
  final Box<PersonEntity> _boxPerson;
  final Box<NoteEntity> _boxNote;

  const DatabaseDatasource(this._boxPerson, this._boxNote, this._boxUser);

  Future<Map<int, PersonEntity>> getPersons() async {
    return Map.fromIterable(_boxPerson.keys,
        key: (key) => key as int, value: (value) => _boxPerson.get(value)!);
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
