import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:flutter/material.dart';

import 'exception/require_person_field_exception.dart';

class PersonErrorHandler implements ErrorHandler {
  @override
  String getErrorMessage(BuildContext context, Exception exception) {
    if (exception is RequirePersonFiledException) {
      return exception.requireFields.map((personRequireFields) {
        return personRequireFields == PersonRequireFields.NAME ?
        context.strings.error_name_require : context.strings.error_birthday_require;
      }).join("\n");
    } else {
      return exception.toString();
    }
  }

}