import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../entity/shown_notification_entity.dart';

class ShownNotificationDao {
  final Box<ShownNotificationEntity> _boxShownNotification;

  ShownNotificationDao(this._boxShownNotification);

  Future<Map<int, ShownNotificationEntity>> getAllShownNotifications() async {
    return Map.fromIterable(
      _boxShownNotification.keys,
      key: (key) => key as int,
      value: (value) => _boxShownNotification.get(value)!,
    );
  }

  Future<int> addShownNotification(ShownNotificationEntity personEntity) async {
    Log.i("Shown notification=$personEntity");
    return _boxShownNotification.add(personEntity);
  }
}
