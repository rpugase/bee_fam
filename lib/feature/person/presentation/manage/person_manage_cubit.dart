import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/feature/person/domain/person_error_handler.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import '../../domain/usecase/create_or_update_product.dart';

class PersonManagerCubit extends BaseCubit<PersonManageState> {
  final CreateOrUpdatePerson _createOrUpdatePerson;

  PersonManagerCubit(this._createOrUpdatePerson) : super(ApplyData());

  @override
  BlocError getErrorTemplate(Exception exception) {
    return NotificationError(exception, PersonErrorHandler());
  }

  void createOrUpdatePerson(Person person) {
    launch(() async {
      emit(ApplyData());
      await _createOrUpdatePerson(person);
      emit(Finish());
    }, null);
  }

  void callNumber(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await urlLauncher.canLaunch(url)) {
      await urlLauncher.launch(url);
    } else {
      Log.e('Could not launch $url');
      addError(Exception("No find "));
    }
  }
}

abstract class PersonManageState extends BlocState {}

class ApplyData extends PersonManageState {}

class NoApplyData extends PersonManageState {}

class NotificationError extends BlocError {
  NotificationError(Exception exception, ErrorHandler errorHandler) : super(exception, errorHandler);
}

class Finish extends PersonManageState {}
