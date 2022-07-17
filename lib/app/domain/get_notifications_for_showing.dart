import 'package:birthday_gift/app/data/repository/person_repository.dart';
import 'package:birthday_gift/app/data/repository/shown_notification_repository.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:collection/collection.dart';

class GetNotificationsForShowing implements UseCase<Iterable<Person>, NoParams> {
  final PersonRepository personRepository;
  final ShownNotificationRepository shownNotificationRepository;

  const GetNotificationsForShowing(this.personRepository, this.shownNotificationRepository);

  @override
  Future<Iterable<Person>> call([NoParams? params]) async {
    // Get all notifications which need to show by RemindNotification
    final notificationsForToday = (await personRepository.getPersons())
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
