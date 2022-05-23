import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/feature/person/domain/person_error_handler.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/usecase/create_or_update_product.dart';

class PersonManagerCubit extends BaseCubit<PersonCreateState> {
  final CreateOrUpdatePerson _createOrUpdatePerson;

  PersonManagerCubit(this._createOrUpdatePerson) : super(ApplyData());

  @override
  BlocError getErrorTemplate(Exception exception) {
    return Error(exception, PersonErrorHandler());
  }

  void createOrUpdatePerson(Person person) {
    emit(ApplyData());
    _createOrUpdatePerson(person).then((_) => emit(Finish())).onError(addError);
  }

  void callNumber(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Log.e('Could not launch $url');
      addError(Exception("No find "));
    }
  }
}

abstract class PersonCreateState extends BlocState {}

class ApplyData extends PersonCreateState {}

class NoApplyData extends PersonCreateState {}

class Error extends BlocError implements PersonCreateState {
  Error(Exception exception, ErrorHandler errorHandler) : super(exception, errorHandler);
}

class Finish extends PersonCreateState {}
