import 'package:birthday_gift/app/data/repository/notification_repository.dart';
import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:birthday_gift/feature/notification/presentation/manage/notification_manage_interface.dart';
import 'package:birthday_gift/utils/logger/logger.dart';

import '../../feature/notification/domain/exception/require_person_field_exception.dart';

class CreateOrUpdateNotification implements OnCreateOrUpdateNotification {
  final NotificationRepository _notificationRepository;

  const CreateOrUpdateNotification(this._notificationRepository);

  @override
  Future<void> createOrUpdateNotification(NotificationModel notification) async {
    Log.i("Start manage or update notification: $notification");
    final requireFields = <NotificationRequireFields>[];
    if (notification.name.isEmpty) requireFields.add(NotificationRequireFields.name);
    if (!notification.birthday.isValid || notification.birthday == Date.defaultBirthday()) {
      requireFields.add(NotificationRequireFields.birthday);
    }
    if (requireFields.isNotEmpty) {
      throw RequireNotificationFiledException(requireFields);
    }

    if (notification.id == NotificationModel.invalidId) {
      Log.i("Create notification: $notification");
      await _notificationRepository.createNotification(notification);
    } else {
      Log.i("Update notification: $notification");
      await _notificationRepository.updateNotification(notification);
    }
  }
}
