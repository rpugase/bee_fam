import 'package:birthday_gift/core/model/person.dart';

class RequirePersonFiledException implements Exception {
  final List<PersonRequireFields> requireFields;

  const RequirePersonFiledException(this.requireFields);
}
