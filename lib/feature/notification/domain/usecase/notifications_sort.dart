import 'package:birthday_gift/core/model/notification_model.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:collection/collection.dart';

class NotificationsSort implements UseCase<Iterable<NotificationModel>, Iterable<NotificationModel>> {
  static const int monthsInYear = 12;

  @override
  Future<Iterable<NotificationModel>> call(Iterable<NotificationModel> notificationsList) {
    final currentMonth = DateTime.now().month;
    return Future.value(notificationsList.sortedByCompare<int>((notification) => notification.birthday.dateTime.month, (a, b) {
      final aM = a < currentMonth ? a + monthsInYear : a;
      final bM = b < currentMonth ? b + monthsInYear : b;
      return aM - bM;
    }));
  }
}
