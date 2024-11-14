import 'package:birthday_gift/app/data/repository/shown_notification_repository.dart';
import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/shown_notification.dart';
import 'package:birthday_gift/feature/notification/presentation/approve/notification_approve_interface.dart';

class ApproveNotification implements OnApproveNotification {

  final ShownNotificationRepository _shownNotificationRepository;

  const ApproveNotification(this._shownNotificationRepository);

  @override
  Future<void> approve(int notificationId) async {
    await _shownNotificationRepository.addNotification(ShownNotification(notificationId, Date()));
  }
}
