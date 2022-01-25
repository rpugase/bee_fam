import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/use_case.dart';

class PersonsSort implements UseCase<List<Person>, List<Person>> {
  @override
  Future<List<Person>> call(List<Person> personsList) {
    final personsResult = personsList.toList();
    personsResult.sort((left, right) => left.birthday.toMilliseconds() - left.birthday.toMilliseconds());
    return Future.value(personsResult);
  }
}
