import 'package:birthday_gift/core/data_source/local_source/entity/shown_notification_entity.dart';
import 'package:equatable/equatable.dart';

import 'date.dart';

class ShownNotification extends Equatable {
  final int notificationId;
  final Date shownDate;

  const ShownNotification(this.notificationId, this.shownDate);

  factory ShownNotification.fromEntity(ShownNotificationEntity shownNotificationEntity) {
    return ShownNotification(
      shownNotificationEntity.notificationId,
      Date.remote(shownNotificationEntity.shownDate),
    );
  }

  ShownNotificationEntity toEntity() => ShownNotificationEntity(
    notificationId, shownDate.toIso8601String()
  );

  @override
  List<Object?> get props => [notificationId, shownDate];
}
