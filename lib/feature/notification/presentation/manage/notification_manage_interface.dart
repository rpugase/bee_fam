import 'package:birthday_gift/core/model/notification_model.dart';

abstract class OnCreateOrUpdateNotification {
  Future<void> createOrUpdateNotification(NotificationModel notification);
}

abstract class OnDeleteNotification {
  Future<void> deleteNotification(NotificationModel notification);
}
