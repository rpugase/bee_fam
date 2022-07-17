import 'package:birthday_gift/app/data/repository/person_repository.dart';
import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/model/person.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:birthday_gift/app/domain/approve_notification.dart';

class NotificationApproveCubit extends BaseCubit<NotificationApproveState> implements ErrorHandler {
  final _notificationErrorHandler = NotificationApproveErrorHandler();
  final ApproveNotification approveNotification;
  final PersonRepository personRepository;

  NotificationApproveCubit(
    this.approveNotification,
    this.personRepository,
  ) : super(NotificationApproveState());

  @override
  BlocError getErrorTemplate(Exception exception) {
    return BlocError(exception, _notificationErrorHandler);
  }

  @override
  String getErrorMessage(BuildContext context, Exception exception) {
    return _notificationErrorHandler.getErrorMessage(context, exception);
  }

  void approve(Person person) {
    launch(() async {
      await approveNotification(person.id);
    }, null);
  }
}

class NotificationApproveState extends BlocState {}

class NotificationApproveErrorHandler extends ErrorHandler {
  /*NOP*/
}
