import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/feature/user/domain/exception/user_exceptions.dart';
import 'package:birthday_gift/feature/user/presentation/auth_cubit.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserErrorHandler extends ErrorHandler {
  @override
  String getErrorMessage(BuildContext context, Exception exception) {
    if (exception is EmptyPhoneNumberException) {
      return context.strings.error_phone_number_empty;
    } else if (exception is EmptyCodeException) {
      return context.strings.error_code_empty;
    } else if (exception is IncorrectCodeException) {
      return context.strings.error_code_incorrect;
    } else {
      return super.getErrorMessage(context, exception);
    }
  }
}
