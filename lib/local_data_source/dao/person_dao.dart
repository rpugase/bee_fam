import 'package:birthday_gift/local_data_source/entity/note_entity.dart';
import 'package:birthday_gift/local_data_source/entity/person_entity.dart';
import 'package:birthday_gift/local_data_source/entity/user_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PersonDao {
  final Box<UserEntity> _boxUser;
  final Box<PersonEntity> _boxPerson;
  final Box<NoteEntity> _boxNote;

  const PersonDao(this._boxPerson, this._boxNote, this._boxUser);

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
