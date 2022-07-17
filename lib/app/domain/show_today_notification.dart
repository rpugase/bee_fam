import 'package:birthday_gift/app/app_initialization.dart';
import 'package:birthday_gift/app/data/repository/notification_repository.dart';
import 'package:birthday_gift/app/data/repository/shown_notification_repository.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:birthday_gift/utils/cache/dao/person_dao.dart';
import 'package:birthday_gift/utils/cache/dao/shown_notification_dao.dart';
import 'package:birthday_gift/utils/cache/entity/person_entity.dart';
import 'package:birthday_gift/utils/cache/entity/shown_notification_entity.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:birthday_gift/app/data/datasource/notification_datasource.dart';

import 'approve_notification.dart';
import 'get_notifications_for_showing.dart';

class ShowTodayNotification extends UseCase<void, NoParams> {
  final NotificationDataSource notificationService;
  final GetNotificationsForShowing getNotificationsForShowing;
  final ApproveNotification approveNotification;

  ShowTodayNotification(
    this.notificationService,
    this.getNotificationsForShowing,
    this.approveNotification,
  );

  static Future<ShowTodayNotification> init() async {
    await initHive();
    final personRepository = NotificationRepository(PersonDao(await PersonEntity.createBox()));
    final shownNotificationRepository = ShownNotificationRepository(
      ShownNotificationDao(await ShownNotificationEntity.createBox()),
    );

    return ShowTodayNotification(
      NotificationDataSource()..init(),
      GetNotificationsForShowing(personRepository, shownNotificationRepository),
      ApproveNotification(shownNotificationRepository),
    );
  }

  @override
  Future<void> call([NoParams? params]) async {
    Log.i("Start birthday notification service");

    final notificationsForShowing = await getNotificationsForShowing();

    notificationService.show(notificationsForShowing.map((nfs) {
      return PushNotificationModel(nfs.id, "Birthday!", nfs.getNotificationMessage(), nfs.name);
    }));
    for (var notification in notificationsForShowing) {
      if (!notification.birthday.isTodayWithoutYear()) {
        approveNotification(notification.id);
      }
    }
    Log.i("End birthday notification service");
  }
}
