import 'package:birthday_gift/utils/base/base_cubit.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:flutter/material.dart';

import 'notification_approve_interface.dart';

class NotificationApproveCubit extends BaseCubit<NotificationApproveState> implements ErrorHandler {

  final OnApproveNotification _onApproveNotification;
  final _notificationErrorHandler = NotificationApproveErrorHandler();

  NotificationApproveCubit(
    this._onApproveNotification,
  ) : super(NotificationApproveState());

  @override
  BlocError getErrorTemplate(Exception exception) {
    return BlocError(exception, _notificationErrorHandler);
  }

  @override
  String getErrorMessage(BuildContext context, Exception exception) {
    return _notificationErrorHandler.getErrorMessage(context, exception);
  }

  void approve(NotificationModel notification) {
    launch(() async {
      await _onApproveNotification.approve(notification.id);
    }, null);
  }
}

class NotificationApproveState extends BlocState {}

class NotificationApproveErrorHandler extends ErrorHandler {
  /*NOP*/
}
