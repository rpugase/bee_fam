import 'package:birthday_gift/app/app_initialization.dart';
import 'package:birthday_gift/app/data/repository/person_repository.dart';
import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:birthday_gift/utils/cache/dao/person_dao.dart';
import 'package:birthday_gift/utils/cache/dao/shown_notification_dao.dart';
import 'package:birthday_gift/utils/cache/entity/person_entity.dart';
import 'package:birthday_gift/utils/cache/entity/shown_notification_entity.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:birthday_gift/app/data/datasource/notification_datasource.dart';
import 'package:collection/collection.dart';

class ShowTodayNotification extends UseCase<void, NoParams> {
  final NotificationDataSource notificationService;
  final PersonRepository personRepository;
  final ShownNotificationDao shownNotificationDao;

  ShowTodayNotification(this.notificationService, this.personRepository, this.shownNotificationDao);

  static Future<ShowTodayNotification> init() async {
    await initHive();

    return ShowTodayNotification(
      NotificationDataSource()..init(),
      PersonRepository(PersonDao(await PersonEntity.createBox())),
      ShownNotificationDao(await ShownNotificationEntity.createBox()),
    );
  }

  @override
  Future<void> call([NoParams? noParams]) async {
    Log.i("Start birthday notification service");
    final notificationsForToday = (await personRepository.getPersons())
        .where((notification) => notification.isIncludeRemindNotificationForToday())
        .toList();

    final shownNotifications = await shownNotificationDao.getAllShownNotifications();
    final showNotificationsToday = shownNotifications.values
        .where((shownNotification) => Date.remote(shownNotification.shownDate).isToday());

    final notificationsForShowing = notificationsForToday.where((notification) =>
        showNotificationsToday.firstWhereOrNull((sn) => notification.id == sn.notificationId) == null);

    Log.i("Notifications for today: $notificationsForToday");
    Log.i("Today shown notificationsId: ${showNotificationsToday.map((e) => e.notificationId)}");
    Log.i("Notifications for showing: $notificationsForShowing");

    notificationsForShowing.forEach((notification) {
      notificationService.show(notification.id, "Birthday!", notification.getNotificationMessage());
      if (!notification.birthday.isTodayWithoutYear()) {
        shownNotificationDao.addShownNotification(ShownNotificationEntity(notification.id, Date().toIso8601String()));
      }
    });
    Log.i("End birthday notification service");
  }
}
