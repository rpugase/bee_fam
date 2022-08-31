import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/feature/notification/domain/notification_error_handler.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'notification_manage_interface.dart';

class NotificationManagerCubit extends BaseCubit<NotificationManageState> {
  final OnCreateOrUpdateNotification _onCreateOrUpdateNotification;
  final OnDeleteNotification _onDeleteNotification;

  NotificationManagerCubit(this._onCreateOrUpdateNotification, this._onDeleteNotification) : super(ApplyData());

  @override
  BlocError getErrorTemplate(Exception exception) {
    return NotificationError(exception, NotificationErrorHandler());
  }

  void createOrUpdateNotification(NotificationModel notification) {
    launch(() async {
      emit(ApplyData());
      await _onCreateOrUpdateNotification.createOrUpdateNotification(notification);
      emit(Finish());
    }, null);
  }

  void deleteNotification(NotificationModel notificationModel) {
    launch(() async {
      emit(ApplyData());
      await _onDeleteNotification.deleteNotification(notificationModel);
      emit(Finish());
    }, null);
  }

  void callNumber(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    } else {
      Log.e('Could not launch $url');
      addError(Exception("No find "));
    }
  }
}

abstract class NotificationManageState extends BlocState {}

class ApplyData extends NotificationManageState {}

class NoApplyData extends NotificationManageState {}

class NotificationError extends BlocError {
  const NotificationError(Exception exception, ErrorHandler errorHandler) : super(exception, errorHandler);
}

class Finish extends NotificationManageState {}
