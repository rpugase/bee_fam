import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:flutter/material.dart';

import 'exception/require_person_field_exception.dart';

class NotificationErrorHandler extends ErrorHandler {
  @override
  String getErrorMessage(BuildContext context, Exception exception) {
    if (exception is RequireNotificationFiledException) {
      return exception.requireFields.map((notificationRequireFields) {
        return notificationRequireFields == NotificationRequireFields.name
            ? context.strings.error_name_require
            : context.strings.error_birthday_require;
      }).join("\n");
    } else {
      return super.getErrorMessage(context, exception);
    }
  }
}
