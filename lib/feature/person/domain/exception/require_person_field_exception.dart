import 'package:birthday_gift/core/model/notification_model.dart';

class RequireNotificationFiledException implements Exception {
  final List<NotificationRequireFields> requireFields;

  const RequireNotificationFiledException(this.requireFields);
}
