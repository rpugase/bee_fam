import 'package:birthday_gift/core/model/date.dart';
import 'package:birthday_gift/core/use_case.dart';
import 'package:birthday_gift/utils/cache/dao/shown_notification_dao.dart';
import 'package:birthday_gift/utils/cache/entity/shown_notification_entity.dart';

class ApproveNotification implements UseCase<void, int> {

  final ShownNotificationDao shownNotificationDao;

  ApproveNotification(this.shownNotificationDao);

  @override
  Future<void> call(int personId) async {
    shownNotificationDao.addShownNotification(ShownNotificationEntity(personId, Date().toIso8601String()));
  }
}
