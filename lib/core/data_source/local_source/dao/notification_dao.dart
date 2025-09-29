import 'package:birthday_gift/utils/logger/logger.dart';

import '../entity/notification_entity.dart';
import 'Box.dart';

class NotificationDao {
  final Box<NotificationEntity> _boxNotifications = Box();

  Future<Map<int, NotificationEntity>> getNotifications() async {
    return _boxNotifications.all;
    // return { for (var e in _boxNotifications.keys) e as int : _boxNotifications.get(e)! };
  }

  Future<int> addNotification(NotificationEntity notificationEntity) {
    Log.i("Add notificationEntity: $notificationEntity");
    return _boxNotifications.add(notificationEntity);
  }

  Future<Iterable<int>> addNotifications(Iterable<NotificationEntity> notificationEntities) {
    return _boxNotifications.addAll(notificationEntities);
  }

  Future<void> updateNotification(int key, NotificationEntity notificationEntity) {
    return _boxNotifications.put(key, notificationEntity);
  }

  Future<void> deleteNotification(int key) {
    return _boxNotifications.delete(key);
  }

  Future<void> deleteNotifications(Iterable<int> ids) {
    return _boxNotifications.deleteAll(ids);
  }
}
