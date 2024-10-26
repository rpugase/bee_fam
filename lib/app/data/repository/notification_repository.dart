import 'dart:async';

import 'package:birthday_gift/core/data_source/local_source/dao/notification_dao.dart';
import 'package:birthday_gift/core/data_source/remote_source/calendar_remote_data_source.dart';
import 'package:birthday_gift/core/data_source/remote_source/model/calenar_remote_event.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/core/model/remind_notification.dart';
import 'package:birthday_gift/core/ui/list/notification_list_item.dart';
import 'package:birthday_gift/feature/notification/presentation/manage/notification_manage_interface.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:collection/collection.dart';

class NotificationRepository implements OnSyncNotificationList {
  final NotificationDao _db;
  final CalendarRemoteDataSource _calendarSource;

  final _onUpdateNotificationsList = StreamController<Iterable<NotificationModel>>.broadcast();

  NotificationRepository(this._db, this._calendarSource);

  Stream<Iterable<NotificationModel>> listenNotifications() async* {
    yield await getNotifications();
    yield* _onUpdateNotificationsList.stream;
  }

  Future<Iterable<NotificationModel>> getNotifications() async {
    return (await _db.getNotifications())
        .entries
        .map((person) => NotificationModel.fromEntity(person.value, person.key));
  }

  Future<NotificationModel?> getNotification(int notificationId) async {
    final personEntity = (await _db.getNotifications())[notificationId];
    return personEntity != null ? NotificationModel.fromEntity(personEntity, notificationId) : null;
  }

  Future<void> createNotification(NotificationModel notification) async {
    Log.i("Add notification=$notification");
    await _db.addNotification(notification.toEntity());
    _onUpdateNotificationsList.add(await getNotifications());
  }

  Future<void> updateNotification(NotificationModel notification) async {
    Log.i("Update notification=$notification");
    await _db.updateNotification(notification.id, notification.toEntity());
    _onUpdateNotificationsList.add(await getNotifications());
  }

  Future<void> deleteNotification(NotificationModel notification) async {
    Log.i("Delete notificationEntity=$notification");
    await _db.deleteNotification(notification.id);
    _onUpdateNotificationsList.add(await getNotifications());
  }

  @override
  Future<void> syncRemoteNotifications(Iterable<NotificationModel> notifications) async {
    if (notifications.isNotEmpty) {
      final dbNotifications = await getNotifications();
      final dbNotificationsRemoteIds = dbNotifications.map((e) => e.remoteId).whereNotNull().toSet();
      final notificationsRemoteIds = notifications.map((e) => e.remoteId).whereNotNull().toSet();
      final remoteNotification = notifications.toList();

      // check for duplicates
      remoteNotification.removeWhere((notification) => dbNotificationsRemoteIds.contains(notification.remoteId));

      // check for remove
      final notificationsForRemoveRemoteIds = dbNotificationsRemoteIds.whereNot((remoteId) => notificationsRemoteIds.contains(remoteId));
      final notificationsForRemoveIds = dbNotifications
          .where((element) => notificationsForRemoveRemoteIds.contains(element.remoteId))
          .map((e) => e.id);
      Log.i("notificationsForRemoveIds=$notificationsForRemoveIds");

      bool isNeedToUpdateNotificationsList = false;
      // add to db
      if (remoteNotification.isNotEmpty) {
        _db.addNotifications(remoteNotification.map((e) => e.toEntity()));
        isNeedToUpdateNotificationsList = true;
      }

      // remove from db
      if (notificationsForRemoveIds.isNotEmpty) {
        _db.deleteNotifications(notificationsForRemoveIds);
        isNeedToUpdateNotificationsList = true;
      }

      if (isNeedToUpdateNotificationsList) {
        _onUpdateNotificationsList.add(await getNotifications());
      }
    }
  }

  Future<List<NotificationListItem>> getNotificationsFromCalendar() async { // TODO IN-9 return NotificationModel
    final calendarEvents = await _calendarSource.getCalendarEvents();
    final remoteEventsIds = (await getNotifications())
        .map((e) => e.remoteId)
        .whereNotNull()
        .toSet();

    final List<NotificationListItem> notificationListItems = List.empty(growable: true);
    calendarEvents.toList().asMap().forEach((index, event) => notificationListItems.add(
        NotificationListItem(
          notification: NotificationModel(
            remoteId: event.googleEventId,
            name: event.title,
            birthday: event.birthdayDate,
            remindNotifications: [RemindNotification.inBirthday()],
          ),
          firstInMonthBlock: index == 0,
          lastInMonthBlock: index == calendarEvents.length - 1,
          isChooseMode: true,
          isChosen: remoteEventsIds.contains(event.googleEventId),
        )
    ));

    return notificationListItems;
  }

}

extension CalendarEventToNotificationListItemMapper on Iterable<CalendarBirthdayEvent> {
  Iterable<NotificationListItem> toListItems(Iterable<NotificationModel> allNotifications) {
    final calendarEvents = this;
    final remoteEventsIds = (allNotifications)
        .map((e) => e.remoteId)
        .whereNotNull()
        .toSet();
    final List<NotificationListItem> notificationListItems = List.empty(growable: true);
    calendarEvents.toList().asMap().forEach((index, event) => notificationListItems.add(
        NotificationListItem(
          notification: NotificationModel(
            remoteId: event.googleEventId,
            name: event.title,
            birthday: event.birthdayDate,
            remindNotifications: [RemindNotification.inBirthday()],
          ),
          firstInMonthBlock: index == 0,
          lastInMonthBlock: index == calendarEvents.length - 1,
          isChooseMode: true,
          isChosen: remoteEventsIds.contains(event.googleEventId),
        )
    ));

    return notificationListItems;
  }
}