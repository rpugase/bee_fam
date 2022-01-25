import 'package:birthday_gift/core/model/person.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String phone;
  final List<Person> persons;
  final int notificationOffsetDays;

  const User(this.id, this.phone, this.persons, this.notificationOffsetDays);

  @override
  List<Object?> get props => [];
}
