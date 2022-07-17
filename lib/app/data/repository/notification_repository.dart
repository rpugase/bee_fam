import 'dart:async';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/utils/cache/dao/person_dao.dart';

class NotificationRepository {
  final PersonDao _db;

  final _onUpdateNotificationsList = StreamController<Iterable<NotificationModel>>.broadcast();

  NotificationRepository(this._db);

  Stream<Iterable<NotificationModel>> listenNotifications() async* {
    yield await getNotifications();
    yield* _onUpdateNotificationsList.stream;
  }

  Future<Iterable<NotificationModel>> getNotifications() async {
    return (await _db.getPersons())
        .entries
        .map((person) => NotificationModel.fromEntity(person.value, person.key));
  }

  Future<NotificationModel?> getNotification(int notificationId) async {
    final personEntity = (await _db.getPersons())[notificationId];
    return personEntity != null ? NotificationModel.fromEntity(personEntity, notificationId) : null;
  }

  Future<void> createNotification(NotificationModel notification) async {
    await _db.addPerson(notification.toEntity());
    _onUpdateNotificationsList.add(await getNotifications());
  }

  Future<void> updateNotification(NotificationModel notification) async {
    await _db.updatePerson(notification.id, notification.toEntity());
    _onUpdateNotificationsList.add(await getNotifications());
  }
}
