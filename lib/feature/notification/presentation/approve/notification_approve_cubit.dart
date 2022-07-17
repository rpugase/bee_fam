import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/app/domain/approve_notification.dart';
import 'package:flutter/material.dart';

class NotificationApproveCubit extends BaseCubit<NotificationApproveState> implements ErrorHandler {
  final _notificationErrorHandler = NotificationApproveErrorHandler();
  final ApproveNotification _approveNotification;

  NotificationApproveCubit(
    this._approveNotification,
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
      await _approveNotification(notification.id);
    }, null);
  }
}

class NotificationApproveState extends BlocState {}

class NotificationApproveErrorHandler extends ErrorHandler {
  /*NOP*/
}
