import 'package:hive_flutter/hive_flutter.dart';

import '../entity/notification_entity.dart';

class NotificationDao {
  final Box<NotificationEntity> _boxNotifications;

  const NotificationDao(this._boxNotifications);

  Future<Map<int, NotificationEntity>> getPersons() async {
    return { for (var e in _boxNotifications.keys) e as int : _boxNotifications.get(e)! };
  }

  Future<int> addNotification(NotificationEntity notificationEntity) {
    return _boxNotifications.add(notificationEntity);
  }

  Future<void> updateNotification(int key, NotificationEntity notificationEntity) {
    return _boxNotifications.put(key, notificationEntity);
  }

  Future<void> deleteNotification(int key) {
    return _boxNotifications.delete(key);
  }
}
