import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/use_case.dart';

import '../../data/repository/person_repository.dart';
import 'persons_sort.dart';

class GetPersons implements UseCase<List<Person>, NoParams> {
  final PersonRepository _personRepository;
  final PersonsSort _personsSort;

  const GetPersons(this._personRepository, this._personsSort);

  @override
  Future<List<Person>> call([NoParams? params]) async {
    final persons = await _personsSort(await _personRepository.getPersons());
    print("Persons: $persons");
    return persons;
  }
}
