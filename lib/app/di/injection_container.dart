import 'package:birthday_gift/app/data/repository/shown_notification_repository.dart';
import 'package:birthday_gift/app/domain/get_notifications_for_showing.dart';
import 'package:birthday_gift/core/cubit/version/get_current_user_cubit.dart';
import 'package:birthday_gift/core/cubit/version/get_version_with_update_cubit.dart';
import 'package:birthday_gift/app/domain/approve_notification.dart';
import 'package:birthday_gift/app/domain/delete_notification.dart';
import 'package:birthday_gift/feature/notification/presentation/approve/notification_approve_interface.dart';
import 'package:birthday_gift/feature/notification/presentation/list/notification_list_interface.dart';
import 'package:birthday_gift/feature/notification/presentation/manage/notification_manage_interface.dart';
import 'package:birthday_gift/feature/user/data/firebase_auth_datastore.dart';
import 'package:birthday_gift/feature/user/domain/auth_with_phone_number.dart';
import 'package:birthday_gift/feature/user/domain/confirm_phone_number_code.dart';
import 'package:birthday_gift/app/domain/get_current_user.dart';
import 'package:birthday_gift/feature/user/domain/user_error_handler.dart';
import 'package:birthday_gift/feature/user/presentation/auth_cubit.dart';
import 'package:birthday_gift/core/data_source/local_source/dao/settings_dao.dart';
import 'package:birthday_gift/core/data_source/local_source/dao/shown_notification_dao.dart';
import 'package:birthday_gift/core/data_source/local_source/dao/user_dao.dart';
import 'package:birthday_gift/core/data_source/local_source/dao/notification_dao.dart';
import 'package:birthday_gift/core/data_source/local_source/entity/note_entity.dart';
import 'package:birthday_gift/core/data_source/local_source/entity/notification_entity.dart';
import 'package:birthday_gift/core/data_source/local_source/entity/remind_notification_entity.dart';
import 'package:birthday_gift/core/data_source/local_source/entity/shown_notification_entity.dart';
import 'package:birthday_gift/core/data_source/local_source/entity/user_entity.dart';
import 'package:birthday_gift/app/domain/create_or_update_product.dart';
import 'package:birthday_gift/app/domain/listen_notifications.dart';
import 'package:birthday_gift/feature/notification/presentation/list/notification_list_cubit.dart';
import 'package:birthday_gift/feature/notification/presentation/manage/notification_manage_cubit.dart';
import 'package:birthday_gift/app/data/datasource/notification_datasource.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:birthday_gift/feature/notification/presentation/approve/notification_approve_cubit.dart';

import '../data/datasource/worker_datasource.dart';
import '../data/repository/notification_repository.dart';
import '../domain/show_today_notification.dart';

final sl = GetIt.instance;

Future<void> init(
  SharedPreferences sharedPreferences,
) async {

  // Datasource
  sl.registerSingleton(await SharedPreferences.getInstance());
  await _initDao();
  await _initWorker();
  await _initNotificationService();

  // Repository
  sl.registerLazySingleton(() => NotificationRepository(sl()));
  sl.registerLazySingleton(() => ShownNotificationRepository(sl()));

  // UseCase
  sl.registerFactory<OnCreateOrUpdateNotification>(() => CreateOrUpdateNotification(sl()));
  sl.registerFactory<OnDeleteNotification>(() => DeleteNotification(sl()));
  sl.registerFactory<OnListenNotifications>(() => ListenNotifications(sl()));
  sl.registerFactory<OnApproveNotification>(() => ApproveNotification(sl()));
  sl.registerFactory(() => GetTodayNotification(sl(), sl(), sl()));
  sl.registerFactory(() => GetNotificationsForShowing(sl(), sl()));
  sl.registerFactory<OnGetCurrentUser>(() => GetCurrentUser(sl()));

  // Service Cubit
  sl.registerFactory(() => GetVersionWithUpdateCubit(sl()));
  sl.registerFactory(() => NotificationListCubit(sl()));
  sl.registerFactory(() => NotificationManagerCubit(sl(), sl()));
  sl.registerFactory(() => NotificationApproveCubit(sl()));
  sl.registerFactory(() => CurrentUserCubit(sl()));

  await _initUser();
}

Future<void> _initNotificationService() async {
  final notificationDatasource = NotificationDataSource();
  await notificationDatasource.requestPermission();
  await notificationDatasource.init();
  sl.registerSingleton(notificationDatasource);
}

Future<void> _initWorker() async {
  final WorkerDatasource workerDatasource = WorkerDatasource();
  await workerDatasource.init();
  sl.registerSingleton(workerDatasource);
}

Future<void> _initDao() async {
  sl.registerSingleton<Box<UserEntity>>(await UserEntity.createBox());
  sl.registerSingleton<Box<NotificationEntity>>(await NotificationEntity.createBox());
  sl.registerSingleton<Box<NoteEntity>>(await NoteEntity.createBox());
  sl.registerSingleton<Box<RemindNotificationEntity>>(await RemindNotificationEntity.createBox());
  sl.registerSingleton<Box<ShownNotificationEntity>>(await ShownNotificationEntity.createBox());

  sl.registerLazySingleton(() => NotificationDao(sl()));
  sl.registerLazySingleton(() => UserDao(sl()));
  sl.registerLazySingleton(() => SettingsDao(sl()));
  sl.registerLazySingleton(() => ShownNotificationDao(sl()));
}

Future<void> _initUser() async {
  bool isPhysicalDevice = (await DeviceInfoPlugin().deviceInfo).toMap()['isPhysicalDevice'] != "false";

  sl.registerSingleton(FirebaseAuth.instance);
  sl.registerSingleton<FirebaseAuthDatastore>(
      isPhysicalDevice ? FirebaseAuthDatastoreImpl(sl()) : FirebaseAuthDatastoreMock());

  sl.registerFactory(() => UserErrorHandler());

  sl.registerFactory(() => AuthWithPhoneNumber(sl()));
  sl.registerFactory(() => ConfirmPhoneNumberCode(sl(), sl()));
  sl.registerFactory(() => AuthCubit(sl(), sl(), sl()));
}
