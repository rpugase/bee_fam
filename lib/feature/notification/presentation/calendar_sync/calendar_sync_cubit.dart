import 'dart:async';

import 'package:birthday_gift/app/data/repository/notification_repository.dart';
import 'package:birthday_gift/core/data_source/remote_source/calendar_remote_data_source.dart';
import 'package:birthday_gift/core/ui/list/notification_list_item.dart';
import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/util/internet_connection_check.dart';
import 'package:birthday_gift/feature/notification/presentation/manage/notification_manage_interface.dart';
import 'package:birthday_gift/utils/base/base_cubit.dart';
import 'package:flutter/widgets.dart';


class CalendarSyncCubit extends BaseCubit<CalendarSyncState> {

  final NotificationRepository _notificationRepository;
  final CalendarRemoteDataSource _calendarRemoteDataSource;
  final OnSyncNotificationList _syncNotifications;

  CalendarSyncCubit(
      this._calendarRemoteDataSource,
      this._notificationRepository,
      this._syncNotifications) : super(ClearCalendarSyncState()) {
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
    final resultList = (state as EventsCalendarSyncState).notificationListItem.map((listItem) {
      if (listItem.notification.remoteId == notificationListItem.notification.remoteId
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

  void syncEvents() {
    final notifications = (state as EventsCalendarSyncState).notificationListItem
        .where((listItem) => listItem.isChosen)
        .map((e) => e.notification);
    unawaited(_syncNotifications.syncRemoteNotifications(notifications)
        .then((value) => emit(FinishCalendarSyncState()))
    );
  }
}

class CalendarSyncState extends BlocState {}

class ClearCalendarSyncState extends CalendarSyncState {}

class FinishCalendarSyncState extends CalendarSyncState {}

class EventsCalendarSyncState extends CalendarSyncState {

  final List<NotificationListItem> notificationListItem;

  EventsCalendarSyncState(this.notificationListItem);
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
