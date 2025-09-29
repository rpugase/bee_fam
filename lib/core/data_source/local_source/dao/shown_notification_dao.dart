import 'package:birthday_gift/core/data_source/local_source/dao/Box.dart';
import 'package:birthday_gift/utils/logger/logger.dart';

import '../entity/shown_notification_entity.dart';

class ShownNotificationDao {
  final Box<ShownNotificationEntity> _boxShownNotification = Box();

  ShownNotificationDao();

  Future<Map<int, ShownNotificationEntity>> getAllShownNotifications() async {
    return _boxShownNotification.all;
    // return { for (var e in _boxShownNotification.keys) e as int : _boxShownNotification.get(e)! };
  }

  Future<int> addShownNotification(ShownNotificationEntity shownNotificationEntity) async {
    Log.i("Shown notification=$shownNotificationEntity");
    return _boxShownNotification.add(shownNotificationEntity);
  }
}
