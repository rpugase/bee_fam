import 'package:birthday_gift/utils/cache/dao/user_dao.dart';
import 'package:birthday_gift/utils/cache/dao/person_dao.dart';
import 'package:birthday_gift/utils/cache/entity/note_entity.dart';
import 'package:birthday_gift/utils/cache/entity/person_entity.dart';
import 'package:birthday_gift/utils/cache/entity/remind_notification_entity.dart';
import 'package:birthday_gift/utils/cache/entity/user_entity.dart';
import 'package:birthday_gift/feature/person/data/repository/person_repository.dart';
import 'package:birthday_gift/feature/person/domain/usecase/create_or_update_product.dart';
import 'package:birthday_gift/feature/person/domain/usecase/get_persons.dart';
import 'package:birthday_gift/feature/person/domain/usecase/listen_person.dart';
import 'package:birthday_gift/feature/person/domain/usecase/persons_sort.dart';
import 'package:birthday_gift/feature/person/presentation/list/person_list_cubit.dart';
import 'package:birthday_gift/feature/person/presentation/manage/person_manage_cubit.dart';
import 'package:birthday_gift/utils/notification/notification_datasource.dart';
import 'package:birthday_gift/utils/worker/worker_datasource.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> init(
  Box<UserEntity> boxUser,
  Box<PersonEntity> boxPerson,
  Box<NoteEntity> boxNote,
  Box<RemindNotificationEntity> boxRemindNotification,
) async {
  sl.registerSingleton<Box<UserEntity>>(boxUser);
  sl.registerSingleton<Box<PersonEntity>>(boxPerson);
  sl.registerSingleton<Box<NoteEntity>>(boxNote);
  sl.registerSingleton<Box<RemindNotificationEntity>>(boxRemindNotification);

  sl.registerLazySingleton(() => PersonRepository(sl()));
  sl.registerLazySingleton(() => PersonDao(sl(), sl(), sl()));
  sl.registerLazySingleton(() => UserDao(sl()));

  final notificationDatasource = NotificationDatasource();
  await notificationDatasource.request();
  await notificationDatasource.init();
  sl.registerSingleton(notificationDatasource);

  final WorkerDatasource workerDatasource = WorkerDatasource();
  // await workerDatasource.init();
  sl.registerSingleton(workerDatasource);

  sl.registerFactory(() => CreateOrUpdatePerson(sl()));
  sl.registerFactory(() => GetPersons(sl(), sl()));
  sl.registerFactory(() => ListenPersons(sl(), sl()));
  sl.registerFactory(() => PersonsSort());

  sl.registerFactory(() => PersonListCubit(sl()));
  sl.registerFactory(() => PersonManagerCubit(sl()));
}
