import 'package:birthday_gift/core/model/person.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/usecase/create_or_update_product.dart';
import '../../domain/exception/require_person_field_exception.dart';

class PersonManagerCubit extends Cubit<PersonCreateState> {
  final CreateOrUpdatePerson _createOrUpdatePerson;

  PersonManagerCubit(this._createOrUpdatePerson) : super(ApplyData());

  void createOrUpdatePerson(Person person) {
    emit(ApplyData());
    _createOrUpdatePerson(person).then((_) => emit(Finish())).onError((error, stackTrace) {
      print(error);
      if (error is RequirePersonFiledException) {
        emit(ErrorFields('Fill require fields'));
      } else {
        emit(ErrorFields('Another error'));
      }
    });
  }

  void callNumber(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}

abstract class PersonCreateState extends Equatable {
  @override
  List<Object?> get props => const <dynamic>[];
}

class ApplyData extends PersonCreateState {}

class NoApplyData extends PersonCreateState {}

class ErrorFields extends PersonCreateState {
  final String message;

  ErrorFields(this.message);
}

class Finish extends PersonCreateState {}
