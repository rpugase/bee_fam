import 'package:birthday_gift/core/cubit/version/get_current_user_cubit.dart';
import 'package:birthday_gift/core/cubit/version/get_version_with_update_cubit.dart';
import 'package:birthday_gift/feature/person/domain/usecase/approve_notification.dart';
import 'package:birthday_gift/feature/user/data/firebase_auth_datastore.dart';
import 'package:birthday_gift/feature/user/domain/auth_with_phone_number.dart';
import 'package:birthday_gift/feature/user/domain/confirm_phone_number_code.dart';
import 'package:birthday_gift/feature/user/domain/get_current_user.dart';
import 'package:birthday_gift/feature/user/domain/user_error_handler.dart';
import 'package:birthday_gift/feature/user/presentation/auth_cubit.dart';
import 'package:birthday_gift/utils/cache/dao/settings_dao.dart';
import 'package:birthday_gift/utils/cache/dao/shown_notification_dao.dart';
import 'package:birthday_gift/utils/cache/dao/user_dao.dart';
import 'package:birthday_gift/utils/cache/dao/person_dao.dart';
import 'package:birthday_gift/utils/cache/entity/note_entity.dart';
import 'package:birthday_gift/utils/cache/entity/person_entity.dart';
import 'package:birthday_gift/utils/cache/entity/remind_notification_entity.dart';
import 'package:birthday_gift/utils/cache/entity/shown_notification_entity.dart';
import 'package:birthday_gift/utils/cache/entity/user_entity.dart';
import 'package:birthday_gift/feature/person/domain/usecase/create_or_update_product.dart';
import 'package:birthday_gift/feature/person/domain/usecase/get_persons.dart';
import 'package:birthday_gift/feature/person/domain/usecase/listen_person.dart';
import 'package:birthday_gift/feature/person/domain/usecase/persons_sort.dart';
import 'package:birthday_gift/feature/person/presentation/list/person_list_cubit.dart';
import 'package:birthday_gift/feature/person/presentation/manage/person_manage_cubit.dart';
import 'package:birthday_gift/app/data/datasource/notification_datasource.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:birthday_gift/feature/person/presentation/approve/notification_approve_cubit.dart';

import '../data/datasource/worker_datasource.dart';
import '../data/repository/person_repository.dart';

final sl = GetIt.instance;

Future<void> init(
  SharedPreferences sharedPreferences,
) async {
  sl.registerSingleton<Box<UserEntity>>(await UserEntity.createBox());
  sl.registerSingleton<Box<PersonEntity>>(await PersonEntity.createBox());
  sl.registerSingleton<Box<NoteEntity>>(await NoteEntity.createBox());
  sl.registerSingleton<Box<RemindNotificationEntity>>(await RemindNotificationEntity.createBox());
  sl.registerSingleton<Box<ShownNotificationEntity>>(await ShownNotificationEntity.createBox());

  sl.registerSingleton(await SharedPreferences.getInstance());

  sl.registerLazySingleton(() => PersonRepository(sl()));
  sl.registerLazySingleton(() => PersonDao(sl()));
  sl.registerLazySingleton(() => UserDao(sl()));
  sl.registerLazySingleton(() => SettingsDao(sl()));
  sl.registerLazySingleton(() => ShownNotificationDao(sl()));

  final notificationDatasource = NotificationDataSource();
  await notificationDatasource.requestPermission();
  await notificationDatasource.init();
  sl.registerSingleton(notificationDatasource);

  final WorkerDatasource workerDatasource = WorkerDatasource();
  await workerDatasource.init();
  sl.registerSingleton(workerDatasource);

  sl.registerFactory(() => GetVersionWithUpdateCubit(sl()));
  sl.registerFactory(() => CreateOrUpdatePerson(sl()));
  sl.registerFactory(() => GetPersons(sl(), sl()));
  sl.registerFactory(() => ListenPersons(sl(), sl()));
  sl.registerFactory(() => PersonsSort());
  sl.registerFactory(() => ApproveNotification(sl()));

  sl.registerFactory(() => PersonListCubit(sl()));
  sl.registerFactory(() => PersonManagerCubit(sl()));
  sl.registerFactory(() => NotificationApproveCubit(sl(), sl()));
  sl.registerFactory(() => CurrentUserCubit(sl()));

  await _initUser();
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
  sl.registerFactory(() => GetCurrentUser(sl()));
}
