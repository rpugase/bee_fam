import 'package:birthday_gift/app/data/repository/notification_repository.dart';
import 'package:birthday_gift/app/data/repository/shown_notification_repository.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/utils/base/use_case.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:collection/collection.dart';

class GetNotificationsForShowing implements UseCase<Iterable<NotificationModel>, NoParams> {
  final NotificationRepository notificationRepository;
  final ShownNotificationRepository shownNotificationRepository;

  const GetNotificationsForShowing(this.notificationRepository, this.shownNotificationRepository);

  @override
  Future<Iterable<NotificationModel>> call([NoParams? params]) async {
    // Get all notifications which need to show by RemindNotification
    final notificationsForToday = (await notificationRepository.getNotifications())
        .where((notification) => notification.isIncludeRemindNotificationForToday());

    // Take all shownNotification which shown today
    final shownNotifications = await shownNotificationRepository.getNotifications();
    final showNotificationsToday =
        shownNotifications.where((shownNotification) => shownNotification.shownDate.isToday());

    // Filter
    final notificationsForShowing = notificationsForToday.where((notification) =>
    showNotificationsToday.firstWhereOrNull((sn) => notification.id == sn.notificationId) == null);

    Log.i("Notifications for today: $notificationsForToday");
    Log.i("Today shown notificationsId: ${showNotificationsToday.map((e) => e.notificationId)}");
    Log.i("Notifications for showing: $notificationsForShowing");

    return notificationsForShowing;
  }
}
