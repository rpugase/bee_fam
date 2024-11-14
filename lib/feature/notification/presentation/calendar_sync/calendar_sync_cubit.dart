import 'dart:async';

import 'package:birthday_gift/app/data/repository/notification_repository.dart';
import 'package:birthday_gift/core/data_source/remote_source/calendar_remote_data_source.dart';
import 'package:birthday_gift/core/ui/list/notification_list_item.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/util/internet_connection_check.dart';
import 'package:birthday_gift/feature/notification/presentation/manage/notification_manage_interface.dart';
import 'package:birthday_gift/utils/base/base_cubit.dart';
import 'package:birthday_gift/utils/base/list_item.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';


class CalendarSyncCubit extends BaseCubit<CalendarSyncState> {

  final NotificationRepository _notificationRepository;
  final CalendarRemoteDataSource _calendarRemoteDataSource;
  final OnSyncNotificationList _syncNotifications;

  CalendarSyncCubit(
      this._calendarRemoteDataSource,
      this._notificationRepository,
      this._syncNotifications) : super(LoadingCalendarSyncState()) {
    unawaited(_init());
  }

  Future<void> _init() async {
    final notificationListItems = await _calendarRemoteDataSource.getCalendarEvents();

    emit(EventsCalendarSyncState(
        notificationListItems.toListItems(
            await _notificationRepository.getNotifications(),
        ).toList(growable: false),
    ));
  }

  void onNotificationTap(NotificationListItem notificationListItem) {
    final resultList = (state as EventsCalendarSyncState).listItem.map((listItem) {
      if (listItem is NotificationListItem && listItem.notification.googleRemoteId == notificationListItem.notification.googleRemoteId
          && notificationListItem.name == notificationListItem.name) {
        return listItem.copyWith(
          isChosen: !listItem.isChosen,
        );
      }
      return listItem;
    }).toList(growable: false);

    emit(EventsCalendarSyncState(resultList));
  }

  @override
  BlocError getErrorTemplate(Exception exception) {
    return CalendarSyncError(exception, CalendarSyncErrorHandler());
  }

  void onTapDone() {
    final notificationsListItems = (state as EventsCalendarSyncState).listItem
        .whereType<NotificationListItem>();
    final notifications = notificationsListItems
        .where((listItem) => listItem.isChosen)
        .map((e) => e.notification);
    final allRemoteIds = notificationsListItems.map((e) => e.notification.googleRemoteId)
        .whereNotNull().toSet();
    unawaited(_syncNotifications.syncFromRemoteNotifications(notifications, allRemoteIds)
        .then((value) => emit(FinishCalendarSyncState())));
  }
}

class CalendarSyncState extends BlocState {}

class LoadingCalendarSyncState extends CalendarSyncState {}

class FinishCalendarSyncState extends CalendarSyncState {}

class EventsCalendarSyncState extends CalendarSyncState {

  final List<ListItem> listItem;

  EventsCalendarSyncState(this.listItem);
}


class CalendarSyncErrorHandler extends ErrorHandler {
  @override
  String getErrorMessage(BuildContext context, Exception exception) {
    if (exception is InternetConnectionException) {
      return context.strings.error_no_internet;
    } else {
      return super.getErrorMessage(context, exception);
    }
  }
}

class CalendarSyncError extends BlocError {
  const CalendarSyncError(Exception exception, ErrorHandler errorHandler) : super(exception, errorHandler);
}
