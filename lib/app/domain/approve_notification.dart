import 'package:birthday_gift/app/data/repository/shown_notification_repository.dart';
import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/model/shown_notification.dart';
import 'package:birthday_gift/core/use_case.dart';

class ApproveNotification implements UseCase<void, int> {

  final ShownNotificationRepository shownNotificationRepository;

  ApproveNotification(this.shownNotificationRepository);

  @override
  Future<void> call(int notificationId) async {
    await shownNotificationRepository.addNotification(ShownNotification(notificationId, Date()));
  }
}
