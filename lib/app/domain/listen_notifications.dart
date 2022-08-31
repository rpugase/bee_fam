import 'package:birthday_gift/app/data/repository/notification_repository.dart';
import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:birthday_gift/feature/notification/presentation/list/notification_list_interface.dart';
import 'package:birthday_gift/utils/logger/logger.dart';

import 'notifications_sort.dart';

class ListenNotifications implements OnListenNotifications {
  final NotificationRepository _notificationRepository;
  final NotificationsSort _notificationsSort;

  const ListenNotifications(this._notificationRepository, this._notificationsSort);

  @override
  Stream<Iterable<NotificationModel>> listen() {
    return _notificationRepository.listenNotifications().asyncMap((notificationsList) async {
      final notificationsResult = await _notificationsSort(notificationsList);
      Log.i("Notifications: $notificationsResult");
      return notificationsResult;
    });
  }
}
