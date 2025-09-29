class ShownNotificationEntity {

  final int notificationId;
  final String shownDate;


  ShownNotificationEntity(
    this.notificationId,
    this.shownDate,
  );

  @override
  String toString() {
    return "ShownNotificationEntity(notificationId=$notificationId, shownDate=$shownDate)";
  }
}
