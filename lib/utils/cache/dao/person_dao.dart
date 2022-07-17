import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../entity/person_entity.dart';

class PersonDao {
  final Box<PersonEntity> _boxPerson;

  const PersonDao(this._boxPerson);

  Future<Map<int, PersonEntity>> getPersons() async {
    return { for (var e in _boxPerson.keys) e as int : _boxPerson.get(e)! };
  }

  Future<int> addPerson(PersonEntity personEntity) async {
    Log.i("Add personEntity=$personEntity");
    return _boxPerson.add(personEntity);
  }

  Future<void> updatePerson(int index, PersonEntity personEntity) async {
    Log.i("Update personEntity=$personEntity");
    return _boxPerson.putAt(index, personEntity);
  }
}
