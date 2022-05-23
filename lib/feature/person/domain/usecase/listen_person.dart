import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:birthday_gift/utils/logger/logger.dart';

import '../../data/repository/person_repository.dart';
import 'persons_sort.dart';

class ListenPersons implements UseCaseStream<List<Person>, NoParams> {
  final PersonRepository _personRepository;
  final PersonsSort _personsSort;

  const ListenPersons(this._personRepository, this._personsSort);

  @override
  Stream<List<Person>> call([NoParams? params]) {
    return _personRepository.listenPersons().asyncMap((personsList) async {
      final personsResult = await _personsSort(personsList);
      Log.i("Persons: $personsResult");
      return personsResult;
    });
  }
}
