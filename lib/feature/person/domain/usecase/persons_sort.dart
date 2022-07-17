import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:collection/collection.dart';

class PersonsSort implements UseCase<Iterable<Person>, Iterable<Person>> {
  static const int monthsInYear = 12;

  @override
  Future<Iterable<Person>> call(Iterable<Person> personsList) {
    final currentMonth = DateTime.now().month;
    return Future.value(personsList.sortedByCompare<int>((person) => person.birthday.dateTime.month, (a, b) {
      final aM = a < currentMonth ? a + monthsInYear : a;
      final bM = b < currentMonth ? b + monthsInYear : b;
      return aM - bM;
    }));
  }
}
