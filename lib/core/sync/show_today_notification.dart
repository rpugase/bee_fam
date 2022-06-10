import 'package:birthday_gift/app_initialization.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:birthday_gift/feature/person/data/repository/person_repository.dart';
import 'package:birthday_gift/utils/cache/dao/person_dao.dart';
import 'package:birthday_gift/utils/cache/dao/shown_notification_dao.dart';
import 'package:birthday_gift/utils/cache/entity/person_entity.dart';
import 'package:birthday_gift/utils/cache/entity/shown_notification_entity.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:birthday_gift/utils/notification/notification_service.dart';

class ShowTodayNotification extends UseCase<void, NoParams> {

  final NotificationService notificationService;
  final PersonRepository personRepository;
  final ShownNotificationDao shownNotificationDao;

  ShowTodayNotification(this.notificationService, this.personRepository, this.shownNotificationDao);

  static Future<ShowTodayNotification> init() async {
    await initHive();

    return ShowTodayNotification(
      NotificationService()..init(),
      PersonRepository(PersonDao(await PersonEntity.createBox())),
      ShownNotificationDao(await ShownNotificationEntity.createBox()),
    );
  }

  // 1. Получить нотификации которые нужно запустить сегодня
  // 2. Проверить список запущенных нотификаций сегодня
  // 3. Отфильтровать список тех, что нужно запустить по списку тех, что были запущенны за сегодня
  // 4. Запустить нотификации
  @override
  Future<void> call([NoParams? noParams]) async {
    Log.i("START");
    final notifications = (await personRepository.getPersons())
        .where((notification) => notification.isIncludeRemindNotificationForToday())
        .toList();

    Log.i(await personRepository.getPersons());
    Log.i(notifications);

    notifications.forEach((notification) {
      Log.i("notificationId=${notification.id}");
      notificationService.show(notification.id, "Birthday!", notification.getNotificationMessage());
    });
    Log.i("END");
  }
}
