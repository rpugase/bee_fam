import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/feature/notification/domain/notification_error_handler.dart';
import 'package:equatable/equatable.dart';

import 'notification_list_interface.dart';


class NotificationListCubit extends BaseCubit<NotificationsListState> {
  final OnListenNotifications _onListenNotifications;

  NotificationListCubit(this._onListenNotifications) : super(Loading());

  @override
  void onInit() {
    collect<Iterable<NotificationModel>>(_onListenNotifications.listen(), _onNotificationsLoaded, null);
  }

  @override
  BlocError getErrorTemplate(Exception exception) {
    return NotificationError(exception, NotificationErrorHandler());
  }

  Future _onNotificationsLoaded(Iterable<NotificationModel> notifications) async {
    emit(notifications.isEmpty ? EmptyList() : NotificationsList(notifications));
  }
}

abstract class NotificationsListState extends BlocState {}

class Loading extends NotificationsListState {}

class EmptyList extends NotificationsListState {}

class NotificationsList extends NotificationsListState implements Equatable {
  final Iterable<NotificationModel> notifications;

  NotificationsList(this.notifications);

  @override
  List<Object?> get props => [notifications.hashCode];

  @override
  bool? get stringify => true;
}

class NotificationError extends BlocError {
  const NotificationError(Exception exception, ErrorHandler errorHandler) : super(exception, errorHandler);
}
