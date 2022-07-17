import 'package:birthday_gift/app/data/repository/person_repository.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:birthday_gift/utils/logger/logger.dart';

import 'persons_sort.dart';

class GetPersons implements UseCase<Iterable<Person>, NoParams> {
  final PersonRepository _personRepository;
  final PersonsSort _personsSort;

  const GetPersons(this._personRepository, this._personsSort);

  @override
  Future<Iterable<Person>> call([NoParams? params]) async {
    final persons = await _personsSort(await _personRepository.getPersons());
    Log.i("Persons: $persons");
    return persons;
  }
}
