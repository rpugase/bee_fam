import 'package:birthday_gift/app/data/repository/notification_repository.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/feature/notification/presentation/manage/notification_manage_interface.dart';
import 'package:birthday_gift/utils/logger/logger.dart';

class DeleteNotification implements OnDeleteNotification {
  final NotificationRepository _notificationRepository;

  const DeleteNotification(this._notificationRepository);

  @override
  Future<void> deleteNotification(NotificationModel notification) async {
    Log.i("Start deleting notification: $notification");
    await _notificationRepository.deleteNotification(notification);
  }
}
