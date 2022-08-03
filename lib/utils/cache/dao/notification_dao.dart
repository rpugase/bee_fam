import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../entity/notification_entity.dart';

class NotificationDao {
  final Box<NotificationEntity> _boxPerson;

  const NotificationDao(this._boxPerson);

  Future<Map<int, NotificationEntity>> getPersons() async {
    return { for (var e in _boxPerson.keys) e as int : _boxPerson.get(e)! };
  }

  Future<int> addNotification(NotificationEntity notificationEntity) async {
    Log.i("Add notificationEntity=$notificationEntity");
    return _boxPerson.add(notificationEntity);
  }

  Future<void> updateNotification(int index, NotificationEntity notificationEntity) async {
    Log.i("Update notificationEntity=$notificationEntity");
    return _boxPerson.putAt(index, notificationEntity);
  }

  Future<void> deleteNotification(int index) async {
    return _boxPerson.delete(index);
  }
}
