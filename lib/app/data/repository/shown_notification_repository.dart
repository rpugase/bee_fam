import 'package:birthday_gift/core/model/shown_notification.dart';
import 'package:birthday_gift/utils/cache/dao/shown_notification_dao.dart';

class ShownNotificationRepository {

  final ShownNotificationDao shownNotificationDao;

  const ShownNotificationRepository(this.shownNotificationDao);

  Future<Iterable<ShownNotification>> getNotifications() async {
    return (await shownNotificationDao.getAllShownNotifications())
        .values
        .map((snEntity) => ShownNotification.fromEntity(snEntity));
  }

  Future<ShownNotification?> getNotification(int notificationId) async {
    final notificationEntity = (await shownNotificationDao.getAllShownNotifications())[notificationId];
    return notificationEntity == null ? null : ShownNotification.fromEntity(notificationEntity);
  }

  Future<void> addNotification(ShownNotification shownNotification) async {
    await shownNotificationDao.addShownNotification(shownNotification.toEntity());
  }
}
