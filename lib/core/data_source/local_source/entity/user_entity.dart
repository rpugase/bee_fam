class UserEntity {

  final String phone;
  final List<String> notificationsIds;
  final int createdDate;
  final int updatedDate;
  final int lastSyncDate;

  UserEntity(
    this.phone,
    this.notificationsIds,
    this.createdDate,
    this.updatedDate,
    this.lastSyncDate,
  );
}
