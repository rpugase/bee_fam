import 'package:birthday_gift/utils/cache/entity/shown_notification_entity.dart';
import 'package:equatable/equatable.dart';

import 'date.dart';

class ShownNotification extends Equatable {
  final int notificationId;
  final Date notificationDate;

  ShownNotification(this.notificationId, this.notificationDate);

  factory ShownNotification.fromEntity(ShownNotificationEntity shownNotificationEntity) {
    return ShownNotification(
      shownNotificationEntity.notificationId,
      Date.remote(shownNotificationEntity.shownDate),
    );
  }

  ShownNotificationEntity toEntity() => ShownNotificationEntity(
    notificationId, notificationDate.toIso8601String()
  );

  @override
  List<Object?> get props => [notificationId, notificationDate];
}
