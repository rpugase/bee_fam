import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../entity/shown_notification_entity.dart';

class ShownNotificationDao {
  final Box<ShownNotificationEntity> _boxShownNotification;

  ShownNotificationDao(this._boxShownNotification);

  Future<Map<int, ShownNotificationEntity>> getAllShownNotifications() async {
    return { for (var e in _boxShownNotification.keys) e as int : _boxShownNotification.get(e)! };
  }

  Future<int> addShownNotification(ShownNotificationEntity shownNotificationEntity) async {
    Log.i("Shown notification=$shownNotificationEntity");
    return _boxShownNotification.add(shownNotificationEntity);
  }
}
