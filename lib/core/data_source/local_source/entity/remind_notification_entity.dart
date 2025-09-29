class RemindNotificationEntity {

  final int offsetDaysFromBirthday;
  final int offsetMonthFromBirthday;

  RemindNotificationEntity(this.offsetDaysFromBirthday, this.offsetMonthFromBirthday);

  @override
  String toString() {
    return "RemindNotificationEntity(offsetDaysFromBirthday=$offsetDaysFromBirthday, "
        "offsetMonthFromBirthday=$offsetMonthFromBirthday)";
  }
}
