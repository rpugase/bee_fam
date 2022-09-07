import 'package:birthday_gift/app/app_initialization.dart';
import 'package:birthday_gift/app/data/repository/notification_repository.dart';
import 'package:birthday_gift/app/data/repository/shown_notification_repository.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:birthday_gift/utils/cache/dao/notification_dao.dart';
import 'package:birthday_gift/utils/cache/dao/shown_notification_dao.dart';
import 'package:birthday_gift/utils/cache/entity/notification_entity.dart';
import 'package:birthday_gift/utils/cache/entity/shown_notification_entity.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:birthday_gift/app/data/datasource/notification_datasource.dart';

import 'approve_notification.dart';
import 'get_notifications_for_showing.dart';

class GetTodayNotification extends UseCase<void, NoParams> {
  final NotificationDataSource notificationService;
  final GetNotificationsForShowing getNotificationsForShowing;
  final ApproveNotification approveNotification;

  GetTodayNotification(
    this.notificationService,
    this.getNotificationsForShowing,
    this.approveNotification,
  );

  @override
  Future<void> call([NoParams? params]) async {
    Log.i("Start birthday notification service");

    final notificationsForShowing = await getNotificationsForShowing();

    notificationService.show(notificationsForShowing.map((nfs) {
      return PushNotificationModel(nfs.id, "Birthday!", nfs.getNotificationMessage(), nfs.name);
    }));
    for (var notification in notificationsForShowing) {
      if (!notification.birthday.isTodayWithoutYear()) {
        approveNotification.approve(notification.id);
      }
    }
    Log.i("End birthday notification service");
  }

  static Future<GetTodayNotification> init() async {
    await initHive();
    final personRepository = NotificationRepository(NotificationDao(await NotificationEntity.createBox()));
    final shownNotificationRepository = ShownNotificationRepository(
      ShownNotificationDao(await ShownNotificationEntity.createBox()),
    );

    return GetTodayNotification(
      NotificationDataSource()..init(),
      GetNotificationsForShowing(personRepository, shownNotificationRepository),
      ApproveNotification(shownNotificationRepository),
    );
  }
}
