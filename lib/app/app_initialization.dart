import 'dart:async';

import 'package:birthday_gift/app/data/repository/notification_repository.dart';
import 'package:birthday_gift/core/data_source/local_source/entity/note_entity.dart';
import 'package:birthday_gift/core/data_source/local_source/entity/notification_entity.dart';
import 'package:birthday_gift/core/data_source/local_source/entity/remind_notification_entity.dart';
import 'package:birthday_gift/core/data_source/local_source/entity/shown_notification_entity.dart';
import 'package:birthday_gift/core/data_source/local_source/entity/user_entity.dart';
import 'package:birthday_gift/core/data_source/remote_source/firebase_auth_remote_source.dart';
import 'package:birthday_gift/feature/user/data/auth_firebase_error_handler.dart';
import 'package:birthday_gift/utils/base/base_cubit.dart';
import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di/injection_container.dart' as di;
import 'di/injection_container.dart';

Future initApp() async {
  await Firebase.initializeApp();
  Log.initialize([ConsolePrintLogger()]);
  ErrorHandler.setErrorHandlers([AuthFirebaseErrorHandler()]);
  await initHive();
  await _initDi();
  await Firebase.initializeApp();
  unawaited(_asyncInit());
  // FlutterError.onError = (FlutterErrorDetails details) {
  //   FlutterError.dumpErrorToConsole(details);
  //   FirebaseCrashlytics.instance.recordFlutterFatalError;
  // };
}

Future _initDi() async {
  await di.init(
      await SharedPreferences.getInstance(),
  );
}

Future _asyncInit() async {
  try {
    final firebaseAuthRemoteSource = sl<FirebaseAuthRemoteSource>();
    await firebaseAuthRemoteSource.getAuthorizedUser();
  } catch (e) {
    Log.w(e);
  }

  try {
    final notificationRepository = sl<NotificationRepository>();
    await notificationRepository.syncToRemote();
  } catch (e) {
    Log.w(e);
  }
}

Future initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NotificationEntityAdapter());
  Hive.registerAdapter(UserEntityAdapter());
  Hive.registerAdapter(NoteEntityAdapter());
  Hive.registerAdapter(RemindNotificationEntityAdapter());
  Hive.registerAdapter(ShownNotificationEntityAdapter());
}