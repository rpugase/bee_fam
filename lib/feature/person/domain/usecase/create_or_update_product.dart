import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:birthday_gift/utils/logger/logger.dart';

import '../../data/repository/person_repository.dart';
import '../exception/require_person_field_exception.dart';

class CreateOrUpdatePerson implements UseCase<void, Person> {
  final PersonRepository _personRepository;

  const CreateOrUpdatePerson(this._personRepository);

  @override
  Future<void> call(Person person) async {
    Log.i("Start manage or update person: $person");
    final requireFields = <PersonRequireFields>[];
    if (person.name.isEmpty) requireFields.add(PersonRequireFields.NAME);
    if (!person.birthday.isValid || person.birthday == Date.defaultBirthday())
      requireFields.add(PersonRequireFields.BIRTHDAY);
    if (requireFields.isNotEmpty)
      throw RequirePersonFiledException(requireFields);

    if (person.id == Person.INVALID_ID) {
      Log.i("Create person: $person");
      await _personRepository.createPerson(person);
    } else {
      Log.i("Update person: $person");
      await _personRepository.updatePerson(person);
    }
  }
}
