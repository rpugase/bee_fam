import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:collection/collection.dart';

class NotificationsSort extends Iterable<NotificationModel> {
  static const int monthsInYear = 12;

  final Iterable<NotificationModel> notificationsList;

  const NotificationsSort(this.notificationsList);

  @override
  Iterator<NotificationModel> get iterator {
    final currentMonth = DateTime.now().month;
    return notificationsList.sortedByCompare<int>((notification) => notification.birthday.dateTime.month, (a, b) {
      final aM = a < currentMonth ? a + monthsInYear : a;
      final bM = b < currentMonth ? b + monthsInYear : b;
      return aM - bM;
    }).iterator;
  }
}
