import 'package:birthday_gift/core/model/notification_model.dart';

abstract class OnListenNotifications {
  Stream<Iterable<NotificationModel>> listen();
}