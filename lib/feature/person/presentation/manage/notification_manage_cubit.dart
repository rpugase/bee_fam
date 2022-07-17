import 'package:birthday_gift/core/base_cubit.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/feature/person/domain/notification_error_handler.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import '../../domain/usecase/create_or_update_product.dart';

class NotificationManagerCubit extends BaseCubit<NotificationManageState> {
  final CreateOrUpdateNotification _createOrUpdateNotification;

  NotificationManagerCubit(this._createOrUpdateNotification) : super(ApplyData());

  @override
  BlocError getErrorTemplate(Exception exception) {
    return NotificationError(exception, NotificationErrorHandler());
  }

  void createOrUpdateNotification(NotificationModel notification) {
    launch(() async {
      emit(ApplyData());
      await _createOrUpdateNotification(notification);
      emit(Finish());
    }, null);
  }

  void callNumber(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await urlLauncher.canLaunch(url)) {
      await urlLauncher.launch(url);
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
  NotificationError(Exception exception, ErrorHandler errorHandler) : super(exception, errorHandler);
}

class Finish extends NotificationManageState {}
