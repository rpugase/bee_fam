import 'dart:async';

import 'package:birthday_gift/core/data_source/local_source/dao/notification_dao.dart';
import 'package:birthday_gift/core/data_source/remote_source/google_remote_data_source.dart';
import 'package:birthday_gift/core/data_source/remote_source/model/calenar_remote_event.dart';
import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/core/model/remind_notification.dart';
import 'package:birthday_gift/core/ui/list/month_list_item.dart';
import 'package:birthday_gift/core/ui/list/notification_list_item.dart';
import 'package:birthday_gift/feature/notification/presentation/manage/notification_manage_interface.dart';
import 'package:birthday_gift/utils/base/list_item.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:collection/collection.dart';
import 'package:synchronized/synchronized.dart';

class NotificationRepository implements OnSyncNotificationList {
  final NotificationDao _db;
  final GoogleRemoteDataSource _googleSource;

  final Lock syncToRemoteLock = Lock();

  final _onUpdateNotificationsList = StreamController<Iterable<NotificationModel>>.broadcast();

  NotificationRepository(this._db, this._googleSource);

  Stream<Iterable<NotificationModel>> listenNotifications() async* {
    yield await getNotifications();
    yield* _onUpdateNotificationsList.stream;
  }

  Future<Iterable<NotificationModel>> getNotifications() async {
    return (await _db.getNotifications())
        .entries
        .where((notification) => !notification.value.isDeleted)
        .map((notification) => NotificationModel.fromEntity(notification.value, notification.key));
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
    await _db.updateNotification(notification.id, notification.toEntity().copyWith(isDeleted: true));
    _onUpdateNotificationsList.add(await getNotifications());
    unawaited(syncToRemote());
  }

  Future<void> syncToRemote() async {
    await syncToRemoteLock.synchronized(() async {
      Log.i("Start initialize sync to remote source");
      final dbNotifications = await _db.getNotifications();
      final notificationsToSend = dbNotifications
          .entries
          .where((notification) => notification.value.googleRemoteId == null);

      final notificationToDelete = dbNotifications
          .entries
          .where((notification) => notification.value.isDeleted);

      Log.i("${notificationsToSend.length} found to create");
      Log.i("${notificationToDelete.length} found to delete");

      for (final notificationEntry in notificationsToSend) {
        final notificationId = notificationEntry.key;
        final notification = notificationEntry.value;
        Log.i("Start sync event creation \"${notification.name}\"");
        final result = await _googleSource.createCalendarEvent(
          notification.name,
          Date.birthdayString(notification.birthday),
        );
        if (result.isSuccess) {
          final googleId = result.success;
          _db.updateNotification(notificationId, notification.copyWith(googleRemoteId: googleId));
          _onUpdateNotificationsList.add(await getNotifications());
          Log.i("Event ${notification.name} created with googleId=$googleId");
        } else {
          Log.w("Sync failed");
          Log.e(result.failure);
        }
      }

      for (final notificationEntry in notificationToDelete) {
        final notificationId = notificationEntry.key;
        final notification = notificationEntry.value;
        final googleRemoteId = notification.googleRemoteId;

        Log.i("Start sync event deletion ${notification.name}");

        final isDeleted = (googleRemoteId != null) ? await _googleSource.deleteNotification(googleRemoteId) : true;

        if (isDeleted) {
          Log.i("Event successfully deleted");
          await _db.deleteNotification(notificationId);
        } else {
          Log.i("Event wasn't deleted");
        }
      }
    });
  }

  @override
  Future<void> syncFromRemoteNotifications(
      Iterable<NotificationModel> notifications,
      Set<String> allRemoteIds,
  ) async {
    final dbNotifications = await getNotifications();
    final notificationsRemoteIds = notifications
        .map((e) => e.googleRemoteId)
        .whereNotNull()
        .toSet();
    final dbNotificationsRemoteIds = dbNotifications
        .map((dbNotification) => dbNotification.googleRemoteId)
        .whereNotNull()
        .where((dbRemoteId) => allRemoteIds.contains(dbRemoteId))
        .toSet();
    final remoteNotification = notifications.toList();

    // check for duplicates
    remoteNotification.removeWhere((notification) => dbNotificationsRemoteIds.contains(notification.googleRemoteId));

    // check for remove
    final idToSkip = dbNotificationsRemoteIds.whereNot((remoteId) => notificationsRemoteIds.contains(remoteId));
    final notificationsForRemoveRemoteIds = dbNotificationsRemoteIds.whereNot((remoteId) => notificationsRemoteIds.contains(remoteId));
    final notificationsForRemoveIds = dbNotifications
        .where((element) => notificationsForRemoveRemoteIds.contains(element.googleRemoteId))
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

extension CalendarEventToNotificationListItemMapper on Iterable<CalendarBirthdayEvent> {
  Iterable<ListItem> toListItems(Iterable<NotificationModel> allLocalNotifications) {
    final calendarEvents = this;

    final List<ListItem> notificationListItems = List.empty(growable: true);

    final birthdayEvents = calendarEvents.where((event) => event.isCompletelyBirthdayEvent);
    final otherEvents = calendarEvents.where((event) => !event.isCompletelyBirthdayEvent);
    final hasAllTypeOfEvents = birthdayEvents.isNotEmpty && otherEvents.isNotEmpty;

    if (hasAllTypeOfEvents) notificationListItems.add(MonthListItem("Birthday")); // TODO IN-9 From translation
    notificationListItems.addAll(birthdayEvents._toListItemsInternal(allLocalNotifications));

    if (hasAllTypeOfEvents) notificationListItems.add(MonthListItem("Other")); // TODO IN-9 From translation
    notificationListItems.addAll(otherEvents._toListItemsInternal(allLocalNotifications));

    return notificationListItems;
  }

  Iterable<NotificationListItem> _toListItemsInternal(Iterable<NotificationModel> allLocalNotifications) {
    final calendarEvents = this;
    final remoteEventsIds = allLocalNotifications
        .map((e) => e.googleRemoteId)
        .whereNotNull()
        .toSet();

    final List<NotificationListItem> notificationListItems = List.empty(growable: true);
    calendarEvents.toList().asMap().forEach((index, event) => notificationListItems.add(
        NotificationListItem(
          notification: NotificationModel(
            googleRemoteId: event.googleEventId,
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
